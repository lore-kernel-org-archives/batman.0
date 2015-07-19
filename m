Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 19 Jul 2015 15:28:23 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150719132823.GA7888@odroid>
References: <1437120223-11556-1-git-send-email-sven@narfation.org>
 <1437120223-11556-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1437120223-11556-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Avoid crashing kernel
 with multicast asserts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Sounds good, that'll probably spare us some discussions about
BUG_ON()s on netdev :).

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>


On Fri, Jul 17, 2015 at 10:03:43AM +0200, Sven Eckelmann wrote:
> The BUG_ON added to the multicast code in commit 7f220ed1f063 ("batman-adv:
> Fix potential synchronization issues in mcast tvlv handler") will crash the
> kernel when the statement is true. This is not strictly required and a
> WARN_ON is enough to raise attention.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: Change commit message to new git commit description style
> 
>  net/batman-adv/multicast.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 25ed931..d71c70e 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -618,7 +618,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(!hlist_unhashed(node));
> +		WARN_ON(!hlist_unhashed(node));
>  
>  		hlist_add_head_rcu(node, head);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> @@ -629,7 +629,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(hlist_unhashed(node));
> +		WARN_ON(hlist_unhashed(node));
>  
>  		hlist_del_init_rcu(node);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> @@ -663,7 +663,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(!hlist_unhashed(node));
> +		WARN_ON(!hlist_unhashed(node));
>  
>  		hlist_add_head_rcu(node, head);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> @@ -674,7 +674,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(hlist_unhashed(node));
> +		WARN_ON(hlist_unhashed(node));
>  
>  		hlist_del_init_rcu(node);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> @@ -708,7 +708,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(!hlist_unhashed(node));
> +		WARN_ON(!hlist_unhashed(node));
>  
>  		hlist_add_head_rcu(node, head);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> @@ -719,7 +719,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
>  
>  		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
>  		/* flag checks above + mcast_handler_lock prevents this */
> -		BUG_ON(hlist_unhashed(node));
> +		WARN_ON(hlist_unhashed(node));
>  
>  		hlist_del_init_rcu(node);
>  		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
> -- 
> 2.1.4
> 
