Message-ID: <47426F09.9060605@absorb.it>
Date: Tue, 20 Nov 2007 10:52:17 +0530
From: rene <batman@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] problem starting batmand (v799)
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

starting batmand, the daemon sometimes doesn't seem to recognize the
network the right way.


root@25:~# killall batmand
root@25:~# batmand eth1:1 vlan0:1
Using interface eth1:1 with address 192.168.42.25 and broadcast address
192.168.43.255
Using interface vlan0:1 with address 192.168.42.25 and broadcast address
192.168.43.255
-------------------------------------------------------
 This is a tcpdump from a neighbor node:

root@ap14:~# tcpdump -i eth0 src 192.168.42.25
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
05:12:09.512310 arp who-has 192.168.43.255 tell 192.168.42.25
05:12:10.512178 arp who-has 192.168.43.255 tell 192.168.42.25
05:12:11.699795 arp who-has 192.168.43.255 tell 192.168.42.25

-------------------------------------------
on the other node:
root@25:~# killall batmand
root@25:~# batmand eth1:1 vlan0:1
Using interface eth1:1 with address 192.168.42.25 and broadcast address
192.168.43.255
Using interface vlan0:1 with address 192.168.42.25 and broadcast address
192.168.43.255
root@25:~#

----------------------------------------------
tcpdump:

05:12:28.621940 IP 192.168.42.25.4305 > 192.168.43.255.4305: UDP, length 20
05:12:28.873246 IP 192.168.42.25.4305 > 192.168.43.255.4305: UDP, length 25
05:12:28.892343 IP 192.168.42.25.4305 > 192.168.43.255.4305: UDP, length 15


now batmand is running successfully.

Any Ideas?

regards,
Rene
