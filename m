Message-ID: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
Date: Tue, 2 Dec 2008 12:30:27 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-exp rev.1154 still using 94% CPU load
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
To: b.a.t.m.a.n@open-mesh.net


Hi,

I have still the problem that batman-exp is hanging on 94% cpu load.
perhaps it has nothing to do with the gateway task. It is possible that
I run more "batmand -c" at same time?
The current batman revision is  1154.
Do you have any idea?


Mem: 15700K used, 14924K free, 0K shrd, 1440K buff, 6600K cached
CPU:  5.8% usr 94.1% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0% softirq
Load average: 1.62 1.39 0.98
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
24256  1843 root     R     1264  4.1 94.7 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
 1156     1 root     S     1264  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
 1843  1156 root     S     1264  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 1 --t 63
--no-unreachable-rule --no-throw-rules --no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1
tbb /t 1 /i /A
24462 24460 root     S     1216  3.9  0.0 batmand -cb -d2
24857 24815 root     S     1216  3.9  0.0 batmand -c -b -r 1

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


