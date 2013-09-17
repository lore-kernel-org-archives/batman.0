Return-Path: <marco.dallato@gmail.com>
Message-ID: <523884B6.7080708@gmail.com>
Date: Tue, 17 Sep 2013 18:35:02 +0200
From: Marco Dalla Torre <marco.dallato@gmail.com>
MIME-Version: 1.0
References: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
 <20130917155120.GD3053@neomailbox.net>
In-Reply-To: <20130917155120.GD3053@neomailbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batctl tcpdump: add IPv6 support to
 tcpdump parser
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
To: b.a.t.m.a.n@lists.open-mesh.org

Antonio,

On 09/17/13 17:51, Antonio Quartulli wrote:
> On Tue, Sep 17, 2013 at 02:08:14PM +0200, Marco Dalla Torre wrote:
>> +	switch (iphdr->ip6_nxt) {
>> +	case IPPROTO_ICMPV6:
>> +		LEN_CHECK(
>> +			(size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
>> +			sizeof(struct icmp6_hdr),
>> +			"ICMPv6");
>> +		icmphdr = (struct icmp6_hdr *)(packet_buff +
>> +					       sizeof(struct ip6_hdr));
>> +		inet_ntop(AF_INET6, &(iphdr->ip6_src), nd_ipv6_addr, 40);
>> +		printf("IPv6 %s > ", nd_ipv6_addr);
>> +		switch (icmphdr->icmp6_type) {
>> +		case ICMP6_DST_UNREACH:
>> +			if ((size_t)(buff_len) < IPV6_MIN_MTU) {
>> +				fprintf(stderr,
>> +					"Warning - dropping received 'ICMPv6 destination unreached' packet as it is bigger than maximum allowed size (%u): %zu\n",
>> +					IPV6_MIN_MTU, (size_t)(buff_len));
>
> Is the message wrong? should it be the other way around? "packet is smaller than
> minimum size" ? And why should _only_ this ICMP packet be bigger of IPV6_MIN_MTU
> ?
>
> Cheers,
>

Ehm, sort of... I believe the error is that the check is the other way 
around. If I remember correctly I included the guard after reading this 
from http://tools.ietf.org/html/rfc4443#section-2.4 :

"Every ICMPv6 error message (type < 128) MUST include as much of
the IPv6 offending (invoking) packet (the packet that caused the
error) as possible without making the error message packet exceed
the minimum IPv6 MTU"

With that in mind, the check should really be:

"((size_t)(buff_len) > IPV6_MIN_MTU"

The message should be ok.
And it should be done for all the error messages.

>>
>>>>> +
>>>>>  #define LEN_CHECK(buff_len, check_len, desc) \
>>>>>  if ((size_t)(buff_len) < (check_len)) { \
>>>>>  	fprintf(stderr, "Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
>>>>> @@ -188,11 +192,210 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
>>>>>  	}
>>>>>  }
>>>>>
>>>>> +static void parse_tcp(
>>> Why don't you call this function dump_tcp like all the other dump_* ?
>>
>> Because, I wasn't aware of this rule. Now I know! :P
>
> They are all over in the same file
>

Yes, but there also was that very one "parse_eth_hdr" that must have 
completely captivated my attention :D
Jokes aside, I'll try to pay more attention to the semantics behind 
prefixes in names. Maybe the problem is that some OO-formed guys like me 
are just not used to have that inside function names... :)


Thanks,
Marco
