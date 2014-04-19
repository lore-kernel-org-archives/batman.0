Return-Path: <saurabh.chakrabarti@amideeptech.com>
Message-ID: <53527C1A.4000009@amideeptech.com>
Date: Sat, 19 Apr 2014 19:07:30 +0530
From: Saurabh Chakrabarti <saurabh.chakrabarti@amideeptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Mesh network splits when a single node goes down
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Harshal Vora <harshal@amideeptech.com>

We have a mesh network running on an adhoc wifi network. All the nodes 
are in static position. The problem is that when one node goes down, the 
mesh breaks and the bat0 interfaces of the nodes are not reachable 
(although, strangely, the nodes are reachable via the wlan0 interfaces). 
Also, the node that has gone down is in one corner of the mesh.

When one of the nodes is down,

linaro@raspberry:~$ sudo batctl o
[B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: wlan0/10:fe:ed:13:f2:10 (bat0 
BATMAN_IV)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
10:fe:ed:14:d5:c4    0.090s   (  9) 10:fe:ed:14:d5:c4 [     wlan0]: 
10:fe:ed:14:d5:c4 (  9)
c0:4a:00:19:91:ef    0.610s   (  8) c0:4a:00:19:91:ef [     wlan0]: 
c0:4a:00:19:91:ef (  8)
c0:4a:00:18:db:83    0.410s   ( 10) c0:4a:00:18:db:83 [     wlan0]: 
c0:4a:00:18:db:83 ( 10)
64:70:02:1c:bc:d0    0.090s   (  6) 64:70:02:1c:bc:d0 [     wlan0]: 
64:70:02:1c:bc:d0 (  6)

linaro@raspberry:~$ sudo batctl o
[B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: wlan0/c0:4a:00:18:db:83 (bat0 
BATMAN_IV)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
10:fe:ed:14:d5:c4    0.210s   (246) 10:fe:ed:14:d5:c4 [     wlan0]: 
c0:4a:00:19:91:ef (199) 10:fe:ed:14:d5:c4 (246)
c0:4a:00:19:91:ef    0.830s   (226) c0:4a:00:19:91:ef [     wlan0]: 
10:fe:ed:14:d5:c4 (196) c0:4a:00:19:91:ef (226)
64:70:02:1c:bc:d0    0.520s   (163) 64:70:02:1c:bc:d0 [     wlan0]: 
c0:4a:00:19:91:ef (  0) 64:70:02:1c:bc:d0 (163)

When the node thats down comes back up,
linaro@raspberry:~$ sudo batctl o
[B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: wlan0/64:66:b3:18:c9:79 (bat0 
BATMAN_IV)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
10:fe:ed:13:f2:10    0.890s   (255) 10:fe:ed:13:f2:10 [     wlan0]: 
c0:4a:00:19:91:ef (196) c0:4a:00:19:a9:7f (158) 10:fe:ed:14:d5:c4 ( 0) 
c0:4a:00:18:db:83 (200) 10:fe:ed:14:95:09 (208) c0:4a:00:18:07:f0 (167) 
10:fe:ed:13:f2:10 (255)
10:fe:ed:14:d5:c4    0.220s   (181) c0:4a:00:19:91:ef [     wlan0]: 
10:fe:ed:14:95:09 (  0) 10:fe:ed:13:f2:10 (160) c0:4a:00:19:a9:7f (127) 
c0:4a:00:18:db:83 (163) c0:4a:00:18:07:f0 (141) c0:4a:00:19:91:ef (181) 
10:fe:ed:14:d5:c4 (  0)
c0:4a:00:19:a9:7f    0.680s   (224) c0:4a:00:19:a9:7f [     wlan0]: 
10:fe:ed:14:d5:c4 (100) 10:fe:ed:14:95:09 (168) 10:fe:ed:13:f2:10 (171) 
c0:4a:00:18:db:83 (200) c0:4a:00:18:07:f0 (179) c0:4a:00:19:91:ef (201) 
c0:4a:00:19:a9:7f (224)
c0:4a:00:19:91:ef    0.440s   (233) c0:4a:00:19:91:ef [     wlan0]: 
c0:4a:00:19:a9:7f (140) 10:fe:ed:14:d5:c4 (  0) 10:fe:ed:13:f2:10 (156) 
10:fe:ed:14:95:09 (194) c0:4a:00:18:07:f0 (159) c0:4a:00:18:db:83 (156) 
c0:4a:00:19:91:ef (233)
c0:4a:00:18:db:83    0.160s   (230) c0:4a:00:18:db:83 [     wlan0]: 
c0:4a:00:19:a9:7f (145) c0:4a:00:18:07:f0 (189) 10:fe:ed:14:d5:c4 ( 0) 
10:fe:ed:13:f2:10 (195) 10:fe:ed:14:95:09 (177) c0:4a:00:19:91:ef (169) 
c0:4a:00:18:db:83 (230)
10:fe:ed:14:95:09    0.110s   (235) 10:fe:ed:14:95:09 [     wlan0]: 
c0:4a:00:19:a9:7f (124) 10:fe:ed:14:d5:c4 (  0) c0:4a:00:18:db:83 (158) 
c0:4a:00:18:07:f0 (183) 10:fe:ed:13:f2:10 (190) c0:4a:00:19:91:ef (169) 
10:fe:ed:14:95:09 (235)
c0:4a:00:18:07:f0    0.040s   (253) c0:4a:00:18:07:f0 [     wlan0]: 
c0:4a:00:19:a9:7f (171) 10:fe:ed:14:d5:c4 (  0) c0:4a:00:18:db:83 (199) 
10:fe:ed:14:95:09 (195) 10:fe:ed:13:f2:10 (199) c0:4a:00:19:91:ef (205) 
c0:4a:00:18:07:f0 (253)
64:70:02:1c:bc:d0    0.770s   (171) c0:4a:00:19:a9:7f [     wlan0]: 
10:fe:ed:14:95:09 (128) c0:4a:00:18:07:f0 (  0) 10:fe:ed:14:d5:c4 ( 0) 
c0:4a:00:19:91:ef (  0) c0:4a:00:18:db:83 (  0) c0:4a:00:19:a9:7f (171) 
10:fe:ed:13:f2:10 (134)


-saurabh
