Message-ID: <482A54A5.5030302@gmx.net>
Date: Wed, 14 May 2008 04:55:33 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Multiple radios to improve throughput
References: <30773.75.128.50.239.1210728113.squirrel@corp.changind.com>
In-Reply-To: <30773.75.128.50.239.1210728113.squirrel@corp.changind.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Shane -

if all radios are operating on the same channel you can't expect any 
improvement. So operate one link on channel 1 and the other on channel 
11, 13 or 14 according to the regulations in your country. Channels in 
the 5 GHz range are even better ;-)

Note also that many embedded devices have not enough CPU power to 
saturate the capacity of a single radio link operating at full speed. At 
54 Mbit a single link can have approx. 3 MByte/sec throughput, but we 
have experienced that a 200 MHz MIPS CPU doesn't provide enough power 
for more than 1.2 to 1.6 MByte/sec with a single interface depending on 
the chipset/type of your wifi card.

cu elektra

 
> Hello,
>
> I have a 3 node mesh network with layout as follows:
>
>    node #1       node #2        node #3
> 192.168.2.1   192.168.2.5    192.168.2.9
>
> Each node has only one radio and #1 talks to #3 via #2 and vice versa.
> If I want to improve the throughput between #1 and #3, logically I would
> add another radio to #2 so it can communicate to both #1 and #3
> simultaneously w/o having the single radio switching back and forth
> between #1 and #3.
>
> However, I ran IPERF between #1 and #3 before and after adding the
> second radio to node #2 and the bandwidth didn't really improve.
> In my node #2 configuration, I did not bridge the two wifi interfaces so
> I have ath0 and ath1 with their own IP addresses.  All three nodes are
> configured with the same channel.  My batmand command line for node #2
> is:  batmand ath0 ath1.
>
> Can anyone advise me on what I did wrong?
>
> Thanks,
> Shane
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>   

