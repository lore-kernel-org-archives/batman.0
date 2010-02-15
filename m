Return-Path: <post@tiwoc.de>
Message-ID: <4B79BAF4.3010105@tiwoc.de>
Date: Mon, 15 Feb 2010 22:21:56 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4B796833.2050205@tiwoc.de> <20100215162258.GL2900@lunn.ch>
In-Reply-To: <20100215162258.GL2900@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Record route for ICMP
	messages
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

Andrew Lunn schrieb:
>> +	uint8_t  rr[BAT_RR_LEN];
> 
> This might be more readable as
> 
>  uint8_t rr[BAT_RR_ENTRIES][ETH_ALEN];
> 
> and then your memcpy becomes
> 
> /* add record route information if not full */
> if (icmp_packet->rr_cur < BAT_RR_ENTRIES) {
> 	memcpy(icmp_packet->rr[icmp_packet->rr_cur++],
> 		ethhdr->h_dest, ETH_ALEN);
> }

You're right, this makes things easier => changed.

>>  ssize_t bat_device_write(struct file *file, const char __user *buff,
>> @@ -206,28 +210,42 @@
>>  {
>>  	struct device_client *device_client =
>>  		(struct device_client *)file->private_data;
>> -	struct icmp_packet icmp_packet;
>> +	struct icmp_packet_rr icmp_packet;
>>  	struct orig_node *orig_node;
>>  	struct batman_if *batman_if;
>>  	uint8_t dstaddr[ETH_ALEN];
>>  	unsigned long flags;
>> +	size_t packet_len = sizeof(struct icmp_packet);
>> +	int with_rr = 0;
>>
>>  	if (len < sizeof(struct icmp_packet)) {
>>  		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
>>  		return -EINVAL;
>>  	}
>>
>> -	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
>> +	if (len >= sizeof(struct icmp_packet_rr)) {
> 
> At first look, this looks wrong. I would of expected icmp_packet, not
> icmp_packet_rr. But maybe it is right?

It is right: At this point, the program doesn't know whether an
icmp_packet or an icmp_packet_rr is written. However, it can distinguish
these two by looking at the length of the data: if len >= sizeof(struct
icmp_packet_rr), the packet is long enough to include RR info and is
therefore treated as such.

>>  int recv_icmp_packet(struct sk_buff *skb)
>>  {
>> -	struct icmp_packet *icmp_packet;
>> +	struct icmp_packet_rr *icmp_packet;
>>  	struct ethhdr *ethhdr;
>>  	struct orig_node *orig_node;
>>  	struct sk_buff *skb_old;
>> @@ -860,8 +868,24 @@
>>  	if (!is_my_mac(ethhdr->h_dest))
>>  		return NET_RX_DROP;
>>
>> -	icmp_packet = (struct icmp_packet *) skb->data;
>> +	icmp_packet = (struct icmp_packet_rr *) skb->data;
>>
>> +	if (icmp_packet->packet_type == BAT_ICMP_RR) {
>> +		hdr_size = sizeof(struct icmp_packet_rr);
>> +
>> +		/* drop packet if it has not necessary minimum size */
>> +		if (skb_headlen(skb) < hdr_size)
>> +			return NET_RX_DROP;
>> +
>> +		/* add record route information if not full */
>> +		if (icmp_packet->rr_cur > 0
>> +			&& icmp_packet->rr_cur < BAT_RR_LEN / ETH_ALEN) {
>> +			memcpy(&(icmp_packet->rr[icmp_packet->rr_cur * ETH_ALEN]),
>> +				ethhdr->h_dest, ETH_ALEN);
> 
> Why rr_cur > 0?

For historical reasons ;-) rr_cur generally is the index for rr that
indicates the next position to be written to. In the first version of
the patch, a value of 0 for rr_cur indicated that RR is not active. This
is no longer neccessary => changed. Thanks for pointing out.

Regards, Daniel
