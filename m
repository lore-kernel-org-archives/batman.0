Return-Path: <marco.dallato@gmail.com>
Message-ID: <5238609E.5030705@gmail.com>
Date: Tue, 17 Sep 2013 16:01:02 +0200
From: Marco Dalla Torre <marco.dallato@gmail.com>
MIME-Version: 1.0
References: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
 <20130917123132.GB3053@neomailbox.net>
In-Reply-To: <20130917123132.GB3053@neomailbox.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On 09/17/13 14:31, Antonio Quartulli wrote:
> On Tue, Sep 17, 2013 at 02:08:14PM +0200, Marco Dalla Torre wrote:
>> >@@ -47,6 +49,8 @@
>> >  #define ETH_P_BATMAN	0x4305
>> >  #endif /* ETH_P_BATMAN */
>> >
>> >+#define IPV6_MIN_MTU	1280
> I have it in /usr/include/linux/ipv6.h don't you?
> If it has been introduced in a recent version of the headers, please add an
> #ifndef to avoid defining the symbol twice.
>

I'm aware of ipv6.h, in fact this is exactly where the definition I used 
comes from. Unfortunately including it in tcpdump.c generates all sort 
of namespace clashes with the other include statements, and I felt that 
doing namespace housecleaning was beyond the scope of the patch...
I'm not sure of what you mean with the #ifndef, since that statement is 
already present in the file.
Can you suggest a solution (or explain better what you meant if that one 
is the solution)?

>> >+
>> >  #define LEN_CHECK(buff_len, check_len, desc) \
>> >  if ((size_t)(buff_len) < (check_len)) { \
>> >  	fprintf(stderr, "Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
>> >@@ -188,11 +192,210 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
>> >  	}
>> >  }
>> >
>> >+static void parse_tcp(
> Why don't you call this function dump_tcp like all the other dump_* ?

Because, I wasn't aware of this rule. Now I know! :P

>
>> >+	unsigned char *packet_buff,
>> >+	ssize_t buff_len,
>> >+	size_t header_len,
>> >+	char *src_addr,
>> >+	char *dst_addr)
> Did we discuss this "freestyle" alignment in the last RFC?
>

For this and all the other styling problems like that: yes sorry when I 
wrote this patch some time ago I wasn't aware of these formatting rules. 
And I clearly failed correcting all while reviewing it...

>> >+{
>> >+	LEN_CHECK((size_t)buff_len - header_len,
>> >+		sizeof(struct tcphdr), "TCP");
>> >+	struct tcphdr *tcphdr;
> put all the declarations first and then perform the LEN_CHECK, like int he other
> functions.
>

Ok, it just didn't feel right to me to declare something even if you 
might even get to use it, but I can understand that from a style 
conformity point of view.

[...]

>> >+
>> >+	udphdr = (struct udphdr *)(packet_buff + header_len);
>> >+	printf("IP %s.%i > ",
>> >+		src_addr,
>> >+		ntohs(udphdr->source));
> does not fit on one line?

Yeah, it does now with the temporary variable, but when I did format it 
before introducing *udphdr was still much longer for one line... oh 
nevermind I'll fix it of course :)

>> >+
>> >+	switch (ntohs(udphdr->dest)) {
>> >+	case 67:
>> >+		LEN_CHECK(
>> >+			(size_t)buff_len - header_len - sizeof(struct udphdr),
>> >+			(size_t) 44,
>> >+			"DHCP");
> same alignment problem as before. If one argument is too long, feel free to use
> a temporary variable.

Ack.

[...]

>> >+			switch (icmphdr->icmp6_code) {
>> >+			case ICMP6_DST_UNREACH_NOPORT:
>> >+				tmp_iphdr = (struct ip6_hdr *)(((char *)icmphdr)
>> >+					    + sizeof(struct icmp6_hdr));
>> >+
>> >+				tmp_udphdr = (struct udphdr *)
>> >+					     ((char *)tmp_iphdr)
> there is no need for the parenthesis around the cast. and I'd suggest to cast to
> uint8_t or unsigned char. That is the 'recommended' type for this kind of pointer
> operations.

I'll keep it in mind, but I hope you don't mind if I sometimes happen to 
use them to clear things up for my poor C-untrained eye :-D

>> >+		case ICMP6_ECHO_REQUEST:
>> >+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
>> >+				  40);
>> >+			printf("%s: ICMPv6 echo request, id: %d, seq: %d, length: %hu\n",
>> >+			       nd_ipv6_addr, icmphdr->icmp6_id,
>> >+			       icmphdr->icmp6_seq, iphdr->ip6_plen);
>> >+			break;
>> >+		case ICMP6_ECHO_REPLY:
>> >+			inet_ntop(AF_INET6, &(iphdr->ip6_dst),
>> >+				  nd_ipv6_addr, 40);
>> >+			printf("%s: ICMPv6 echo reply, id: %d, seq: %d, length: %hu\n",
>> >+			       nd_ipv6_addr, icmphdr->icmp6_id,
>> >+			       icmphdr->icmp6_seq, iphdr->ip6_plen);
>> >+			break;
>> >+		case ICMP6_TIME_EXCEEDED:
>> >+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
>> >+				  40);
>> >+			printf("%s: ICMPv6 time exceeded in-transit, length %zu\n",
>> >+			       nd_ipv6_addr,
>> >+			       (size_t)buff_len - sizeof(struct icmp6_hdr));
>> >+			break;
>> >+		case ND_NEIGHBOR_SOLICIT:
>> >+			nd_neigh_sol = (struct nd_neighbor_solicit *)icmphdr;
>> >+
>> >+			inet_ntop(AF_INET6, &(nd_neigh_sol->nd_ns_target),
>> >+				  nd_ipv6_addr, 40);
>> >+			printf("NEIGHBOR SOLICITATION, Request who-has %s",
>> >+			       nd_ipv6_addr);
> Does (the real) tcpdump print "who-has" also in this case? I have not checked,
> but we try to reproduce the same output to avoid confusion and make it easier
> to read.
>

I wasn't aware of this "output equality" goal, I'll look into it.

>> >+
>> >+			inet_ntop(AF_INET6, &(iphdr->ip6_src), nd_ipv6_addr,
>> >+				  40);
>> >+			printf(" tell %s, length %zd\n", nd_ipv6_addr,
>> >+			       buff_len);
>> >+			break;
>> >+		case ND_NEIGHBOR_ADVERT:
>> >+			nd_advert = (struct nd_neighbor_advert *)icmphdr;
>> >+			inet_ntop(AF_INET6, &(nd_advert->nd_na_target),
>> >+				  nd_na_target, 40);
>> >+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
>> >+				  40);
>> >+			printf("NEIGHBOR ADVERTISEMENT, Reply to %s for target %s, length %zd\n",
> As above, check what tcpdump prints. I don't think it says "Reply" since there
> is no ARP Request/Reply in this case.

Yes, there is no ARP but the semantics in this case are pretty much the 
same. But as before, I'll look into it.

>> >  	switch (iphdr->protocol) {
>> >  	case IPPROTO_ICMP:
>> >-		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct icmphdr), "ICMP");
>> >+		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4),
>> >+			  sizeof(struct icmphdr), "ICMP");
> This change is unrelated to this patch.

For this and the others unrelated CHANGES: ok, didn't feel wrong to fix 
some offending formatting, but I'll revert those changes.
By the way: now I understand you! Fixing bad code formatting is like 
drugs! :D

>
> Cheers,
>
> -- Antonio Quartulli
>

Thanks,
Marco
