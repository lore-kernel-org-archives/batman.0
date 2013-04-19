Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 21:52:23 +0200
Message-Id: <1366401149-31600-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/6] compat bump work
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Changes to v1:
 * move the build check macros in a separate flag
 * reorder batadv_iv_flags and remove VIS stuff
 * add check for adding record route info for icmp request/replies

This is based on ordex/compat_bump.

Simon Wunderlich (6):
  batman-adv: remove vis functionality
  batman-adv: add build check macros for packet member offset
  batman-adv: reorder packet types
  batman-adv: remove packed from batadv_ogm_packet
  batman-adv: reorder batadv_iv_flags
  batman-adv: only add recordroute information to icmp request/reply

 Makefile.kbuild  |    1 -
 bat_iv_ogm.c     |    7 -
 debugfs.c        |    9 -
 hard-interface.c |    9 -
 main.c           |   39 ++-
 packet.h         |   66 ++--
 routing.c        |   74 ++---
 routing.h        |    2 +
 send.c           |    1 -
 soft-interface.c |    1 -
 sysfs.c          |   72 -----
 types.h          |   82 -----
 vis.c            |  935 ------------------------------------------------------
 vis.h            |   36 ---
 14 files changed, 81 insertions(+), 1253 deletions(-)
 delete mode 100644 vis.c
 delete mode 100644 vis.h

-- 
1.7.10.4

