Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Dec 2015 23:39:35 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151207223935.GT27041@otheros>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
 doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>

On Mon, Nov 30, 2015 at 05:34:01PM +0100, Simon Wunderlich wrote:
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index eb76386..75fa501 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -802,7 +802,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
>  	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
>  	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
>  
> +	spin_lock_bh(&bat_priv->tt.commit_lock);
>  	batadv_mcast_mla_tt_retract(bat_priv, NULL);
> +	spin_unlock_bh(&bat_priv->tt.commit_lock);
>  }

See comments in the other thread before applying.
