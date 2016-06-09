Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  9 Jun 2016 16:58:48 +0200
Message-Id: <1465484333-8187-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v9 0/5] batctl netns and netlink
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

This patchset adds netns/netlink support to batctl. It complements the batman-adv
netns/netlink support v9 as sent today. This series is an update from
the v8 series sent on May 23rd with the following changes:

 * fix segfault when reading algo_name for originator table header
 * import newest version of debugfs.[ch] from alfred
 * add patches to translate client mac addresses via netlink

Cheers,
     Simon

Andrew Lunn (1):
  batctl: Use netlink to replace some of debugfs

Simon Wunderlich (1):
  batctl: add netlink dump function for backbone tables

Sven Eckelmann (3):
  batctl: Import alfred version of debugfs.*
  batctl: Split translate_mac from debugfs backend
  batctl: Translate mac addresses via netlink

 batman_adv.h |   94 +++++
 debug.c      |   23 +-
 debug.h      |    4 +-
 debugfs.c    |   17 +-
 debugfs.h    |    4 +-
 functions.c  |   61 ++-
 functions.h  |    5 +-
 netlink.c    | 1328 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 netlink.h    |   25 +-
 packet.h     |   36 --
 10 files changed, 1534 insertions(+), 63 deletions(-)

-- 
2.8.1

