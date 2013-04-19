Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 21:01:38 +0200
Message-Id: <1366398101-31363-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] compat bump work
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

These are some patches for inclusion for the next compat bump:
 * remove vis server - this functionality will be provided by alfred
   and associated programs in the future and does not really belong
   to kernel space
 * reorder packet types - this allows to route future unicast packets
   even if not yet implemented
 * remove __packed from ogm packets to allow better access in compiled code 

This is based on ordex/compat_bump.

Simon Wunderlich (3):
  batman-adv: remove vis functionality
  batman-adv: reorder packet types
  batman-adv: remove packed from batadv_ogm_packet

 Makefile.kbuild  |    1 -
 bat_iv_ogm.c     |    7 -
 debugfs.c        |    9 -
 hard-interface.c |    9 -
 main.c           |   39 ++-
 packet.h         |   56 ++--
 routing.c        |   70 ++--
 routing.h        |    2 +
 send.c           |    1 -
 soft-interface.c |    1 -
 sysfs.c          |   72 -----
 types.h          |   82 -----
 vis.c            |  935 ------------------------------------------------------
 vis.h            |   36 ---
 14 files changed, 73 insertions(+), 1247 deletions(-)
 delete mode 100644 vis.c
 delete mode 100644 vis.h

-- 
1.7.10.4

