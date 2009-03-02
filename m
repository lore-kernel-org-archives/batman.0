Message-ID: <8d79bbc03733436bcbf2616af3ef08eb.squirrel@wm.ddmesh.de>
Date: Mon, 2 Mar 2009 14:43:02 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-exp rev1214 sometimes keeps dead node in list
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


Hi,

i have seen that batman-experimental rev. 1214 keeps a dead node in its list and also
keeps the routing entry valid.
Node 10.12.59.1 is the dead node. this seems to be in list since some days.

BatMan-eXp 0.3-alpha, IF eth1 10.12.10.1, LinkWindowSize 100, PathWindSize 100, OGI 1000ms,
currSeqno 51910, UT 23:22:38:18, CPU 7/1000, IntTime 2068698579
Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld rid nid ) [     viaIF
RTQ  RQ  TQ]..
10.12.10.17     eth1           10.12.10.17  94 (   98 23:22:37:42 10810    0   1   1 ) [      eth1
 94  98  95]
10.12.59.1      eth1            10.12.59.1  97 (  100  7:19:27:24 18041 490493   2   0 ) [     
eth1   0  94   0]

Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld pws  ogi cpu hop
change ) alternativeNextHops brc ...
10.12.23.1      eth1           10.12.10.17  93 (   97  6:18:09:30 42628    0 100 1004  17 -11   
163 )
10.12.0.1       eth1           10.12.10.17  96 (  100  7:20:16:51 20266    0 100 1001   0   2  
1741 )
10.12.59.1      eth1            10.12.59.1  97 (  100  7:19:27:24 18041 490493 100 1021   0 -12  
1782 )
10.12.0.17      eth1           10.12.10.17  91 (   95  7:20:17:05 57466    0 100 1009   1   2  
1959 )
10.12.45.1      eth1           10.12.10.17  93 (   97 13:00:40:40 28037    0 100 1001  20 -11  
1687 )
10.12.10.17     eth1           10.12.10.17  94 (   98 23:22:37:42 10810    0 100 1007  40 -12  
1823 )
10.12.8.1       eth1           10.12.10.17  99 (  100 13:00:37:54 61117    0 100 1003  17 -11  
1745 )
   7 known Originator(s), averages:         94 (   98                   70070 100 1007  13  -7  
1557 )

Bye Stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


