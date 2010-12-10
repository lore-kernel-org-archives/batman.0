Return-Path: <andrew@lunn.ch>
Date: Fri, 10 Dec 2010 14:07:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101210130752.GA827@lunn.ch>
References: <20101207221351.GA19474@Sellars>
	<1291761150-29818-18-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291761150-29818-18-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 18/20] batman-adv: Still flood multicast
 packets we are not a receiver of
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Linus L??ssing <linus.luessing@saxnet.de>

On Tue, Dec 07, 2010 at 11:32:28PM +0100, Linus L??ssing wrote:
> We may only optimize the multicast packet flow, if an mcast_mode has been
> activated and if we are a multicast receiver of the same group. Otherwise
> flood the multicast packet without optimizations.
> 
> This allows us to still flood multicast packets of protocols where it is
> not easily possible for a multicast sender to be a multicast receiver of
> the same group instead of dropping them (for instance IPv6 NDP).
> 
> This commit therefore also makes IPv6 usable again, if the
> proact_tracking multicast mode has been activated.
> 
> Signed-off-by: Linus L??ssing <linus.luessing@saxnet.de>
> ---
>  multicast.c      |   25 +++++++++++++++++++++++++
>  multicast.h      |    1 +
>  soft-interface.c |    2 +-
>  3 files changed, 27 insertions(+), 1 deletions(-)
> 
> diff --git a/multicast.c b/multicast.c
> index 042d392..1f84f7c 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -107,6 +107,31 @@ void mcast_tracker_reset(struct bat_priv *bat_priv)
>  	start_mcast_tracker(bat_priv);
>  }
>  
> +inline int mcast_may_optimize(uint8_t *dest, struct net_device *soft_iface) {
> +	MC_LIST *mc_entry;
> +	unsigned long flags;
> +	struct bat_priv *bat_priv = netdev_priv(soft_iface);
> +	int mcast_mode = atomic_read(&bat_priv->mcast_mode);
> +

> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -391,7 +391,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
>  
>  		if (is_broadcast_ether_addr(ethhdr->h_dest))
>  			bcast_dst = true;
> -		else if (atomic_read(&bat_priv->mcast_mode) == MCAST_MODE_PROACT_TRACKING)
> +		else if (mcast_may_optimize(ethhdr->h_dest, soft_iface))
>  			mcast_dst = true;
>  		else
>  			bcast_dst = true;

You define mcast_may_optimize as inline, and then use it from a
different file. This makes the inline pointless, as far as i know.

	  Andrew
