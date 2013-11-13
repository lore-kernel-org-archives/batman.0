Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Nov 2013 19:14:44 +0100
Message-Id: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 0/8] add network wide multi interface
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

This patchset adds the network wide multi interface optimization as
proposed in our wiki [1] for BATMAN IV. The main purpose is to do
interface alternating and bonding by considering multi interface
capabilities globally and not just for the (next) link, otherwise
non-optimal links may be chosen.

This patchset needs to change a lot of core data structures and
routing, please review it carefully. A local development branch
exists on the public git repo [2].

Changes from PATCHv2 (thanks Linus and Marek for suggestions) are:
 * fix many rcu,reference and kerneldoc issues
 * remove some TODOs which are fixed in the series
 * rename debugfs file hardif/$IF/originators_multiif -> hardif/$IF/originators
 * rebase on Antonios extended isolation patches
 * ... check for more in the changelog of the individual patches

I've tested the patchset in my VMs to confirm that bonding and alternating
works as expected. Patches should be checkpatch and sparse clean.

As always, any comments are appreciated!

Thanks,
	Simon

[1] http://www.open-mesh.org/projects/batman-adv/wiki/network-wide-multi-link-optimization
[2] http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/simon/network-wide-multiif

Simon Wunderlich (8):
  batman-adv: remove bonding and interface alternating
  batman-adv: split tq information in neigh_node struct
  batman-adv: split out router from orig_node
  batman-adv: add WiFi penalty
  batman-adv: consider outgoing interface in OGM sending
  batman-adv: add bonding again
  batman-adv: add debugfs structure for information per interface
  batman-adv: add debugfs support to view multiif tables

 bat_iv_ogm.c            |  871 +++++++++++++++++++++++++++++++----------------
 compat.c                |    8 -
 compat.h                |    1 -
 debugfs.c               |   94 +++++
 debugfs.h               |    3 +
 distributed-arp-table.c |    3 +-
 gateway_client.c        |   86 ++++-
 hard-interface.c        |    9 +
 hard-interface.h        |   18 +
 icmp_socket.c           |    3 +-
 main.h                  |    5 +
 network-coding.c        |    9 +-
 originator.c            |  529 +++++++++++++++++++++++++---
 originator.h            |   20 +-
 routing.c               |  429 ++++++++---------------
 routing.h               |   12 +-
 send.c                  |   19 +-
 soft-interface.c        |    2 +-
 translation-table.c     |    6 +-
 types.h                 |  130 ++++---
 20 files changed, 1553 insertions(+), 704 deletions(-)

-- 
1.7.10.4

