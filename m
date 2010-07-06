Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  6 Jul 2010 21:05:15 +0200
Message-Id: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (4)
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

here are patches targeted for 2.6.36. There are some patches which must be
applied before them. All were send in the following order as reply to
1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de and
201006260236.10217.sven.eckelmann@gmx.de

Staging: batman-adv: Convert names from Java to C style
Staging: batman-adv: Avoid rounding issues for local hna timeout
Staging: batman-adv: Lower resolution for timeouts
Staging: batman-adv: replace manual calculation by msecs_to_jiffies() for better readability
Staging: batman-adv: Add sysfs abi documentation about bonding
Staging: batman-adv: adapting source version to revised versioning scheme
Staging: batman-adv: Add include guards to all header files
Staging: batman-adv: fix early debugfs deinitialization
Staging: batman-adv: Allow to build it inside the kernel
Staging: batman-adv: Remove dependency to PROCFS

thanks,
	Sven


Linus Lüssing (1):
      Staging: batman-adv: Add last-seen in originator table

Marek Lindner (1):
      Staging: batman-adv: add routing debug log accessible via debugfs

Sven Eckelmann (1):
      Staging: batman-adv: Move printk to simplified macros

 drivers/staging/batman-adv/aggregation.c       |    5 +-
 drivers/staging/batman-adv/bat_debugfs.c       |  197 +++++++++++++++++++++++-
 drivers/staging/batman-adv/bat_sysfs.c         |  131 +++++++++++-----
 drivers/staging/batman-adv/bitarray.c          |    7 +-
 drivers/staging/batman-adv/hard-interface.c    |   53 +++----
 drivers/staging/batman-adv/icmp_socket.c       |   13 +-
 drivers/staging/batman-adv/main.c              |   26 +---
 drivers/staging/batman-adv/main.h              |   56 +++++--
 drivers/staging/batman-adv/originator.c        |   54 ++++---
 drivers/staging/batman-adv/routing.c           |   74 ++++++----
 drivers/staging/batman-adv/send.c              |   35 +++--
 drivers/staging/batman-adv/translation-table.c |   27 ++--
 drivers/staging/batman-adv/types.h             |   12 ++-
 drivers/staging/batman-adv/vis.c               |    9 +-
 14 files changed, 506 insertions(+), 193 deletions(-)
