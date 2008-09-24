Message-ID: <a04f6c3bad38e2a5c4c29a3e9a3a6e16.squirrel@webmail.ddmesh.de>
In-Reply-To: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
References: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
Date: Wed, 24 Sep 2008 21:46:09 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] batman-exp hang on 95% CPU load
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

I forgot to add the process list of batmand. The hanging thread was
created by 1115. This may give you a hint to find the reason for hanging.

 1114 root       1216 S   /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r
1 --t
 1115 root       1216 S   /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r
1 --t
 1116 root       1216 S   /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r
1 --t
13821 root       1216 R   /sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r
1 --t

Mem: 16424K used, 14200K free, 0K shrd, 1588K buff, 7104K cached
CPU:  6.6% usr 93.3% sys  0.0% nice  0.0% idle  0.0% io  0.0% irq  0.0%
softirq
Load average: 0.89 1.05 1.00
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
13821  1115 root     R     1216  3.9 94.3 /sbin/batmand -s 10.12.0.1 -a
10.12.10.16/28 -r 1 --t 63 --no-unreachable-rule --no-throw-rul

Regards and thanks
 Stephan
---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


