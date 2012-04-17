Return-Path: <martin@hundeboll.net>
Message-ID: <4F8D6F20.8060501@hundeboll.net>
Date: Tue, 17 Apr 2012 15:24:48 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<201204171019.32919.lindner_marek@yahoo.de>
In-Reply-To: <201204171019.32919.lindner_marek@yahoo.de>
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

Hi Marek,

On 04/17/2012 10:19 AM, Marek Lindner wrote:
> On Tuesday, April 17, 2012 01:24:55 Martin Hundebøll wrote:
>> Added additional counters in a bat_stats structure, which are exported
>> through the ethtool api. The counters are specific to batman-adv and
>> includes:
>>   forwarded packets
>>   management packets (OGMs at this point)
>>   translation table packets
>>   distributed arp table packets
>
> Looks very good! A few questions though:
>
>
>> @@ -869,6 +875,9 @@ static int route_unicast_packet(struct sk_buff *skb,
>> struct hard_iface *recv_if) /* decrement ttl */
>>   	unicast_packet->header.ttl--;
>>
>> +	/* Update stats counter */
>> +	bat_priv->bat_stats.forward++;
>
> Here we only count the number of packets. Would it be possible to also count
> the number of bytes ? Similar to tx_packets and tx_bytes ?
> Same for management tx/bytes.

Sure, if we want it, I can make it :)

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
> How do we handle code segments that are not compiled into the module ? We
> simply leave this counters hanging around at 0 ?

As I understand it, ethtool doesn't mind "unused" counters in general, so it comes down to the memory footprint of batman-adv. Do we want to clutter the code with ifdef's to save the memory?

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
