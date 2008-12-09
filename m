Message-ID: <69286be24ee1b4978278308afbb2b7ed.squirrel@wm.ddmesh.de>
In-Reply-To: <3ca03f2b6ae1c3c84704f2ce5e8fd89a.squirrel@wm.ddmesh.de>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812021306.20569.axel@open-mesh.net>
	<3ca03f2b6ae1c3c84704f2ce5e8fd89a.squirrel@wm.ddmesh.de>
Date: Tue, 9 Dec 2008 11:22:02 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-exp rev.1154 still using 94% CPU load
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

have found something strange. the WRT54GL (see previous message) still has
WRT54GS(hanging batmand) in its list. tcpdump shows that no packets is sent out
of interface eth1 and tbb (ethernet bridge with vpn interface added).

batman output of WRT54GL (working batmand)
-----------------------------------------------
BatMan-eXp 0.3-alpha, IF eth1 10.12.10.1, LinkWindowSize 100, PathWindSize 100, OGI 1000ms,
currSeqno 64649, UT 0:12:41:09, CPU 0/1000, IntTime   45669714
Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld rid nid ) [     viaIF
RTQ  RQ  TQ]..
10.12.10.17     eth1           10.12.10.17  86 (  100  0:12:41:08 34780 21317   1   0 ) [     
eth1   0  79   0]

Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld pws  ogi cpu hop
change ) alternativeNextHops brc ...
10.12.10.17     eth1           10.12.10.17  86 (  100  0:12:41:08 34780 21317 100 1003   0 -12    
 1 )
   1 known Originator(s), averages:         86 (  100                   21317 100 1003   0 -12    
 1 )


But the vserver that is connected via tbb (vpn) does not get any OGM from WRT54GS.
So the problem has something to do with the tbb interface (ethernet bridge).
Both router have the second interface (tbb) added to the parameters of batmand.
The difference is that the WRT45GL has not interface added to the bridge(tbb).

tcpdump on bat0 shows that there is a gateway connection to the different internet router.
but the following message is sent very fast (100 per seconds or so - haven't measured)
tcpdump -tni bat0
IP 10.12.10.17.4306 > 10.12.8.1.4306: UDP, length 1469
IP 10.12.10.17 > 10.12.8.1: ip-proto-17
...
...

After hard-killing the batmand process and restart the fast send messages on bat0
are not sent anymore and I have the following gateway output:
 Originator         bestNextHop   #
=> 10.12.8.1            172.16.8.1  81, gw_class 35 - 1024KBit/512KBit, reliability: 0, supported
tunnel types -, 1WT
   10.12.0.1            172.16.0.1  82, gw_class 17 - 256KBit/64KBit, reliability: 0, supported
tunnel types -, 1WT


Perhaps this gives a more view of the situation and why there are so many UDP packets send on
bat0.

/stephan


