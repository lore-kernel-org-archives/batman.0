Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:17 +0200
Message-Id: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (1)
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi,

I hope that the fever-induced dreams are over now. Otherwise I will try to
write my mails also as little tales. ;)

Nevertheless, I would like to send some patches for 2.6.37. That is not
100% true. We would also like to see the revert
'Revert: "Staging: batman-adv: Adding netfilter-bridge hooks"' too in 2.6.36.
It fixes a bug introduced by the commit we revert here.

The rest is more or less the usual stuff, but more feature patches this time.
All patches we depend on are already part of 2.6.36-rc3.

I will try to sent a patch again to David S. Miller.

thanks,
	Sven

Andreas Langer (1):
      Staging: batman-adv: layer2 unicast packet fragmentation

Marek Lindner (4):
      Staging: batman-adv: refactoring unicast payload code
      Staging: batman-adv: register the batman-adv packet type per interface
      Staging: batman-adv: attach each hard-interface to a soft-interface
      Staging: batman-adv: multiple mesh clouds

Simon Wunderlich (2):
      Staging: batman-adv: Count Ethernet header for incoming packets
      Staging: batman-adv: move queue counters into bat_priv

Sven Eckelmann (14):
      Revert: "Staging: batman-adv: Adding netfilter-bridge hooks"
      Staging: batman-adv: Remove CHANGELOG
      Staging: batman-adv: Start new development cycle
      Staging: batman-adv: Calculate hamming weight using optimized kernel functions
      Staging: batman-adv: Directly prepare icmp packets in socket buffer
      Staging: batman-adv: Keep header writable and unshared
      Staging: batman-adv: Only clone skb data for multiple broadcasts
      Staging: batman-adv: Aggregate batman packets directly in skb
      Staging: batman-adv: Prepare vis packets directly inside a skb
      Staging: batman-adv: Create copy of skb with pre-allocated headroom
      Staging: batman-adv: Provide full headers and packets as linear skb
      Staging: batman-adv: Remove duplicate of attached device name
      Staging: batman-adv: Don't inform about dropped packets in nodebug
      Staging: batman-adv: Update mtu of bat device by changing mtu of slave device

 drivers/staging/batman-adv/CHANGELOG           |   63 ---
 drivers/staging/batman-adv/Makefile            |    2 +-
 drivers/staging/batman-adv/README              |   45 +--
 drivers/staging/batman-adv/TODO                |    3 -
 drivers/staging/batman-adv/aggregation.c       |   57 ++--
 drivers/staging/batman-adv/bat_sysfs.c         |  106 ++++--
 drivers/staging/batman-adv/bitarray.c          |   22 +-
 drivers/staging/batman-adv/bitarray.h          |    7 +-
 drivers/staging/batman-adv/hard-interface.c    |  237 +++++++-----
 drivers/staging/batman-adv/hard-interface.h    |    6 +-
 drivers/staging/batman-adv/hash.c              |    6 +-
 drivers/staging/batman-adv/hash.h              |    4 +-
 drivers/staging/batman-adv/icmp_socket.c       |   70 ++--
 drivers/staging/batman-adv/main.c              |  138 ++-----
 drivers/staging/batman-adv/main.h              |   28 +-
 drivers/staging/batman-adv/originator.c        |  166 +++++----
 drivers/staging/batman-adv/originator.h        |    8 +-
 drivers/staging/batman-adv/packet.h            |   26 +-
 drivers/staging/batman-adv/routing.c           |  440 ++++++++++++---------
 drivers/staging/batman-adv/routing.h           |   16 +-
 drivers/staging/batman-adv/send.c              |  174 ++++-----
 drivers/staging/batman-adv/send.h              |    7 +-
 drivers/staging/batman-adv/soft-interface.c    |  238 +++++++-----
 drivers/staging/batman-adv/soft-interface.h    |   13 +-
 drivers/staging/batman-adv/translation-table.c |  266 +++++++------
 drivers/staging/batman-adv/translation-table.h |   30 +-
 drivers/staging/batman-adv/types.h             |   98 ++++-
 drivers/staging/batman-adv/unicast.c           |  265 +++++++++++++
 drivers/staging/batman-adv/unicast.h           |   39 ++
 drivers/staging/batman-adv/vis.c               |  500 ++++++++++++++----------
 drivers/staging/batman-adv/vis.h               |   27 +--
 31 files changed, 1822 insertions(+), 1285 deletions(-)
