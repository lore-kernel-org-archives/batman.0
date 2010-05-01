Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  1 May 2010 15:10:06 +0200
Message-Id: <1272719410-406-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 0/4] *** SUBJECT HERE ***
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
To: lindner_marek@yahoo.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi Marek

I'm preparing a set of patches for GregKH for linux-next. I compared
the resulting mainline tree to maint and found a few
differences. These patches bring maint into line with linux-next.

I've no idea if these patches affect backwards compatibility with old
kernels. The last one might...

Andrew Lunn (4):
  batman-adv: Update README to match mainline README.
  batman-adv: Import sparse fixes from mainline.
  batman-adv: whitespace fixes from mainline.
  batman-adv: include cleanup: Update gfp.h and slab.h includes to
    prepare for breaking implicit...

 README           |   35 +++++++++--------------------------
 bat_sysfs.c      |    9 ++++++---
 bitarray.c       |    2 +-
 device.c         |    3 +--
 main.h           |    5 +++--
 routing.c        |    3 ++-
 send.c           |    3 ++-
 soft-interface.c |    2 +-
 vis.c            |   14 +++++++-------
 9 files changed, 32 insertions(+), 44 deletions(-)

