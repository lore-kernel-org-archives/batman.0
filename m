Message-ID: <473F0B87.9050002@leipzig.freifunk.net>
Date: Sat, 17 Nov 2007 16:40:55 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] gateway-tunnel crashes with multiple net-dev 
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

Its me again... ;)

At first i thought this is a problem with our complex setup on the
freifunk-routers with olsr+batman on alias-interfaces and so on, but
know i testet batman on my Laptop and have the same problems with
multiple network interfaces and gateway-tunnels.
I dont know how this gateway-tunnels really works, but i think this
pseudo-NAT on gate0 not really works or send wrong source-IP or what else...


Regards
tetzlav

-----<tunnel-client>-----

 root@tetzlav #  ./batmand -v
B.A.T.M.A.N. 0.3-beta rv799 (compatibility version 4)

 root@tetzlav # ip addr | sed 's/\(..:..\):..:..:/\1:XX:XX:/'
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
    link/loopback 00:00:XX:XX:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
170: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:09:XX:XX:cb:9d brd ff:ff:ff:ff:ff:ff
    inet 192.168.105.254/24 brd 192.168.105.255 scope global eth0
    inet6 fe80::209:6bff:fe3f:cb9d/64 scope link
       valid_lft forever preferred_lft forever
171: eth2: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen
1000
    link/ether 00:01:XX:XX:c3:8f brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.2/24 brd 192.168.1.255 scope global eth2
    inet6 fe80::201:3ff:fe81:c38f/64 scope link
       valid_lft forever preferred_lft forever
174: wifi0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast
qlen 199
    link/ieee802.11 00:90:XX:XX:07:e1 brd ff:ff:ff:ff:ff:ff
175: ath0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc noqueue
    link/ether 06:90:XX:XX:07:e1 brd ff:ff:ff:ff:ff:ff
    inet 105.61.17.106/8 brd 105.255.255.255 scope global ath0
    inet6 fe80::490:4bff:fedc:7e1/64 scope link
       valid_lft forever preferred_lft forever

 root@tetzlav # ./batmand -r2 ath0 && ./batmand -cd3
