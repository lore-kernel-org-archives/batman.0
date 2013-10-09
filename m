Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  9 Oct 2013 15:05:31 +0200
Message-Id: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/7] add network wide multi interface
	optimization
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

This patchset adds the network wide multi interface optimization as
proposed in our wiki [1] for BATMAN IV. The main purpose is to do
interface alternating and bonding by considering multi interface
capabilities globally and not just for the (next) link, otherwise
non-optimal links may be chosen.

This patchset needs to change a lot of core data structures and
routing, please review it carefully. A local development branch
exists on the public git repo [2].

Changes from RFCv2 in September are:
 * add debugfs file to view metric values for various interfaces (new patch)
 * many style and kerneldoc fixes (thanks Antonio)
 * use two interface parameters for bat_neigh_cmp (Antonio)
 * simplify and fix last candidate usage in bonding (Antonio)
 * rebase on latest master

I've tested the patchset in my VMs to confirm that bonding and alternating
works as expected.

As always, any comments are appreciated!

Thanks,
	Simon

[1] http://www.open-mesh.org/projects/batman-adv/wiki/network-wide-multi-link-optimization
[2] http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/simon/network-wide-multiif

Simon Wunderlich (7):
  batman-adv: remove bonding and interface alternating
  batman-adv: split tq information in neigh_node struct
  batman-adv: split out router from orig_node
  batman-adv: add WiFi penalty
  batman-adv: consider outgoing interface in OGM sending
  batman-adv: add bonding again
  batman-adv: add debugfs support to view multiif tables

 bat_iv_ogm.c            |  764 ++++++++++++++++++++++++++++++++---------------
 debugfs.c               |   16 +
 distributed-arp-table.c |    3 +-
 gateway_client.c        |   79 ++++-
 hard-interface.c        |    2 +-
 hard-interface.h        |   19 ++
 icmp_socket.c           |    2 +-
 network-coding.c        |    9 +-
 originator.c            |  362 +++++++++++++++++++---
 originator.h            |   11 +-
 routing.c               |  414 ++++++++-----------------
 routing.h               |   12 +-
 send.c                  |   19 +-
 soft-interface.c        |    2 +-
 translation-table.c     |    5 +-
 types.h                 |  126 +++++---
 16 files changed, 1184 insertions(+), 661 deletions(-)

-- 
1.7.10.4

