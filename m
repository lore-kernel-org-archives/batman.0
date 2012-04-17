Return-Path: <martin@hundeboll.net>
Message-ID: <4F8D6E8F.4080703@hundeboll.net>
Date: Tue, 17 Apr 2012 15:22:23 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<20120417071241.GA32239@ritirata.org>
In-Reply-To: <20120417071241.GA32239@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats()
	support
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

Thank you for your comments.

On 04/17/2012 09:12 AM, Antonio Quartulli wrote:
> On Tue, Apr 17, 2012 at 01:24:55 +0200, Martin Hundebøll wrote:
>> @@ -488,6 +492,8 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
>>   	arp_neigh_update(bat_priv, ip_src, hw_src);
>>   	arp_neigh_update(bat_priv, ip_dst, hw_dst);
>>
>> +	bat_priv->bat_stats.dat_reply_tx++;
>> +
>>   	/* Send the ARP reply to the candidates for both the IP addresses we
>>   	 * fetched from the ARP reply */
>>   	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
>
> Actually in dht_send_data() the skb is cloned and sent multiple times.
> Should we count all the skbs that we send out?

I would say that it should be up to the author of the code :)
  
>> @@ -498,3 +505,57 @@ static u32 bat_get_link(struct net_device *dev)
>>   {
>>   	return 1;
>>   }
>> +
>> +/* Inspired by drivers/net/ethernet/dlink/sundance.c:1702 */
>> +static const struct {
>> +	const char name[ETH_GSTRING_LEN];
>> +} bat_stats_strings[] = {
>> +	{ "forward" },
>> +	{ "mgmt_tx" },
>> +	{ "mgmt_rx" },
>> +	{ "tt_request_tx" },
>> +	{ "tt_request_rx" },
>> +	{ "tt_response_tx" },
>> +	{ "tt_response_rx" },
>> +	{ "tt_roam_adv_tx" },
>> +	{ "tt_roam_adv_rx" },
>> +	{ "dat_request_tx" },
>> +	{ "dat_request_rx" },
>> +	{ "dat_reply_tx" },
>> +	{ "dat_reply_rx" },
>> +};
>> +#define BAT_STATS_NUM 13
>
> Do you really need internal { } ?
> And why not using const char name* instead of name[N] ? All the strings are
> const char * and they are already in the constant space (however it is called).

As described on IRC, get_ethtool_stats() expects the strings to be aligned to ETH_GSTRING_LEN and in this way, we can copy all the strings in one chunk.
  
>> +
>> +static void bat_get_ethtool_stats(struct net_device *dev,
>> +				  struct ethtool_stats *stats, u64 *data)
>> +{
>> +	struct bat_priv *bat_priv = netdev_priv(dev);
>> +
>> +	data[0] = bat_priv->bat_stats.forward;
>> +	data[1] = bat_priv->bat_stats.mgmt_tx;
>> +	data[2] = bat_priv->bat_stats.mgmt_rx;
>> +	data[3] = bat_priv->bat_stats.tt_request_tx;
>> +	data[4] = bat_priv->bat_stats.tt_request_rx;
>> +	data[5] = bat_priv->bat_stats.tt_response_tx;
>> +	data[6] = bat_priv->bat_stats.tt_response_rx;
>> +	data[7] = bat_priv->bat_stats.tt_roam_adv_tx;
>> +	data[8] = bat_priv->bat_stats.tt_roam_adv_rx;
>> +	data[9] = bat_priv->bat_stats.dat_request_tx;
>> +	data[10] = bat_priv->bat_stats.dat_request_rx;
>> +	data[11] = bat_priv->bat_stats.dat_reply_tx;
>> +	data[12] = bat_priv->bat_stats.dat_reply_rx;
>> +}
>
> (guess mode ON) why using u64? what if the arch is 32bit? are the values
> correctly assigned anyway? what about longer addresses (do they exist?)?
> As Sven suggested on IRC, you probably want to use uintptr_t instead.

As you wrote in your later email, you should get more sleep :)

>> --- a/types.h
>> +++ b/types.h
>> @@ -162,9 +162,26 @@ struct bcast_duplist_entry {
>>   };
>>   #endif
>>
>> +struct bat_stats {
>> +	uint64_t forward;
>> +	uint64_t mgmt_tx;
>> +	uint64_t mgmt_rx;
>> +	uint64_t tt_request_tx;
>> +	uint64_t tt_request_rx;
>> +	uint64_t tt_response_tx;
>> +	uint64_t tt_response_rx;
>> +	uint64_t tt_roam_adv_tx;
>> +	uint64_t tt_roam_adv_rx;
>> +	uint64_t dat_request_tx;
>> +	uint64_t dat_request_rx;
>> +	uint64_t dat_reply_tx;
>> +	uint64_t dat_reply_rx;
>> +};
>
> see previous comment.
>
>
> One general comment: be consistent with integer types. I would suggest to use
> uint*_t only, instead of mixing u* and uint*_t.

Okay, so if you change bat_get_strings() and bat_get_ethtool_stats() to take uint64_t it is OK, although it is called with u64? (This is what I would prefer.)

> The last stuff we have to understand is if we can really use shared counters
> without having them as atomic_t or per_cpu variable...
>
> Sven linked me this page: http://lwn.net/Articles/22911/
> it seems that per_cpu variables should be used for network stats..but the effort
> to use them seems to be not negligible :-P

If we don't mind the performance penalty from using atomic_t, that can easily be changed. But keep in mind that I plan to add counters that are incremented for each and every packet.

To use per_cpu counters, I need to make dynamic allocations of these, which I would gladly do. I just didn't want to over complicate things in the first edition :)

Cheers!

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
