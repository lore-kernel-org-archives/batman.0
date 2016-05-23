Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 18:01:12 +0200
Message-Id: <1464019274-8451-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 0/2] batctl netns and netlink
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
netns/netlink support v8 as sent on May 23rd (today). Note that there are no 
previous batctl versions, I'm just using the same version number as the batman-adv
patches.

Andrews patch has been changed by Sven and me:
 * rebase on current master
 * fix printing of VID
 * add missing newline for claim table entries
 * fix claim table entry format
 * adjust names of mandatory attributes struct to avoid conflicts with
   backbone table
 * add local TTVN to global translation table header
 * add local group id to claim table

I've also added a patch to add support for BLA backbone tables.

Cheers,
     Simon

Andrew Lunn (1):
  batctl: Use netlink to replace some of debugfs

Simon Wunderlich (1):
  batctl: add netlink dump function for backbone tables

 batman_adv.h |   94 +++++
 debug.c      |   23 +-
 debug.h      |    4 +-
 functions.c  |   11 +
 functions.h  |    2 +
 netlink.c    | 1140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 netlink.h    |   20 +-
 packet.h     |   36 --
 8 files changed, 1289 insertions(+), 41 deletions(-)

-- 
2.8.1

