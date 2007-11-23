Message-ID: <474734E7.2030903@leipzig.freifunk.net>
Date: Fri, 23 Nov 2007 21:15:35 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] gateway-tunnel crashes with multiple net-dev
References: <473F0B87.9050002@leipzig.freifunk.net>
	<200711191057.07530.lindner_marek@yahoo.de>
In-Reply-To: <200711191057.07530.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
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

Marek Lindner schrieb:
> Hi,
>
> it seems not to be a crash. The batman client destroys the gate0 interface 
> after too many tries or is the daemon really dead ?
> The problem Antonio mentions has been fixed with rev799.
>
>   
>> I dont know how this gateway-tunnels really works, but i think this
>> pseudo-NAT on gate0 not really works or send wrong source-IP or what
>> else...
>>     
>
> I saw this problem from time to time but it comes and goes. Can you reproduce 
> that everytime ? 

Yes.

> If so could you provide a step by step explanation to 
> reproduce it ? So far I saw this kind of behaviour with alias interfaces 
> only.

I do nothing spezial. I have multiple network-interface in my laptop.
ATM is only one, my LAN up, but without default-route.

----------------
 root@tetzlav # killall batmand

 root@tetzlav # ip addr
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
1018: wifi0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast
qlen 199
    link/ieee802.11 00:90:4b:dc:07:e1 brd ff:ff:ff:ff:ff:ff
1020: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast
qlen 100
    link/ether 00:09:6b:3f:cb:9d brd ff:ff:ff:ff:ff:ff
    inet 192.168.105.254/24 brd 192.168.105.255 scope global eth0
    inet6 fe80::209:6bff:fe3f:cb9d/64 scope link
       valid_lft forever preferred_lft forever
1021: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether 00:01:03:81:c3:8f brd ff:ff:ff:ff:ff:ff
1022: ath0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc noqueue
    link/ether 06:90:4b:dc:07:e1 brd ff:ff:ff:ff:ff:ff
    inet 10.61.17.105/8 brd 10.255.255.255 scope global ath0
    inet6 fe80::490:4bff:fedc:7e1/64 scope link
       valid_lft forever preferred_lft forever

 root@tetzlav # ip rule
0:      from all lookup 255
32766:  from all lookup main
32767:  from all lookup default

 root@tetzlav # ip route
192.168.105.0/24 dev eth0  proto kernel  scope link  src 192.168.105.254
10.0.0.0/8 dev ath0  proto kernel  scope link  src 10.61.17.105

 root@tetzlav # ./batmand -r2 ath0 && ./batmand -cd3
Using interface ath0 with address 10.61.17.105 and broadcast address
10.255.255.255
Adding route to 10.61.17.35 via 0.0.0.0 (table 66 - ath0)
Found new gateway 10.61.17.35 -> class: 159 - 768KBit/768KBit
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 253, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (10.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.61.17.35 (gw_flags: 159, tq: 255, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.61.17.35
Adding default route via gate0 (table 68)

 root@tetzlav # tcpdump -vvvni gate0
tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back
to cooked socket
tcpdump: listening on gate0, link-type LINUX_SLL (Linux cooked), capture
size 96 bytes
21:08:58.728765 IP (tos 0x0, ttl  64, id 53795, offset 0, flags [DF],
proto: TCP (6), length: 82) 192.168.105.254.55130 > 64.12.25.140.5190: P
1879403238:1879403280(42) ack 3679889184 win 63071
21:08:58.729025 IP (tos 0x0, ttl  64, id 53796, offset 0, flags [DF],
proto: TCP (6), length: 40) 192.168.105.254.55130 > 64.12.25.140.5190:
., cksum 0xec07 (correct), 42:42(0) ack 1 win 63071
tcpdump: pcap_loop: recvfrom: Network is down
2 packets captured
2 packets received by filter
0 packets dropped by kernel

------------------

root@17-35:~# batmand -cd3
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105
Gateway - assigned 169.254.0.1 to client: 10.61.17.105

root@17-35:~# logread
Nov 23 21:10:46 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:10:48 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:10:50 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:11:04 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:11:22 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:11:28 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:11:47 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254) 
Nov 23 21:11:50 (none) daemon.err batmand[26508]: Error - got packet
from unknown client: 10.61.17.105 (virtual ip 192.168.105.254)

----------------

Regards
tetzlav
