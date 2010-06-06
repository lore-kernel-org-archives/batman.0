Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:28:12 +0200
Message-Id: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (renewed)
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

Hi,

here are patches targetted for 2.6.36. These replace all patches send to you
for 2.6.36 in mails following
1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de due to conflicting
changes for 2.6.35 from Dan Carpenter and Javier Martinez Canillas.

There are also 3 new patches (7-9).

Maybe we could time our patches for upcoming kernels. Is there a specific point
where you start to insert new patches for the next kernel into staging-next?
Currently we know that it should be at least a week before a kernel is released
to allow other people to test changes in linux-next. 

Best regards,
	Sven

 drivers/staging/batman-adv/Makefile                |    2 +-
 drivers/staging/batman-adv/bat_debugfs.c           |  148 ++++++++
 drivers/staging/batman-adv/bat_debugfs.h           |   33 ++
 drivers/staging/batman-adv/bat_sysfs.c             |  151 ++-------
 drivers/staging/batman-adv/bat_sysfs.h             |   13 +
 drivers/staging/batman-adv/device.c                |  354 --------------------
 drivers/staging/batman-adv/device.h                |   36 --
 drivers/staging/batman-adv/hard-interface.c        |   14 +-
 drivers/staging/batman-adv/icmp_socket.c           |  328 ++++++++++++++++++
 drivers/staging/batman-adv/icmp_socket.h           |   28 ++
 drivers/staging/batman-adv/main.c                  |   27 +-
 drivers/staging/batman-adv/main.h                  |    6 +-
 drivers/staging/batman-adv/originator.c            |   64 +---
 drivers/staging/batman-adv/originator.h            |    3 +-
 drivers/staging/batman-adv/routing.c               |    4 +-
 drivers/staging/batman-adv/send.c                  |    9 +-
 .../staging/batman-adv/sysfs-class-net-batman-adv  |   14 +
 drivers/staging/batman-adv/sysfs-class-net-mesh    |   25 ++
 drivers/staging/batman-adv/translation-table.c     |  132 ++++----
 drivers/staging/batman-adv/translation-table.h     |    6 +-
 drivers/staging/batman-adv/types.h                 |    5 +-
 drivers/staging/batman-adv/vis.c                   |  115 +++++--
 drivers/staging/batman-adv/vis.h                   |    3 +-
 23 files changed, 821 insertions(+), 699 deletions(-)

Joe Perches (1):
      Staging: batman-adv: Convert MAC_FMT to %pM

Linus Lüssing (1):
      Staging: batman-adv: Adding netfilter-bridge hooks

Marek Lindner (4):
      Staging: batman-adv: remove redundant struct declaration
      Staging: batman-adv: convert all sysfs files to single value files
      Staging: batman-adv: Add information about batman-adv sysfs entries
      Staging: batman-adv: remove superfluous hint to "translation table"

Simon Wunderlich (1):
      Staging: batman-adv: convert vis_interval into define

Sven Eckelmann (2):
      Staging: batman-adv: Move device for icmp injection to debugfs
      Staging: batman-adv: Move tables from sysfs to debugfs

