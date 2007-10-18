Message-ID: <4717BE98.2010206@ddmesh.de>
Date: Thu, 18 Oct 2007 22:14:16 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] no gateway / tun interface / default route
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

Hello,

I have problems with the gateway. The following setup is used:

Laptop: batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1 --no-unreachable-rule --no-throw-rules --no-prio-rules --no-unresp-gw-check --resist-blocked-send wlan0 bbs /t 1 /i bbc /t 1 /i
wrt54gs: batmand batmand -d 4 -r 2 --t 63 --no-unreachable-rule --no-throw-rules --no-prio-rules --no-unresp-gw-check --resist-blocked-send eth1 bbs /t 1 /i bbc /t 1 /i

The laptop uses a proxy (squid) to only allow some URLs. Also the firewall only allows some specific
ip ranges. Does this have any influence for the gateway detection?
--------------------------
Laptop:Linux 0-1.ddmesh 2.6.22.1 #1 Tue Jul 17 23:43:32 CEST 2007 i686 GNU/Linux


During start the laptop produces the following syslog entries.
Oct 18 21:54:53 0-1 batmand[13603]: Warning - batgat kernel modul interface (/dev/batgat) not usable: No such file or directory This may decrease the performance of batman!
Oct 18 21:54:53 0-1 batmand[13603]: Warning - batgat kernel modul interface (/dev/batgat) not usable: No such file or directory This may decrease the performance of batman!
Oct 18 21:54:53 0-1 batmand[13603]: Trying to name tunnel to bat0 ...
Oct 18 21:54:53 0-1 kernel: bat0: Disabled Privacy Extensions
Oct 18 21:54:53 0-1 batmand[13603]: success!
Oct 18 21:54:53 0-1 batmand[13603]: Trying to name tunnel to bat0 ...
Oct 18 21:54:53 0-1 batmand[13603]: Warning - batgat kernel modul interface (/dev/batgat) not usable: No such file or directory This may decrease the performance of batman!
Oct 18 21:54:53 0-1 batmand[13603]: Trying to name tunnel to bat0 ...
Oct 18 21:54:53 0-1 batmand[13603]: Error - can't create tun device (TUNSETIFF): Device or resource busy
Oct 18 21:54:53 0-1 batmand[13603]: Trying to name tunnel to bat1 ...
Oct 18 21:54:53 0-1 kernel: bat1: Disabled Privacy Extensions
Oct 18 21:54:53 0-1 batmand[13603]: success!
Oct 18 21:54:53 0-1 batmand[13603]: Error - can't create tun device (TUNSETIFF): Device or resource busy
Oct 18 21:54:53 0-1 batmand[13603]: Trying to name tunnel to bat2 ...
Oct 18 21:54:53 0-1 kernel: bat2: Disabled Privacy Extensions
Oct 18 21:54:53 0-1 batmand[13603]: success!

I have running openvpn that also use some tun and tap devices (using kmod_tun). All tunnel
interfaces that are using kmod_tun have names different to tunX. Only one interface
is using tap0.

ip route
192.168.100.2 dev vpn3  proto kernel  scope link  src 192.168.100.1
10.203.71.21 dev vpn1  proto kernel  scope link  src 10.203.71.22
192.168.99.2 dev vpn2  proto kernel  scope link  src 192.168.99.1
192.168.100.0/24 via 192.168.100.2 dev vpn3
192.168.178.0/24 dev eth0  proto kernel  scope link  src 192.168.178.2
169.254.2.0/24 dev bat2  proto static
169.254.0.0/24 dev bat0  proto static
192.168.1.0/24 dev eth0  proto kernel  scope link  src 192.168.1.2
169.254.1.0/24 dev bat1  proto static
192.168.99.0/24 via 192.168.99.2 dev vpn2
10.203.71.0/24 via 10.203.71.21 dev vpn1
104.61.0.0/16 via 10.203.71.21 dev vpn1
172.16.0.0/16 dev bbs  proto kernel  scope link  src 172.16.0.1
172.16.0.0/16 dev bbc  proto kernel  scope link  src 172.16.0.2
10.63.0.0/16 via 10.203.71.21 dev vpn1
105.61.0.0/16 via 10.203.71.21 dev vpn1
10.0.0.0/8 dev wlan0  proto kernel  scope link  src 10.12.0.1
default via 192.168.178.1 dev eth0

0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_route
10.12.10.1 dev wlan0  proto static  scope link  src 10.12.0.1
10.12.10.17 dev wlan0  proto static  scope link  src 10.12.0.1
throw 104.61.0.0/16  proto static

0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_hna
10.12.10.0/28 via 10.12.10.1 dev wlan0  proto static
10.12.10.16/28 via 10.12.10.17 dev wlan0  proto static
throw 104.61.0.0/16  proto static

0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_default
throw 104.61.0.0/16  proto static

B.A.T.M.A.N. 0.3-exp, MainIF/IP: wlan0 10.12.0.1, WindSize: 128, BLT: 2, OGI: 1000, UT: 0d 0h 2m
Originator           viaIF         Router (brc rcvd lseq lvld) [    viaIF RTQ  RQ  TQ].. alternatives...
10.12.10.1          wlan0      10.12.10.1 (126 128 39555    0) [    wlan0 118 127 118]         10.12.10.17 (  2)
10.12.10.17         wlan0     10.12.10.17 (128 128 49229    0) [    wlan0 123 128 123]


--------------------------
wrt54gs:

The wrt54gl shows always:
     Gateway              Router (#/128)
=> 10.12.0.1             10.12.0.1 (123), gw_class 33 - 1024KBit/256KBit, reliability: 0

But the ip route list table bat_default contains only a throw entry and not the default route.
ip addr lists the interfaces but always without an ip address assigned.
The batman revision I use is the batman-experimental Rev724. also some revisions before
have the same result.

Despite the presens of --no-throw-rules throw rules are added to the batman routing tables
to throw the hna entries. Is this wanted?

In older version I got a tunnel but this has be removed by batman. Perhaps because the client
didn't not use it to much?

If I try to add a tunnl manually (ip route add default dev bat0 table bat_default)
and try to ping an internet address the client logread shows :kern.err batmand[6649]: Error - can't receive ip from gateway: number of maximum retries reached

The manually added default route is removed after a while by batmand.

Has anyone an idea what I have done wrong.

Regards
 Stephan




