Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 25 Apr 2013 10:37:20 +0200
Message-Id: <1366879046-24507-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv4 0/6] compat bump work
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

This is pretty much a rebase (this time on master) of the v3
patchset with some minor modifications.

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
 packet.h         |   75 +++--
 routing.c        |   83 ++---
 routing.h        |    4 +-
 send.c           |    1 -
 soft-interface.c |    1 -
 sysfs.c          |   72 -----
 types.h          |   82 -----
 vis.c            |  936 ------------------------------------------------------
 vis.h            |   36 ---
 14 files changed, 99 insertions(+), 1256 deletions(-)
 delete mode 100644 vis.c
 delete mode 100644 vis.h

-- 
1.7.10.4

