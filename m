Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon,  2 Apr 2012 14:48:14 +0200
Message-Id: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 0/2] Create counters for measuring behaviour
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Before sending an RFC on my work with network coding/catwoman, I would like some feedback on this stats-feature I build to measure the behaviour of catwoman.

It is basically a set of counters that are incremented on various places in the code as a more detailed alternative to the interface statistics.

Currently, my catwoman branch uses these counters (e.g. to tell how many packets are coded together), but other counters can easily be added. E.g. counters relevant to the BLA, DAT, OGM/ELP code.

If this feature is unneeded/unwanted, I will remove the dependency in catwoman.

Martin Hundebøll (2):
  batman-adv: Add interface to keep stats
  batman-adv: Increment stat counters on rx, tx, fwd

 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 bat_debugfs.c          |   17 +++++++
 bat_stats.c            |  132 ++++++++++++++++++++++++++++++++++++++++++++++++
 bat_stats.h            |   60 ++++++++++++++++++++++
 gen-compat-autoconf.sh |    1 +
 main.c                 |    6 +++
 routing.c              |    2 +
 soft-interface.c       |    3 ++
 types.h                |   20 ++++++++
 10 files changed, 244 insertions(+)
 create mode 100644 bat_stats.c
 create mode 100644 bat_stats.h

-- 
1.7.9.5

