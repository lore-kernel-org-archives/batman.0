Return-Path: <an.langer@gmx.de>
Date: Mon, 5 Jul 2010 23:42:46 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100705234246.58a9209b@rechenknecht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman adv unicast fragmentation (version 3)
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

Hi,
thanks for the reply of the patch and all the hints. I changed some parts as you suggested and here some notes to your questions.

>> +			if (!(my_skb_push(frag_skb, hdr_len) >= 0 &&
>> +				my_skb_push(skb, hdr_len) >= 0)) {  

>Didn't you wanted to check if one of the my_skb_push failed and not if both
>failed?

This part check if one failed, but you are right if you think that it looks too complicated. I changed it because it is easy to misunderstand this expression.


>Can you please explain why the copyright already starts in 2007?
Copy and paste failure, changed it to 2010.

>> +			if (atomic_read(&batman_if->frag_seqno) == FRAG_MAX_SEQ)
>> +				atomic_set(&batman_if->frag_seqno, 0);  

>It is not a good idea to split two atomic_ operations which depends on each other.

I removed that part completely, because there is a simplier way.


And now some words to the implementation. This version of fragmentation handles only packets over a batX interface. My test setup follows:

laptop tap0 --> br0 (bat0/eth0) host1 eth1 ------> eth0 host2 -----> eth0 host3

ping -s 1472 -M do xxx

1472 bytes - data
28   bytes - icmp / ip
14   bytes - eth

Bat0 receives 1514 bytes (interface_tx, data_len), if data_len + unicast_packet is larger than the mtu of the sending interface, this packet will be fragmented.

In fragmentation 2.0 i would like to implement a solution for the problem described by simon ( i hope i understood him correctly). A node has two batman interfaces and the mtu of interface2 is smaller then interface1. In case a packet from iface1 (with the size of this mtu) travels to iface2, we currently have a problem. Version 2.0 will fix this.

regards,
andreas

