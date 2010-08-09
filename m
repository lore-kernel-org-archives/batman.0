Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:42 +0200
Message-Id: <1281391002-21577-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] Staging: batman-adv: fix own mac address
	detection
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Earlier batman-adv versions would only create a batman_if struct after
a corresponding interface had been activated by a user. Now each
existing system interface has a batman_if struct and has to be checked
by verifying the IF_ACTIVE flag.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 2686019..ef7c20a 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -250,10 +250,13 @@ int choose_orig(void *data, int32_t size)
 int is_my_mac(uint8_t *addr)
 {
 	struct batman_if *batman_if;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if ((batman_if->net_dev) &&
-		    (compare_orig(batman_if->net_dev->dev_addr, addr))) {
+		if (batman_if->if_status != IF_ACTIVE)
+			continue;
+
+		if (compare_orig(batman_if->net_dev->dev_addr, addr)) {
 			rcu_read_unlock();
 			return 1;
 		}
-- 
1.7.1

