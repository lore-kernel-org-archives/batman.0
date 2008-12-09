Message-ID: <3ca03f2b6ae1c3c84704f2ce5e8fd89a.squirrel@wm.ddmesh.de>
In-Reply-To: <200812021306.20569.axel@open-mesh.net>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812021306.20569.axel@open-mesh.net>
Date: Tue, 9 Dec 2008 10:28:55 +0100 (CET)
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

Hi again,

the batmand-exp is still hanging. below you see the top output and the parameters of
batmand or hna. I also include the network setup and some last connection states.
Perhaps it has something to do with any of the options. I can not directly verify if
any option is the reason for this hanging.
batman is connected via wlan (eth1) and a backbone connection (tbb). I have two router
WRT54GL and WRT54GS and a vserver (i386).
I only have problems on WRT54GS. Perhaps it has something to do with "-r 1" option.

Setup:

WRT54GL(eth1=wlan)----(eth1=wlan)WRT54GS(tbb=vpn tunnel)----(tbb)vserver

The vserver has also an addtional connection to a different router via tbb.
The parameters of batmand are:

WRT54GL: /sbin/batmand -s 10.12.0.1 -a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule
--no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
WRT54GS: /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule
--no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
vserver: /usr/bin/batmand -a 195.42.115.56/32 -a 104.61.0.0/16 -a 105.61.0.0/16 -a 106.61.0.0/16
-s 10.12.0.1 --no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1
--two-way-tunnel 0 wifi tbb /t 1 /i /A

-----------
Another question: in previous versions I have seen that if two batmand announce the same HNA ip (-a)
one of the batmand are ignored and complete ignored any batmand traffic. As result the node
was removed from any batmand list and was not reachable anymore.
-----------


top:
---------------------
Mem: 15832K used, 14792K free, 0K shrd, 1440K buff, 5972K cached
CPU:  0.0% usr  100% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0% softirq
Load average: 1.00 0.97 0.92
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
 8380  1816 root     R     1232  4.0 80.7 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
 1151     1 root     S     1232  4.0  0.0 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
 1816  1151 root     S     1232  4.0  0.0 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
23934 23892 root     S     1184  3.8  0.0 batmand -c -b -r 1
32567 32525 root     S     1184  3.8  0.0 batmand -c -b -r 1
 9105  9063 root     S     1184  3.8  0.0 batmand -c -b -r 1
 3421  3379 root     S     1184  3.8  0.0 batmand -c -b -r 1
 9038  9036 root     S     1184  3.8  0.0 batmand -cb -d2
12030 11988 root     S     1184  3.8  0.0 batmand -c -b -r 1
20666 20624 root     S     1184  3.8  0.0 batmand -c -b -r 1


Last connection output from batmand:
---------------------------
BatMan-eXp 0.3-alpha (compatibility version 10) !
BatMan-eXp 0.3-alpha, IF eth1 10.12.10.17, LinkWindowSize 100, PathWindSize 100, OGI 1000ms,
currSeqno 34756, UT 0:07:12:09, CPU 3/1000, IntTime   25929690
Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld rid nid ) [     viaIF
RTQ  RQ  TQ]..
10.12.10.1      eth1            10.12.10.1  87 (  100  0:00:57:20 43345    0   1   1 ) [      eth1
 79 100  79]
172.16.8.1      tbb             172.16.8.1 100 (   99  0:00:56:50 18597    0   2   2 ) [       tbb
100 100 100]
172.16.0.1      tbb             172.16.0.1 100 (   99  0:00:56:50 39090    0   1   3 ) [       tbb
100 100 100]
172.16.0.17     tbb            172.16.0.17 100 (   99  0:00:56:49 10460    0   1   4 ) [       tbb
100 100 100]

Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince  lseq lvld pws  ogi cpu hop
change ) alternativeNextHops brc ...
10.12.0.1       tbb             172.16.0.1 100 (   99  0:00:56:48 39090    0 100 1015   1   1     
5 )     172.16.0.17  98      172.16.8.1  98
10.12.0.17      tbb            172.16.0.17 100 (   99  0:00:56:48 10460    0 100 1008   3   1    
11 )      172.16.0.1  96      172.16.8.1  98
10.12.10.1      eth1            10.12.10.1  87 (  100  0:00:57:20 43345    0 100 1008   1 -12     
1 )     172.16.0.17   0      172.16.0.1   0
10.12.8.1       tbb             172.16.8.1  99 (   99  0:00:56:48 18597    0 100 1006   0 -12    
29 )      172.16.0.1  96     172.16.0.17  95
   4 known Originator(s), averages:         96 (   99                      0 100 1009   1  -5    
11 )

Last hna output
--------------------
BatMan-eXp 0.3-alpha (compatibility version 10) !
Originator      Announced networks HNAs:  network/netmask or interface/IF (B:blocked)...
10.12.0.1         195.42.115.56/32         104.61.0.0/16         105.61.0.0/16        
106.61.0.0/16         172.16.0.1/IF       194.26.180.0/24         77.87.48.0/21          
10.2.0.0/16        191.161.0.0/16         104.32.0.0/12          104.0.0.0/11        
104.64.0.0/10        104.128.0.0/ 9         10.126.0.0/16         10.124.0.0/15        
10.120.0.0/14         10.112.0.0/13
10.12.0.17          172.16.0.17/IF
10.12.10.1           10.12.10.0/28        172.16.10.1/IF
10.12.8.1             10.12.8.0/28         172.16.8.1/IF

last service output:
-------------------
BatMan-eXp 0.3-alpha (compatibility version 10) !
Originator      Announced services ip:port:seqno ...
10.12.0.1          104.61.79.20:80:1  104.61.119.111:21:1  104.61.119.222:21:1  
104.61.232.34:80:1  104.61.230.188:80:1  104.61.230.193:80:1

ip addr:
-------------
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:13:10:30:00:fd brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:13:10:30:00:ff brd ff:ff:ff:ff:ff:ff
    inet 10.12.10.17/8 brd 10.255.255.255 scope global eth1
4: br0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/ether 00:13:10:30:00:fd brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.4/24 brd 192.168.1.255 scope global br0
5: vlan0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc noqueue
    link/ether 00:13:10:30:00:fd brd ff:ff:ff:ff:ff:ff
6: vlan1: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc noqueue
    link/ether 00:13:10:30:00:fd brd ff:ff:ff:ff:ff:ff
    inet 192.168.178.25/24 brd 192.168.178.255 scope global vlan1
7: tbb: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/ether 00:ff:15:bf:0b:c0 brd ff:ff:ff:ff:ff:ff
    inet 172.16.10.17/16 brd 172.16.255.255 scope global tbb
17: tap1: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:ff:50:70:1e:1d brd ff:ff:ff:ff:ff:ff
154: bat0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1471 qdisc pfifo_fast qlen 10
    link/[65534]
    inet 10.12.10.17/32 scope global bat0
155: tap0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:ff:15:bf:0b:c0 brd ff:ff:ff:ff:ff:ff

bridges:
--------------
bridge name     bridge id               STP enabled     interfaces
br0             8000.0013103000fd       no              vlan0
                                                        tap1
tbb             8000.00ff15bf0bc0       yes             tap0



/stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


