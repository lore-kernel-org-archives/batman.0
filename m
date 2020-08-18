Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [PATCH] batman-adv: bla: use netif_rx_ni when not in interrupt
 context
References: <20200818144610.8094-1-jussi.kivilinna@haltian.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <987760ed-17d2-d486-5dd1-d40418f62ac1@unstable.cc>
Date: Tue, 18 Aug 2020 22:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200818144610.8094-1-jussi.kivilinna@haltian.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Jussi Kivilinna <jussi.kivilinna@haltian.com>

Hi,

On 18/08/2020 16:46, Jussi Kivilinna wrote:
> batadv_bla_send_claim() gets called from worker thread context through
> batadv_bla_periodic_work(), thus netif_rx_ni needs to be used in that
> case. This fixes "NOHZ: local_softirq_pending 08" log messages seen
> when batman-adv is enabled.
> 
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@haltian.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> index 5c41cc52bc53..ab6cec3c7586 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -437,7 +437,10 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
>  	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
>  			   skb->len + ETH_HLEN);
>  
> -	netif_rx(skb);
> +	if (in_interrupt())
> +		netif_rx(skb);
> +	else
> +		netif_rx_ni(skb);

What's the downside in calling netif_rx_ni() all the times?
Is there any possible side effect?
(consider this call is not along the fast path)

On top of that, I just checked the definition of in_interrupt() and I
got this comment:

 * Note: due to the BH disabled confusion: in_softirq(),in_interrupt()
really
 *       should not be used in new code.


Check
https://elixir.bootlin.com/linux/latest/source/include/linux/preempt.h#L85

Is that something we should consider or is the comment bogus?


Regards,


>  out:
>  	if (primary_if)
>  		batadv_hardif_put(primary_if);
> 

-- 
Antonio Quartulli
