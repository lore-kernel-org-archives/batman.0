Message-ID: <4749C420.4010308@absorb.it>
Date: Mon, 26 Nov 2007 00:21:12 +0530
From: rene <batman@absorb.it>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
References: <4747BE35.3040307@absorb.it>	<200711251732.00986.axel@open-mesh.net>
	<4749A6DF.40106@absorb.it> <200711251855.23693.axel@open-mesh.net>
In-Reply-To: <200711251855.23693.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,

tested the ping, interestingly it used mostly the wrong IP for the
interface (eth1:1 is 192.168.40.144, not 192.168.41(!).144)

CASE1 - broken
----------------------------------------------------------------------
root@144:~# ./ping -I eth1:1 192.168.40.43
PING 192.168.40.43 (192.168.40.43) from 192.168.41.144 eth1:1: 56(84)
bytes of data.
64 bytes from 192.168.40.43: icmp_seq=1 ttl=64 time=3.46 ms
64 bytes from 192.168.40.43: icmp_seq=2 ttl=64 time=1.47 ms
64 bytes from 192.168.40.43: icmp_seq=3 ttl=64 time=5.90 ms
64 bytes from 192.168.40.43: icmp_seq=4 ttl=64 time=1.40 ms
64 bytes from 192.168.40.43: icmp_seq=5 ttl=64 time=1.40 ms
...

a tcpdump looks like:
root@144:~# tcpdump -i eth1:1 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1:1, link-type EN10MB (Ethernet), capture size 96 bytes
18:33:29.868686 IP 192.168.1.144 > 192.168.40.43: ICMP echo request, id
48764, seq 1, length 64
18:33:29.869863 IP 192.168.40.43 > 192.168.1.144: ICMP echo reply, id
48764, seq 1, length 64

CASE2 - ok
----------------------------------------------------------------------
root@144:~# ./ping -I eth1:1 192.168.40.43
PING 192.168.40.43 (192.168.40.43) from 192.168.40.144 eth1:1: 56(84)
bytes of data.
64 bytes from 192.168.40.43: icmp_seq=1 ttl=57 time=7.91 ms
64 bytes from 192.168.40.43: icmp_seq=2 ttl=57 time=7.77 ms

root@144:~# tcpdump -i eth1:1 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1:1, link-type EN10MB (Ethernet), capture size 96 bytes
18:29:51.015329 IP 192.168.40.144 > 192.168.40.43: ICMP echo request, id
13432, seq 23, length 64
18:29:52.025343 IP 192.168.40.144 > 192.168.40.43: ICMP echo request, id
13432, seq 24, length 64


CASE3 - ?? (the IP is right but packages using the wrong interface)
----------------------------------------------------------------------
root@144:~# ./ping -I 192.168.40.144 192.168.40.43
PING 192.168.40.43 (192.168.40.43) from 192.168.40.144 : 56(84) bytes of
data.
64 bytes from 192.168.40.43: icmp_seq=5 ttl=57 time=2116 ms
64 bytes from 192.168.40.43: icmp_seq=6 ttl=57 time=1117 ms
64 bytes from 192.168.40.43: icmp_seq=7 ttl=57 time=119 ms

and tcpdump:
root@144:~# tcpdump -i eth1:1 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1:1, link-type EN10MB (Ethernet), capture size 96 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel
root@144:~# tcpdump -i vlan1:1 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on vlan1:1, link-type EN10MB (Ethernet), capture size 96 bytes
18:43:21.685189 IP 192.168.40.144 > 192.168.40.43: ICMP echo request, id
62214, seq 30, length 64
18:43:21.735541 IP 192.168.40.43 > 192.168.40.144: ICMP echo reply, id
62214, seq 30, length 64
18:43:22.695179 IP 192.168.40.144 > 192.168.40.43: ICMP echo request, id
62214, seq 31, length 64
1

------------------------------------------------------------------------

Wow, seems a little disturbed the whole thing... Another Router showed
the same transmission problem with BATMAN, this time one that had only
one interface. Solving the problem seems somehow possible by killing
batmand (not removing the interfaces), waiting a few seconds and
starting batmand. after a few trials it works :)

Regards,
Rene
