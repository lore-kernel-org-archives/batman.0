Message-ID: <47207A74.3060005@ddmesh.de>
Date: Thu, 25 Oct 2007 13:13:56 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Segmentation fault and log errors,
	expermimental Rev.756
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

I'm using experimental batmand Rev 756. After a while the batmand is crashing.
with "Segmentation fault". the crashing batmand is running on i386 (debian 2.6.22.1).
All routers are running the same batmand version. I have not checked if also the
batmand crashs on the routers.

syslog: batmand[6733]: Error - got packet from unknown client: 10.12.10.17 (virtual ip 169.254.1.1)
batman log (-d4):  Error - SIGSEGV received, trying to clean up ...

/usr/bin/batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1 --no-unreachable-rule
--no-throw-rules --no-prio-rules --resist-blocked-send wlan0 bbs /t 1 /i /A bbc /t 1 /i /A -d 4 >/tmp/batman-chrash

A___B---C

(_) backbone (bbs-bbc)
(-) wlan

A: wlan0 10.12.0.1    , bbs 172.16.0.1
B: eth1  10.12.10.17  , bbc 172.16.10.18
C: eth1  10.12.10.1

A offers internet gateway.

Additional during batman start syslog shows some errors:
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat0 ...
Oct 25 12:18:06 0-1 batmand[26343]: success!
Oct 25 12:18:06 0-1 batmand[26343]: Error - can't add route to 169.254.0.0/24 via 0.0.0.0 (table 254): File exists
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat0 ...
Oct 25 12:18:06 0-1 batmand[26343]: busy!
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat1 ...
Oct 25 12:18:06 0-1 batmand[26343]: success!
Oct 25 12:18:06 0-1 batmand[26343]: Error - can't add route to 169.254.1.0/24 via 0.0.0.0 (table 254): File exists
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat0 ...
Oct 25 12:18:06 0-1 batmand[26343]: busy!
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat1 ...
Oct 25 12:18:06 0-1 batmand[26343]: busy!
Oct 25 12:18:06 0-1 batmand[26343]: Trying to name tunnel to bat2 ...
Oct 25 12:18:06 0-1 batmand[26343]: success!
Oct 25 12:18:06 0-1 batmand[26343]: Error - can't add route to 169.254.2.0/24 via 0.0.0.0 (table 254): File exists

ip addr
28: bat0: <POINTOPOINT,MULTICAST,NOARP,UP,10000> mtu 1471 qdisc pfifo_fast qlen 500
    link/[65534]
    inet 169.254.0.0/32 scope global bat0
29: bat1: <POINTOPOINT,MULTICAST,NOARP,UP,10000> mtu 1471 qdisc pfifo_fast qlen 500
    link/[65534]
    inet 169.254.1.0/32 scope global bat1
30: bat2: <POINTOPOINT,MULTICAST,NOARP,UP,10000> mtu 1471 qdisc pfifo_fast qlen 500
    link/[65534]
    inet 169.254.2.0/32 scope global bat2

Bye
 Stephan
