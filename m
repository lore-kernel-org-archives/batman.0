Message-ID: <41e6c23c2c09924ae91b571b5a36420b.squirrel@wm.ddmesh.de>
Date: Fri, 14 Nov 2008 11:43:33 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batmand-exp rev 1146 - hanging again
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


Hello,

I'm using batman-ex with revision 1146. One thread is running with
high cpu load. I can not make any connection via batmand -c. When
I try it, the call is also hanging.
I had the problems before, but not very often. I can not say how
to reproduce this.

the compile/linker flags I use are:
CFLAGS =        -Wall -O1 -DMEMORY_USAGE -DPROFILE_DATA -DDEBUG_MALLOC
LDFLAGS =       -lpthread

Here the top output. Most time the load is about 90%.

Mem: 14840K used, 15784K free, 0K shrd, 1544K buff, 5936K cached
CPU: 15.8% usr 84.1% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0%
softirq
Load average: 1.04 0.96 0.72
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
20639  1793 root     R     1260  4.1 67.6 /sbin/batmand -s 10.12.0.1 -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
--no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
 1106     1 root     S     1260  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
--no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
 1793  1106 root     S     1260  4.1  0.0 /sbin/batmand -s 10.12.0.1 -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
--no-prio-rules --one-way-tunnel 1 --two-way-tunnel 0 eth1 tbb /t 1 /i /A
21037 21035 root     S     1212  3.9  0.0 batmand -cb -d2
21283 21241 root     S     1212  3.9  0.0 batmand -c -b -r 1


Regards
 Stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


