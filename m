Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Is netif_rx_ni safe from interrupt context? (Re: [PATCH] batman-adv:
 bla: use netif_rx_ni when not in interrupt context)
References: <20200818144610.8094-1-jussi.kivilinna@haltian.com>
 <987760ed-17d2-d486-5dd1-d40418f62ac1@unstable.cc>
From: Jussi Kivilinna <jussi.kivilinna@haltian.com>
Message-ID: <92c88618-23ec-2e30-1d79-b84f8d193bc3@haltian.com>
Date: Wed, 19 Aug 2020 10:39:52 +0300
In-Reply-To: <987760ed-17d2-d486-5dd1-d40418f62ac1@unstable.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Antonio Quartulli <a@unstable.cc>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, netdev@vger.kernel.org

Hello,

+CC netdev mailing-list

On 18.8.2020 23.12, Antonio Quartulli wrote:
> Hi,
> 
> On 18/08/2020 16:46, Jussi Kivilinna wrote:
>> batadv_bla_send_claim() gets called from worker thread context through
>> batadv_bla_periodic_work(), thus netif_rx_ni needs to be used in that
>> case. This fixes "NOHZ: local_softirq_pending 08" log messages seen
>> when batman-adv is enabled.
>>
>> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@haltian.com>
>> ---
>>  net/batman-adv/bridge_loop_avoidance.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
>> index 5c41cc52bc53..ab6cec3c7586 100644
>> --- a/net/batman-adv/bridge_loop_avoidance.c
>> +++ b/net/batman-adv/bridge_loop_avoidance.c
>> @@ -437,7 +437,10 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
>>  	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
>>  			   skb->len + ETH_HLEN);
>>  
>> -	netif_rx(skb);
>> +	if (in_interrupt())
>> +		netif_rx(skb);
>> +	else
>> +		netif_rx_ni(skb);
> 
> What's the downside in calling netif_rx_ni() all the times?
> Is there any possible side effect?
> (consider this call is not along the fast path)

Good question. I tried to find answer for this but found documentation being lacking 
on the issue, so I looked for examples and used 'in_interrupt/netif_rx/netif_rx_ni' 
bit that appears in few other places: 
 https://elixir.bootlin.com/linux/v5.8/source/drivers/net/caif/caif_hsi.c#L469
 https://elixir.bootlin.com/linux/v5.8/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c#L425
 https://elixir.bootlin.com/linux/v5.8/source/drivers/net/wireless/marvell/libertas/rx.c#L153
 https://elixir.bootlin.com/linux/v5.8/source/drivers/net/wireless/marvell/mwifiex/uap_txrx.c#L356
 https://elixir.bootlin.com/linux/v5.8/source/net/caif/chnl_net.c#L121

Maybe someone on netdev mailing-list could give hint on this matter - should 
'in_interrupt()?netif_rx(skb):netif_rx_ni(skb)' be used if context is not known or 
is just using 'netif_rx_ni(skb)' ok? 

> 
> On top of that, I just checked the definition of in_interrupt() and I
> got this comment:
> 
>  * Note: due to the BH disabled confusion: in_softirq(),in_interrupt()
> really
>  *       should not be used in new code.
> 
> 
> Check
> https://elixir.bootlin.com/linux/latest/source/include/linux/preempt.h#L85
> 
> Is that something we should consider or is the comment bogus?

It very well be that the existing code that I looked at may not be the best 
for reuse today.

-Jussi
