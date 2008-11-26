Message-ID: <492DDC20.7090900@web.de>
Date: Thu, 27 Nov 2008 01:30:40 +0200
From: "Chris W." <chris-wy@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: chris-wy@web.de
Subject: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
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

thought I'd just let you know what I experienced when testing rv1152 on 
an outdoor network with atheroses and broadcoms, olsr in parallel.
Interfaces are started with
ifconfig eth1:1 10.4.2.29 netmask 255.255.0.0 broadcast 10.4.255.255

The batman test area looks something like this: 
http://preveli.gr/mesh/bat-228-2b.gif


-1- gateway:
a gw is started with batmand -s 10.4.2.50 -g 2mbit/256kbit eth1:1
the client 2.29 with batmand -s 10.4.2.50 -a 10.2.29.0/24 -r 2 ath0:1

When pinging the gateway through the client node or when accessing the 
internet through the node it logs
Nov 26 22:52:04 (none) kern.err batmand[1287]: Error - got packet from 
unknown client: 10.4.2.29 (virtual ip 10.2.29.136)

The tunnel itself is flickering, this happens with -r1,2,3 and -p

client log:
Gateway client - gateway (10.4.2.2) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.4.2.2 (gw_flags: 40, tq: 178, gw_product: 0)
Error - couldn't create tunnel: old tunnel is still active
Adding default route to 10.4.2.2 (gw_flags: 40, tq: 179, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.2
Adding default route via gate0 (table 68)
Gateway client - gateway (10.4.2.2) says: IP (169.254.0.1) is expired
Deleting default route via gate0 (table 68)
Adding default route to 10.4.2.2 (gw_flags: 40, tq: 181, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.2
Adding default route via gate0 (table 68)

gateway log:
Gateway - assigned 169.254.0.1 to client: 10.4.2.29
Gateway - assigned 169.254.0.1 to client: 10.4.2.29
Gateway - assigned 169.254.0.1 to client: 10.4.2.29

-?- What is batgat for, does it disannounce a gateway which in fact is 
down e.g due to dsl-failure ?


-2- together with olsrd.
All olsr nodes are on the subnet 192.168.x.x, all batman interfaces are 
aliases except on fonera 2.29 which is batman only.

 From a gateway node running olsrd in parallel the route to an announced 
network drops out towards the internet, the node itself is reachable:

root@10.4.2.2:~# traceroute -n 10.4.2.29
traceroute to 10.4.2.29 (10.4.2.29), 30 hops max, 40 byte packets
  1  10.4.2.95  13.918 ms  8.674 ms  4.966 ms
  2  10.4.2.72  20.074 ms  6.971 ms  32.104 ms
  3  10.4.2.29  41.365 ms  12.472 ms  33.477 ms
root@10.4.2.2:~# traceroute -n 10.2.29.1
traceroute to 10.2.29.1 (10.2.29.1), 30 hops max, 40 byte packets
  1  * * *
  2  62.103.x.x  46.254 ms  35.242 ms * (internet)

 From another node (8.107) the host is pingable, but traceroute drops 
out to the olsr-network

PING 10.4.2.29 (10.4.2.29): 56 data bytes
64 bytes from 10.4.2.29: seq=0 ttl=59 time=19.229 ms
64 bytes from 10.4.2.29: seq=1 ttl=59 time=14.573 ms

traceroute to 10.4.2.29 (10.4.2.29), 30 hops max, 38 byte packets
  1  192.168.8.105  11.337 ms  2.999 ms  3.366 ms
  2  192.168.8.106  9.791 ms  5.150 ms  5.598 ms
  3  192.168.106.2  10.965 ms  5.981 ms  7.978 ms
  4  192.168.2.95  36.130 ms  6.777 ms  8.472 ms
  5  192.168.2.72  18.389 ms  20.188 ms  10.949 ms
  6  * * *
  7  * *

traceroute to 10.2.29.1 (10.2.29.1), 30 hops max, 38 byte packets
  1  192.168.8.102  6.833 ms  5.335 ms  2.720 ms
  2  192.168.8.106  17.269 ms  5.819 ms  8.960 ms
  3  192.168.106.2  16.785 ms  6.966 ms  5.525 ms
  4  *  (internet)

As I tested this amoung three nanostations (8.105,106,107) all went fine 
including traceroute to an announced subnet. Of these three only 8.106 
has errors of the following kind - may this strange behaviour be an 
endian issue ? 8.106 atheros is lan-connected to 2.2 wrt54g broadcom:

-3- previously announced networks are not deleted (8.106), the routing 
table collects multiple entries for the same destination

Nov 26 23:18:42 Nano5-106 daemon.err batmand[574]: Error - can't add 
throw route to 10.2.29.0/24 via 10.8.106.100 (table 65): File exists
Nov 26 23:18:42 Nano5-106 daemon.err batmand[574]: Error - can't add 
route to 10.2.29.0/24 via 10.8.106.100 (table 65): File exists
Nov 26 23:18:47 Nano5-106 daemon.err batmand[574]: Error - can't add 
throw route to 10.8.106.100/32 via 10.8.106.100 (table 65): File exists
Nov 26 23:18:47 Nano5-106 daemon.err batmand[574]: Error - can't add 
route to 10.8.106.100/32 via 10.8.106.100 (table 65): File exists

root@Nano5-106:~# ip route show table 65
throw 10.5.30.100  proto static
10.5.30.100 via 10.4.8.105 dev ath0  proto static  src 10.4.8.106
10.5.30.100 via 10.4.8.109 dev ath0  proto static  src 10.4.8.106
10.5.30.100 via 10.4.8.102 dev ath0  proto static  src 10.4.8.106
throw 10.2.50.0/24  proto static
10.2.50.0/24 via 10.8.106.100 dev eth0  proto static  src 10.8.106.1
throw 10.2.29.0/24  proto static
10.2.29.0/24 via 10.4.8.102 dev ath0  proto static  src 10.4.8.106
10.2.29.0/24 via 10.8.106.100 dev eth0  proto static  src 10.8.106.1
10.2.29.0/24 via 10.4.8.105 dev ath0  proto static  src 10.4.8.106

root@Nano5-106:~# ip rule
0:      from all lookup local
6600:   from all to 10.4.0.0/16 lookup 66
6601:   from all to 10.8.106.0/24 lookup 66
6699:   from all lookup 65
6700:   from all to 10.4.0.0/16 lookup 67
6701:   from all to 10.8.106.0/24 lookup 67
32766:  from all lookup main
32767:  from all lookup default

This happens on 2.29 as well but not on every node, 8.107,105,104 and 
maybe others stay clear. It occurs on 8.109 which is lan-connected to 
broadcom 5.30 (see the map).

Well, I'll keep on testing ;-)

Chris





