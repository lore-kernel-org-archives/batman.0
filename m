Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:10 +0200
Message-Id: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (3)
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

here are patches targeted for 2.6.37. All patches needed for that patchset are
already part of your staging-next tree.

thanks,
	Sven

Marek Lindner (1):
      Staging: batman-adv: Introduce update_primary_addr to update mac address

Sven Eckelmann (11):
      Staging: batman-adv: checkpatch cleanup of comments
      Staging: batman-adv: Move mailing list address to .org
      Staging: batman-adv: Mark debugfs files as nonseekable
      Staging: batman-adv: wait for call_rcu before unloading module
      Staging: batman-adv: Introduce if_list_lock to protect if_list
      Staging: batman-adv: Always protect list_for_each_entry_rcu with RCU
      Staging: batman-adv: Remove unneeded rcu_read_lock
      Staging: batman-adv: Use synchronize_rcu instead of call_rcu
      Staging: batman-adv: Use refcnt to track usage count of batman_if
      Staging: batman-adv: count batman_if list queries as reference
      Staging: batman-adv: Track references of batman_if in set_primary_if

 drivers/staging/batman-adv/README           |    5 +-
 drivers/staging/batman-adv/TODO             |    7 +--
 drivers/staging/batman-adv/bat_debugfs.c    |    2 +
 drivers/staging/batman-adv/bat_sysfs.c      |   42 ++++++++++---
 drivers/staging/batman-adv/hard-interface.c |   89 +++++++++++++++++++-------
 drivers/staging/batman-adv/hard-interface.h |   13 ++++
 drivers/staging/batman-adv/icmp_socket.c    |    3 +
 drivers/staging/batman-adv/main.c           |    2 +-
 drivers/staging/batman-adv/originator.c     |    2 -
 drivers/staging/batman-adv/packet.h         |    2 +-
 drivers/staging/batman-adv/routing.c        |    2 +
 drivers/staging/batman-adv/types.h          |   21 +++---
 drivers/staging/batman-adv/vis.c            |   16 +++---
 13 files changed, 142 insertions(+), 64 deletions(-)
