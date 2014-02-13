Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 11:52:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213105249.GH7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-19-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

On Tue, Feb 11, 2014 at 01:48:18PM +0100, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The phydev member of a net_device can be used to get
> information about an ethernet link like HALF/FULL_DUPLEX
> and advertised bandwidth (e.g. 100/10Mbps).
> 
> This information are then stored in the hard_iface object
> to be used during the metric computation routine.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_v_elp.c      |  8 ++++++++
>  bat_v_ogm.c      |  4 ++--
>  hard-interface.c | 19 +++++++++++++++++++
>  types.h          | 12 ++++++++++++
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/bat_v_elp.c b/bat_v_elp.c
> index 763113e..958843c 100644
> --- a/bat_v_elp.c
> +++ b/bat_v_elp.c
> @@ -78,6 +78,14 @@ batadv_v_elp_get_throughput(struct batadv_elp_neigh_node *neigh)
>  	if (throughput != 0)
>  		return throughput;
>  
> +	/* In case of Ethernet interface, the throughput has already been
> +	 * obtained from the phydev object in the net_device struct (see
> +	 * batadv_hardif_activate_interface()). So return this value.
> +	 */
> +	throughput = hard_iface->bat_v.eth_throughput;
> +	if (throughput != 0)
> +		return throughput;
> +
>  	/* if this is a wireless device, then ask its throughput through
>  	 * cfg80211 API
>  	 */
> diff --git a/bat_v_ogm.c b/bat_v_ogm.c
> index fa3d1a1..060ce80 100644
> --- a/bat_v_ogm.c
> +++ b/bat_v_ogm.c
> @@ -393,8 +393,8 @@ static uint32_t batadv_v_penalty(struct batadv_priv *bat_priv,
>  	/* proportion to use the same value used in batman iv (x * 128 / 256) */
>  	hop_penalty = hop_penalty * 100 / 255;
>  
> -	if (batadv_is_wifi_netdev(if_incoming->net_dev) &&
> -	    metric > link_metric / 10)
> +	if ((if_incoming->bat_v.flags & BATADV_FULL_DUPLEX) &&
> +	    (metric > link_metric / 10))
>  		return metric / 2;
>  
>  	return metric * (100 - hop_penalty) / 100;
> diff --git a/hard-interface.c b/hard-interface.c
> index 2a04130..58c8669 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -31,6 +31,8 @@
>  
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
> +#include <linux/netdevice.h>
> +#include <linux/phy.h>
>  
>  void batadv_hardif_free_rcu(struct rcu_head *rcu)
>  {
> @@ -297,6 +299,7 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
>  static void
>  batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
>  {
> +	struct net_device *dev = hard_iface->net_dev;
>  	struct batadv_priv *bat_priv;
>  	struct batadv_hard_iface *primary_if = NULL;
>  
> @@ -315,6 +318,22 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
>  	if (!primary_if)
>  		batadv_primary_if_select(bat_priv, hard_iface);
>  
> +	/* set the default values */
> +	hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
> +	hard_iface->bat_v.eth_throughput = 0;
> +	if (dev->phydev) {
> +		if (dev->phydev->duplex == DUPLEX_FULL)
> +			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
> +
> +		/* set the speed according to the phydev setting. Store the
> +		 * value in Kbps (as done for the other throughput variables)
> +		 */
> +		if (dev->phydev->speed != SPEED_UNKNOWN) {
> +			hard_iface->bat_v.eth_throughput = dev->phydev->speed;
> +			hard_iface->bat_v.eth_throughput *= 10;
> +		}
> +	}
> +

Hi Antonio

If i'm reading this correctly, you get the bandwidth once when the
interface is added to bat0? Are we sure that auto-negotiation has
finished? It can take a few seconds to complete after the interface is
brought up. It would not be good to have batman use 10Mbps/Half Duplex
on my gigabit links...

Is there a notification mechanism which could be used to keep these
values up to date? Or is that in a patch i have not yet got to?

       Andrew
