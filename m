Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 29 Oct 2016 04:32:40 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161029023240.GD7448@otheros>
References: <1468782245-12985-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468782245-12985-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: use consume_skb for
 non-dropped packets
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Jul 17, 2016 at 09:04:00PM +0200, Sven Eckelmann wrote:
> kfree_skb assumes that an skb is dropped after an failure and notes that.
> consume_skb should be used in non-failure situations. Such information is
> important for dropmonitor netlink which tells how many packets were dropped
> and where this drop happened.

Just a few, curious questions regarding why a kfree_skb()  was
chosen instead of a consume_skb() in a few places.

Especially so that I hopefully know which one best to use when
rebasing the "batman-adv: fix race conditions on interface
removal" patch :-).

> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c     | 13 ++++++++-----
>  net/batman-adv/fragmentation.c  | 20 ++++++++++++++------
>  net/batman-adv/network-coding.c | 24 +++++++++++++++---------
>  net/batman-adv/send.c           | 27 +++++++++++++++++++--------
>  net/batman-adv/send.h           |  3 ++-
>  net/batman-adv/soft-interface.c |  2 +-
>  6 files changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index a40cdf2..baf3d72 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -1786,8 +1787,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
>  	hlist_del(&forw_packet->list);
>  	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
>  
> -	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
> +	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
> +		dropped = true;
>  		goto out;
> +	}

Is this reallly a failure case?

> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
> index 0934730..461b77d 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -42,17 +42,23 @@
> @@ -73,7 +79,7 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
>  		spin_lock_bh(&chain->lock);
>  
>  		if (!check_cb || check_cb(chain)) {
> -			batadv_frag_clear_chain(&chain->head);
> +			batadv_frag_clear_chain(&chain->head, true);
>  			chain->size = 0;
>  		}

Hm, have you chosen kfree_skb() over consume_skb() because it
cannot easily be determined whether this call was from a failure
case or not?

> diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
> index 293ef4f..e924256 100644
> --- a/net/batman-adv/network-coding.c
> +++ b/net/batman-adv/network-coding.c
> @@ -611,7 +617,7 @@ static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
>  
>  	/* purge nc packet */
>  	list_del(&nc_packet->list);
> -	batadv_nc_packet_free(nc_packet);
> +	batadv_nc_packet_free(nc_packet, true);
>  
>  	res = true;

I could imagine, that with promiscious sniffing for coded packets,
outdated, coded packets happen frequently and is not necessarilly
a failure per se but to be expected.

On the other hand, missing a coding opportunity could have
happened due to some failure elsewhere (a broken wifi driver, a
noisy environment, ...).

In such an ambiguous case, should kfree_skb() be prefered over
consume_skb()?


> diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
> index 8d4e1f5..4f44ee2 100644
> --- a/net/batman-adv/send.c
> +++ b/net/batman-adv/send.c
> @@ -610,6 +616,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
>  	struct sk_buff *skb1;
>  	struct net_device *soft_iface;
>  	struct batadv_priv *bat_priv;
> +	bool dropped = false;
>  
>  	delayed_work = to_delayed_work(work);
>  	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
> @@ -621,11 +628,15 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
>  	hlist_del(&forw_packet->list);
>  	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
> 

> -	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
> +	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
> +		dropped = true;
>  		goto out;
> +	}

Same as above, why is this considered a failure case?

>  
> -	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
> +	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet)) {
> +		dropped = true;
>  		goto out;
> +	}

Why is this a failure? Isn't DAT supposed to drop things to avoid
a failure case (that is duplicate broadcast packets on the client
side)?

> @@ -699,7 +710,7 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
>  
>  		if (pending) {
>  			hlist_del(&forw_packet->list);
> -			batadv_forw_packet_free(forw_packet);
> +			batadv_forw_packet_free(forw_packet, true);
>  		}
>  	}
>  	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
> @@ -726,7 +737,7 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
>  
>  		if (pending) {
>  			hlist_del(&forw_packet->list);
> -			batadv_forw_packet_free(forw_packet);
> +			batadv_forw_packet_free(forw_packet, true);
>  		}
>  	}

These two above, again, why signaling a failure if it is a legitimate
shutdown process?


Regards, Linus
