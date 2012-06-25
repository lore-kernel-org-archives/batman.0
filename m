Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:24 +0200
Message-Id: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-06-25
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is another set of changes intended for net-next/linux-3.6.

This patchset is entirely composed by "namespace renaming" patches.

Please, let me know if there is any problem.

Thank you,
	Antonio




The following changes since commit 7011d0851b80a1a229acfda37ce08aad903b12d1:

  tcp: Fix bug in tcp socket early demux (2012-06-23 23:22:38 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to a513088d022c8f59cebe17c567797c220563b517:

  batman-adv: Prefix translation-table local static functions with batadv_ (2012-06-25 08:21:50 +0200)

----------------------------------------------------------------
Included changes:
- yet another batch of 'namespace cleaning' patches

----------------------------------------------------------------
Sven Eckelmann (20):
      batman-adv: Prefix bat_debugfs local static functions with batadv_
      batman-adv: Prefix bitarray static inline functions with batadv_
      batman-adv: Prefix hard-interface static inline functions with batadv_
      batman-adv: Prefix hash static inline functions with batadv_
      batman-adv: Prefix originator static inline functions with batadv_
      batman-adv: Prefix unicast static inline functions with batadv_
      batman-adv: Prefix main static inline functions with batadv_
      batman-adv: Prefix bat_iv_ogm local static functions with batadv_
      batman-adv: Prefix bat_sysfs local static functions with batadv_
      batman-adv: Prefix bridge_loop_avoidance local static functions with batadv_
      batman-adv: Prefix gateway_client local static functions with batadv_
      batman-adv: Prefix gateway_common local static functions with batadv_
      batman-adv: Prefix hard-interface local static functions with batadv_
      batman-adv: Prefix hash local static functions with batadv_
      batman-adv: Prefix icmp_socket local static functions with batadv_
      batman-adv: Prefix originator local static functions with batadv_
      batman-adv: Prefix routing local static functions with batadv_
      batman-adv: Prefix send local static functions with batadv_
      batman-adv: Prefix soft-interface local static functions with batadv_
      batman-adv: Prefix translation-table local static functions with batadv_

 net/batman-adv/bat_debugfs.c           |  143 +++---
 net/batman-adv/bat_iv_ogm.c            |  490 +++++++++++----------
 net/batman-adv/bat_sysfs.c             |  277 ++++++------
 net/batman-adv/bitarray.c              |   18 +-
 net/batman-adv/bitarray.h              |    6 +-
 net/batman-adv/bridge_loop_avoidance.c |  518 +++++++++++-----------
 net/batman-adv/gateway_client.c        |  125 +++---
 net/batman-adv/gateway_common.c        |   10 +-
 net/batman-adv/hard-interface.c        |   96 +++--
 net/batman-adv/hard-interface.h        |    7 +-
 net/batman-adv/hash.c                  |    4 +-
 net/batman-adv/hash.h                  |   19 +-
 net/batman-adv/icmp_socket.c           |   84 ++--
 net/batman-adv/main.c                  |    8 +-
 net/batman-adv/main.h                  |   17 +-
 net/batman-adv/originator.c            |  128 +++---
 net/batman-adv/originator.h            |   10 +-
 net/batman-adv/routing.c               |  174 ++++----
 net/batman-adv/send.c                  |   48 +--
 net/batman-adv/soft-interface.c        |   86 ++--
 net/batman-adv/translation-table.c     |  742 +++++++++++++++++---------------
 net/batman-adv/unicast.c               |    6 +-
 net/batman-adv/unicast.h               |    2 +-
 net/batman-adv/vis.c                   |   53 +--
 24 files changed, 1591 insertions(+), 1480 deletions(-)
