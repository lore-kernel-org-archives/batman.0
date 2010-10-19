Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 11:59:08 +0200
Message-Id: <1287482355-16319-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (4)
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

All patches are cleanup and bugfix patches and no new feature is added.

thanks,
        Sven

Linus Lüssing (1):
      Staging: batman-adv: Fix resizing of broadcast seqno buffers on if deletion

Marek Lindner (4):
      Staging: batman-adv: document fragmentation sysfs API
      Staging: batman-adv: protect against ogm packet overflow by checking table length
      Staging: batman-adv: fix crash when new OGM is generated
      Staging: batman-adv: process OGMs bigger than MAX_AGGREGATION_BYTES

Sven Eckelmann (2):
      Staging: batman-adv: Add hash recommendations to TODO
      Staging: batman-adv: Don't dereference unchecked incoming soft_iface

 drivers/staging/batman-adv/TODO                 |    4 ++++
 drivers/staging/batman-adv/aggregation.c        |   17 +++++++++++------
 drivers/staging/batman-adv/originator.c         |    4 ++--
 drivers/staging/batman-adv/send.c               |    7 +++++--
 drivers/staging/batman-adv/sysfs-class-net-mesh |    8 ++++++++
 drivers/staging/batman-adv/translation-table.c  |    9 +++++++--
 6 files changed, 37 insertions(+), 12 deletions(-)
