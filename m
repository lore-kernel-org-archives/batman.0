Message-ID: <8fb8a9264839c333f90f620c65fa48ea.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <200812191115.20610.neumann@cgws.de>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812172114.43427.neumann@cgws.de>
	<3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
	<200812191115.20610.neumann@cgws.de>
Date: Wed, 24 Dec 2008 19:24:31 +0100 (CET)
From: "Resul Cetin" <resul.cetin@uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Testing Batman
Reply-To: resul.cetin@uni-dortmund.de,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

Hii,

I will make some test with BATMAN. My test scenario is very simple, it
consists at the moment by a router and a Laptop.

My problem is, I cann't run Iperf to test the network. The ping response
is also to high.

I start batmand on my laptop by " sudo batmand wlan0"

The Iperf test are broken after only 10-15 seconds...Here is my Iperf output:
"[  3] local 11.1.1.23 port 49672 connected with 129.217.186.46 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 5.0 sec    640 KBytes  1.05 Mbits/sec
[  3]  5.0-10.0 sec    640 KBytes  1.05 Mbits/sec
[  3] 10.0-15.0 sec    640 KBytes  1.05 Mbits/sec
write2 failed: Network is down
[  3]  0.0-15.9 sec  1.98 MBytes  1.05 Mbits/sec
[  3] Sent 1415 datagrams
[  3] WARNING: did not receive ack of last datagram after 10 tries."

The ping results are:
"64 bytes from 11.1.1.3: icmp_seq=1377 ttl=64 time=2.09 ms
64 bytes from 11.1.1.3: icmp_seq=1378 ttl=64 time=2.10 ms
64 bytes from 11.1.1.3: icmp_seq=1379 ttl=64 time=6.69 ms
64 bytes from 11.1.1.3: icmp_seq=1380 ttl=64 time=9.33 ms
64 bytes from 11.1.1.3: icmp_seq=1381 ttl=64 time=12.07 ms
64 bytes from 11.1.1.3: icmp_seq=1382 ttl=64 time=27.9 ms
64 bytes from 11.1.1.3: icmp_seq=1384 ttl=64 time=5.16 ms
"

Can anybody help me to fix this problem... I didn't give a HNA on my
router, could this be problem ?

I would be very appreciate, if anybody could help me..

greetings,
E

