Message-ID: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
Date: Wed, 24 Sep 2008 14:28:56 +0200 (CEST)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-exp hang on 95% CPU load
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

I currently use batman-experimental rev 1105. Yesterday
a node was not reachable. The "top" showed me that batmand
was running with almost 100% load.

I could not attach to the batmand to watch any debug info or states.
When calling batmand -cd8 (or others) the call simply hangs without
prints.

The only call I could make was batmand -c, which displayed:
/sbin/batmand [not-all-options-displayed] -r 1 -a 10.12.10.16/28 -a
172.16.10.17/32 eth1 tbb /t

logread did not show any batman message. The memory consumption was also ok.
After hard killing and starting the daemon batmand runs normal.

Creating a core dump on wrt was not possible.

Do you have already seen this?

/Stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