Using interface ath0 with address 105.61.17.106 and broadcast address
105.255.255.255
Adding route to 105.61.17.35 via 0.0.0.0 (table 66 - ath0)
Adding route to 105.61.89.89/32 via 105.61.17.35 (table 65 - ath0)
Found new gateway 105.61.17.35 -> class: 65 - 16MBit/4MBit
Adding route to 105.61.17.17/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.13.18/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.89.81/32 via 105.61.17.35 (table 65 - ath0)
Adding route to 105.61.17.21/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.89.90/32 via 105.61.17.35 (table 65 - ath0)
Adding route to 105.61.17.32/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.17.18 via 0.0.0.0 (table 66 - ath0)
Deleting route to 105.61.17.18 via 0.0.0.0 (table 66 - ath0)
Adding route to 105.61.17.18/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.17.1/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.89.92/32 via 105.61.17.35 (table 65 - ath0)
Adding route to 105.61.18.12/32 via 105.61.17.35 (table 66 - ath0)
Adding route to 105.61.17.19/32 via 105.61.17.35 (table 66 - ath0)
Found new gateway 105.61.17.19 -> class: 41 - 2048KBit/512KBit
Adding default route to 105.61.17.35 (gw_flags: 65, tq: 240, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 105.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (105.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 105.61.17.35 (gw_flags: 65, tq: 240, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 105.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (105.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 105.61.17.35 (gw_flags: 65, tq: 240, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 105.61.17.35
Adding default route via gate0 (table 68)
Gateway client - gateway (105.61.17.35) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)

 root@tetzlav # while sleep 1; do tcpdump -vvvni gate0; done
16:07:13.079874 IP (tos 0x0, ttl   7, id 7998, offset 0, flags [none],
proto: ICMP (1), length: 64) 169.254.0.1 > 141.1.1.1: ICMP echo request,
id 56067, seq 32519, length 44
16:07:13.109311 IP (tos 0x0, ttl 248, id 0, offset 0, flags [none],
proto: ICMP (1), length: 56) 195.2.10.37 > 169.254.0.1: ICMP time
exceeded in-transit, length 36
        IP (tos 0x0, ttl   1, id 7998, offset 0, flags [none], proto:
ICMP (1), length: 64) 169.254.0.1 > 141.1.1.1: ICMP echo request, id
56067, seq 32519, length 44
16:07:13.207659 IP (tos 0x0, ttl   8, id 7999, offset 0, flags [none],
proto: ICMP (1), length: 64) 169.254.0.1 > 141.1.1.1: ICMP echo request,
id 56067, seq 32775, length 44
16:07:13.236168 IP (tos 0x0, ttl  57, id 56889, offset 0, flags [none],
proto: ICMP (1), length: 64) 141.1.1.1 > 169.254.0.1: ICMP echo reply,
id 56067, seq 32775, length 44
16:07:13.336254 IP (tos 0x0, ttl   1, id 8000, offset 0, flags [none],
proto: ICMP (1), length: 64) 169.254.0.1 > 141.1.1.1: ICMP echo request,
id 56067, seq 33031, length 44
16:07:13.337616 IP (tos 0xc0, ttl  64, id 56062, offset 0, flags [none],
proto: ICMP (1), length: 92) 169.254.0.0 > 169.254.0.1: ICMP time
exceeded in-transit, length 72
        IP (tos 0x0, ttl   1, id 8000, offset 0, flags [none], proto:
ICMP (1), length: 64) 169.254.0.1 > 141.1.1.1: ICMP echo request, id
56067, seq 33031, length 44
16:07:13.360347 IP (tos 0x0, ttl  64, id 10973, offset 0, flags [DF],
proto: TCP (6), length: 64) 192.168.105.254.47000 > 217.10.10.194.5223:
., cksum 0xe918 (correct), 3496148623:3496148635(12) ack 3669129091 win
2003 <nop,nop,timestamp 230212021 497584259>
tcpdump: pcap_loop: recvfrom: Network is down
29 packets captured
29 packets received by filter
0 packets dropped by kernel
tcpdump: SIOCGIFHWADDR: No such device
tcpdump: SIOCGIFHWADDR: No such device



-----<on batman-gateway>----

root@17-35:~# batmand -cd3
Deleting route to 105.61.18.12/32 via 105.61.89.92 (table 66 - vlan1:bat)
Adding route to 105.61.18.12/32 via 105.61.89.81 (table 66 - vlan1:bat)
Deleting route to 105.61.18.12/32 via 105.61.89.81 (table 66 - vlan1:bat)
Adding route to 105.61.18.12/32 via 105.61.89.92 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Deleting route to 105.61.17.18 via 0.0.0.0 (table 66 - eth2:bat)
Adding route to 105.61.17.18/32 via 105.61.89.81 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Deleting route to 105.61.17.18/32 via 105.61.89.81 (table 66 - vlan1:bat)
Adding route to 105.61.17.18 via 0.0.0.0 (table 66 - eth2:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Deleting route to 105.61.18.12/32 via 105.61.89.92 (table 66 - vlan1:bat)
Adding route to 105.61.18.12/32 via 105.61.89.81 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Deleting route to 105.61.18.12/32 via 105.61.89.81 (table 66 - vlan1:bat)
Adding route to 105.61.18.12/32 via 105.61.89.92 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Gateway - assigned 169.254.0.1 to client: 105.61.17.106
Gateway - assigned 169.254.0.1 to client: 105.61.17.106

root@17-35:~# logread -f
Nov 17 16:24:16 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:21 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:32 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:34 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:38 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:51 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:24:56 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:25:02 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254) 
Nov 17 16:25:04 (none) daemon.err batmand[12811]: Error - got packet
from unknown client: 105.61.17.106 (virtual ip 192.168.105.254)
