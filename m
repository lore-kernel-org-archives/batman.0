Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 00:28:17 +0200
Message-Id: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (2)
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

here are patches targetted for 2.6.36. All patches needed for that patchset are
already part of your staging-next tree.

All patches are cleanup patches and no new feature is added.

thanks,
	Sven

Antonio Quartulli (1):
      Staging: batman-adv: Convert names from Java to C style

Linus Lüssing (1):
      Staging: batman-adv: Avoid rounding issues for local hna timeout

Marek Lindner (4):
      Staging: batman-adv: replace manual calculation by msecs_to_jiffies() for better readability
      Staging: batman-adv: Add sysfs abi documentation about bonding
      Staging: batman-adv: adapting source version to revised versioning scheme
      Staging: batman-adv: fix early debugfs deinitialization

Simon Wunderlich (1):
      Staging: batman-adv: Lower resolution for timeouts

Sven Eckelmann (1):
      Staging: batman-adv: Add include guards to all header files

 drivers/staging/batman-adv/aggregation.h        |    5 +++++
 drivers/staging/batman-adv/bat_debugfs.h        |    6 +++---
 drivers/staging/batman-adv/bat_sysfs.h          |    6 +++---
 drivers/staging/batman-adv/bitarray.h           |    4 ++++
 drivers/staging/batman-adv/hard-interface.h     |    5 +++++
 drivers/staging/batman-adv/hash.h               |    8 +++++---
 drivers/staging/batman-adv/icmp_socket.h        |    5 +++++
 drivers/staging/batman-adv/main.c               |    4 ++--
 drivers/staging/batman-adv/main.h               |   13 +++++++++----
 drivers/staging/batman-adv/originator.c         |    6 ++----
 drivers/staging/batman-adv/originator.h         |    5 +++++
 drivers/staging/batman-adv/packet.h             |    5 +++++
 drivers/staging/batman-adv/ring_buffer.h        |    5 +++++
 drivers/staging/batman-adv/routing.c            |    6 +++---
 drivers/staging/batman-adv/routing.h            |    5 +++++
 drivers/staging/batman-adv/send.c               |   14 +++++++-------
 drivers/staging/batman-adv/send.h               |    5 +++++
 drivers/staging/batman-adv/soft-interface.c     |    6 +++---
 drivers/staging/batman-adv/soft-interface.h     |    7 ++++++-
 drivers/staging/batman-adv/sysfs-class-net-mesh |    8 ++++++++
 drivers/staging/batman-adv/translation-table.c  |    3 +--
 drivers/staging/batman-adv/translation-table.h  |    5 +++++
 drivers/staging/batman-adv/types.h              |    6 +++---
 drivers/staging/batman-adv/vis.c                |   14 +++++++-------
 drivers/staging/batman-adv/vis.h                |    7 ++++++-
 25 files changed, 117 insertions(+), 46 deletions(-)

