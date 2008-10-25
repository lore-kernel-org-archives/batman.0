Message-ID: <24eb75fd8a048d4b908387e3bfbce04f.squirrel@webmail.ddmesh.de>
Date: Sat, 25 Oct 2008 17:30:03 +0200 (CEST)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-exp still has sometimes around 90% CPU load
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

I'm using batman-experimental rev1145. I test this release since
2 days. I found that a thread of batmand was consuming around 90%
of cpu resources.

Mem: 15064K used, 15560K free, 0K shrd, 1152K buff, 5176K cached
CPU: 10.0% usr 90.0% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0%
softirq
Load average: 0.98 1.00 0.97
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
 4464  1941 root     R     1216  3.9 84.1 /sbin/batmand -s 10.12.0.1  -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
 1151     1 root     S     1216  3.9  0.0 /sbin/batmand -s 10.12.0.1  -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules
 1941  1151 root     S     1216  3.9  0.0 /sbin/batmand -s 10.12.0.1  -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rules

it was not possibe to connect to the running batmand.
A call "batmand -c" just hangs without printing current parameters.

I had this error in previous revision where you disabled the debug task.
Batmand was running without problems.Have you enabled the debug task again
in current revision?

any idea or solution?
Regards
 /Stephan


---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


