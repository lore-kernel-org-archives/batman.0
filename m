Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:51 +0200
Message-Id: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (2)
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

here are some smaller cleanup/bugfix patches for 2.6.37. All patches needed for
that patchset are already part of your staging-next tree.

All patches are cleanup patches and no new feature is added.

thanks,
	Sven

Linus Lüssing (1):
      Staging: batman-adv: Always synchronize rcu's on module shutdown

Marek Lindner (1):
      Staging: batman-adv: removing redundant assignment of skb->dev

Sven Eckelmann (2):
      Staging: batman-adv: Remove currently unused gw_* datastructures
      Staging: batman-adv: Add rcu TODO

Vasiliy Kulikov (1):
      Staging: batman-adv: check kmalloc() return value

 drivers/staging/batman-adv/TODO             |    5 +++++
 drivers/staging/batman-adv/main.c           |    7 ++-----
 drivers/staging/batman-adv/routing.c        |    8 ++++++--
 drivers/staging/batman-adv/soft-interface.c |    5 +----
 drivers/staging/batman-adv/types.h          |    3 ---
 drivers/staging/batman-adv/unicast.c        |    8 ++++++--
 drivers/staging/batman-adv/unicast.h        |    2 +-
 7 files changed, 21 insertions(+), 17 deletions(-)
