Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Thu, 23 May 2013 16:53:00 +0200
Message-Id: <1369320783-1165-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 0/3] Fragmentation version 2
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

This is the fourth revision of a few patches to remove the current fragmentation code and replace it with a new version that supports more packet types and more fragments per packet, thus allowing bigger payloads.

The patches are based on current master and are meant for the next big bump in compat number. Revision 4 is changed according to Antonios latest review.

Martin Hundebøll (3):
  batman-adv: Remove old fragmentation code
  batman-adv: Receive fragmented packets and merge
  batman-adv: Fragment and send skbs larger than mtu

 Makefile.kbuild         |   2 +-
 distributed-arp-table.c |  11 +-
 fragmentation.c         | 485 ++++++++++++++++++++++++++++++++++++++++++++++++
 fragmentation.h         |  50 +++++
 hard-interface.c        |   1 -
 main.c                  |   8 +-
 main.h                  |   9 +
 originator.c            |  19 +-
 packet.h                |  41 ++--
 routing.c               | 145 ++++++---------
 routing.h               |   4 +-
 send.c                  | 195 ++++++++++++++++++-
 send.h                  |  36 ++++
 soft-interface.c        |  15 +-
 types.h                 |  63 +++++--
 unicast.c               | 478 -----------------------------------------------
 unicast.h               |  92 ---------
 17 files changed, 936 insertions(+), 718 deletions(-)
 create mode 100644 fragmentation.c
 create mode 100644 fragmentation.h
 delete mode 100644 unicast.c
 delete mode 100644 unicast.h

-- 
1.8.2.3

