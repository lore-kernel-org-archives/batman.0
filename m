Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:37 +0200
Message-Id: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (6: fixes)
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

here are patches targeted for 2.6.36. All patches needed for that patchset are
already part of Linus' tree. They are smaller bugfixes and add no new features.

The only special fix is "unify orig_hash_lock spinlock handling to avoid
deadlocks" which fixes the usage of the same spinlock with spin_lock and
spin_lock_irqsave. This one should also be applied in 2.6.35.x

"Fix merge of linus tree" should readd an older bugfix again which was removed
by your merge with Linus' tree.

The patches for 2.6.37 will follow later.

thanks,
	Sven

Marek Lindner (4):
      Staging: batman-adv: unify orig_hash_lock spinlock handling to avoid deadlocks
      Staging: batman-adv: fix batman icmp originating from secondary interface
      Staging: batman-adv: always reply batman icmp packets with primary mac
      Staging: batman-adv: fix own mac address detection

Sven Eckelmann (1):
      Staging: batman-adv: Fix merge of linus tree

 drivers/staging/batman-adv/bat_sysfs.c      |    4 ++++
 drivers/staging/batman-adv/hard-interface.c |    8 --------
 drivers/staging/batman-adv/icmp_socket.c    |   12 ++++++++----
 drivers/staging/batman-adv/main.c           |    7 +++++--
 drivers/staging/batman-adv/originator.c     |   14 ++++++++------
 drivers/staging/batman-adv/routing.c        |   16 ++++++++++++++--
 drivers/staging/batman-adv/types.h          |    1 +
 7 files changed, 40 insertions(+), 22 deletions(-)

