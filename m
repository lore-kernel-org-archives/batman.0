From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] gateway-tunnel crashes with multiple net-dev
Date: Sat, 24 Nov 2007 18:16:31 +0100
References: <473F0B87.9050002@leipzig.freifunk.net>
	<200711191057.07530.lindner_marek@yahoo.de>
	<474734E7.2030903@leipzig.freifunk.net>
In-Reply-To: <474734E7.2030903@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711241816.31241.lindner_marek@yahoo.de>
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

> I do nothing spezial. I have multiple network-interface in my laptop.
> ATM is only one, my LAN up, but without default-route.

I still can't reproduce it. Help me to find the difference in our setups.
Could you send me a wireshark file from the packets in question ?

My setup:
One gateway and one client. Please make sure to use the latest revision.

Gateway:

ip addr
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:e0:7d:de:61:58 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.2/24 brd 192.168.100.255 scope global eth0
    inet 105.131.131.1/8 brd 105.255.255.255 scope global eth0:bat
    inet6 fe80::2e0:7dff:fede:6158/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ieee1394 00:02:3c:00:20:00:84:02 brd ff:ff:ff:ff:ff:ff:ff:ff
5: sit0: <NOARP> mtu 1480 qdisc noop
    link/sit 0.0.0.0 brd 0.0.0.0
10: gate0: <POINTOPOINT,MULTICAST,NOARP,UP,10000> mtu 1471 qdisc pfifo_fast 
qlen 500
    link/[65534]
    inet 169.254.0.0/32 scope global gate0

ip rule
0:      from all lookup local
6600:   from all to 105.0.0.0/8 lookup 66
6699:   from all lookup 65
6700:   from all to 105.0.0.0/8 lookup 67
32766:  from all lookup main
32767:  from all lookup default

batmand -d 3 -g 2000 eth0:bat
WARNING: You are using the unstable batman branch. If you are interested in 
*using* batman get the latest stable release !
Using interface eth0:bat with address 105.131.131.1 and broadcast address 
105.255.255.255
B.A.T.M.A.N. 0.3-beta (compatibility version 4)
Warning - batgat kernel modul interface (/dev/batgat) not usable: No such file 
or directory
This may decrease the performance of batman!
debug level: 3
gateway class: 41 -> propagating: 2048KBit/512KBit
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
Adding route to 105.1.1.1 via 0.0.0.0 (table 66 - eth0:bat)
Gateway - assigned 169.254.0.1 to client: 105.1.1.1



Client: 

ip addr
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:16:d3:b7:3b:41 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.4/24 brd 192.168.100.255 scope global eth0
    inet 105.1.1.1/8 brd 105.255.255.255 scope global eth0:bat
    inet6 fe80::216:d3ff:feb7:3b41/64 scope link
       valid_lft forever preferred_lft forever
3: irda0: <NOARP> mtu 2048 qdisc noop qlen 8
    link/irda 00:00:00:00 brd ff:ff:ff:ff
7: eth2: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:1b:77:3f:17:ea brd ff:ff:ff:ff:ff:ff
    inet 105.1.1.1/8 brd 105.255.255.255 scope global eth2
    inet6 fe80::21b:77ff:fe3f:17ea/64 scope link
       valid_lft forever preferred_lft forever
8: gate0: <POINTOPOINT,MULTICAST,NOARP,UP,10000> mtu 1471 qdisc pfifo_fast 
qlen 500 link/[65534]   inet 169.254.0.1/32 scope global gate0

ip rule
0:      from all lookup local
6600:   from all to 105.0.0.0/8 lookup 66
6699:   from all lookup 65
6700:   from all to 105.0.0.0/8 lookup 67
6800:   from all iif lo lookup 68
6801:   from 127.0.0.0/8 lookup 68
6802:   from 192.168.100.0/24 lookup 68
6803:   from 105.0.0.0/8 lookup 68
32766:  from all lookup main
32767:  from all lookup default

ip route ls table 68
throw 192.168.100.0/24  proto static
throw 105.0.0.0/8  proto static
throw 127.0.0.0/8  proto static
default dev gate0  proto static  scope link  src 169.254.0.1

batmand -r 2 -d 3 eth0:bat
WARNING: You are using the unstable batman branch. If you are interested in 
*using* batman get the latest stable release !
Using interface eth0:bat with address 105.1.1.1 and broadcast address 
105.255.255.255
B.A.T.M.A.N. 0.3-beta (compatibility version 4)
Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
Adding throw route to 192.168.100.0/24 via 0.0.0.0 (table 68 - eth0)
Adding throw route to 105.0.0.0/8 via 0.0.0.0 (table 68 - eth0:bat)
Adding throw route to 105.0.0.0/8 via 0.0.0.0 (table 68 - eth2)
Error - can't add throw route to 105.0.0.0/8 via 0.0.0.0 (table 68): File 
exists
debug level: 3
routing class: 2
Adding route to 105.131.131.1 via 0.0.0.0 (table 66 - eth0:bat)
Found new gateway 105.131.131.1 -> class: 41 - 2048KBit/512KBit
Adding default route to 105.131.131.1 (gw_flags: 41, tq: 253, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 105.131.131.1
Adding default route via gate0 (table 68)


Regards,
Marek
