Return-Path: <ordex@autistici.org>
Date: Fri, 13 May 2011 15:05:12 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110513130512.GB27480@ritirata.org>
References: <20110511001749.GA18190@ritirata.org>
	<1305117877-31345-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305117877-31345-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Add missing
 hardif_free_ref in forw_packet_free
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

I tried the patch and it fixes the issu I reported!

Thanks Sven!

On Wed, May 11, 2011 at 02:44:37PM +0200, Sven Eckelmann wrote:
> add_bcast_packet_to_list increases the refcount for if_incoming but the
> reference count is never decreased. This is an regression introduced by
> 89079aec4c0c2c60a3a2561afcce62538cebd71d.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is not ready to be applied - just a first note. And before
> someone asks - no, it doesn't fix the problem.
> 
>  aggregation.c |   14 +++++++++++---
>  send.c        |    2 ++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/aggregation.c b/aggregation.c
> index 9b94590..a8c3203 100644
> --- a/aggregation.c
> +++ b/aggregation.c
> @@ -23,6 +23,7 @@
>  #include "aggregation.h"
>  #include "send.h"
>  #include "routing.h"
> +#include "hard-interface.h"
>  
>  /* calculate the size of the tt information for a given packet */
>  static int tt_len(struct batman_packet *batman_packet)
> @@ -105,12 +106,15 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
>  	struct forw_packet *forw_packet_aggr;
>  	unsigned char *skb_buff;
>  
> +	if (!atomic_inc_not_zero(&if_incoming->refcount))
> +		return;
> +
>  	/* own packet should always be scheduled */
>  	if (!own_packet) {
>  		if (!atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
>  			bat_dbg(DBG_BATMAN, bat_priv,
>  				"batman packet queue full\n");
> -			return;
> +			goto out;
>  		}
>  	}
>  
> @@ -118,7 +122,7 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
>  	if (!forw_packet_aggr) {
>  		if (!own_packet)
>  			atomic_inc(&bat_priv->batman_queue_left);
> -		return;
> +		goto out;
>  	}
>  
>  	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
> @@ -133,7 +137,7 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
>  		if (!own_packet)
>  			atomic_inc(&bat_priv->batman_queue_left);
>  		kfree(forw_packet_aggr);
> -		return;
> +		goto out;
>  	}
>  	skb_reserve(forw_packet_aggr->skb, sizeof(struct ethhdr));
>  
> @@ -164,6 +168,10 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
>  	queue_delayed_work(bat_event_workqueue,
>  			   &forw_packet_aggr->delayed_work,
>  			   send_time - jiffies);
> +
> +	return;
> +out:
> +	hardif_free_ref(if_incoming);
>  }
>  
>  /* aggregate a new packet into the existing aggregation */
> diff --git a/send.c b/send.c
> index f30d0c6..6e83e23 100644
> --- a/send.c
> +++ b/send.c
> @@ -377,6 +377,8 @@ static void forw_packet_free(struct forw_packet *forw_packet)
>  {
>  	if (forw_packet->skb)
>  		kfree_skb(forw_packet->skb);
> +	if (forw_packet->if_incoming)
> +		hardif_free_ref(forw_packet->if_incoming);
>  	kfree(forw_packet);
>  }
>  
> -- 
> 1.7.5.1

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
