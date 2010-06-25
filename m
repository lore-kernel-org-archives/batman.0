Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 00:28:20 +0200
Message-Id: <1277504905-27672-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] Staging: batman-adv: Lower resolution
	for timeouts
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
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

It is enough for our timeouts to keep them in seconds instead of miliseconds.
With a too high resolution, we might even risk an integer overflow, so this
patch should make things more safe.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.h              |    4 ++--
 drivers/staging/batman-adv/originator.c        |    6 ++----
 drivers/staging/batman-adv/translation-table.c |    3 +--
 drivers/staging/batman-adv/vis.c               |    2 +-
 drivers/staging/batman-adv/vis.h               |    2 +-
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index ab4c9e7..49aaec5 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -36,10 +36,10 @@
 #define JITTER 20
 #define TTL 50			  /* Time To Live of broadcast messages */
 
-#define PURGE_TIMEOUT 200000	  /* purge originators after time in ms if no
+#define PURGE_TIMEOUT 200	/* purge originators after time in seconds if no
 				   * valid packet comes in -> TODO: check
 				   * influence on TQ_LOCAL_WINDOW_SIZE */
-#define LOCAL_HNA_TIMEOUT 3600000
+#define LOCAL_HNA_TIMEOUT 3600 /* in seconds */
 
 #define TQ_LOCAL_WINDOW_SIZE 64	  /* sliding packet range of received originator
 				   * messages in squence numbers (should be a
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 195c1ee..26bbf2d 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -193,8 +193,7 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
 
 		if ((time_after(jiffies,
-			       (neigh_node->last_valid +
-				((PURGE_TIMEOUT * HZ) / 1000)))) ||
+			neigh_node->last_valid + PURGE_TIMEOUT * HZ)) ||
 		    (neigh_node->if_incoming->if_status ==
 						IF_TO_BE_REMOVED)) {
 
@@ -231,8 +230,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 	struct neigh_node *best_neigh_node;
 
 	if (time_after(jiffies,
-		       (orig_node->last_valid +
-			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
+		orig_node->last_valid + 2 * PURGE_TIMEOUT * HZ)) {
 
 		bat_dbg(DBG_BATMAN,
 			"Originator timeout: originator %pM, last_valid %lu\n",
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index fdd902d..9e3c845 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -257,8 +257,7 @@ static void hna_local_purge(struct work_struct *work)
 	while (hash_iterate(hna_local_hash, &hashit)) {
 		hna_local_entry = hashit.bucket->data;
 
-		timeout = hna_local_entry->last_seen +
-			((LOCAL_HNA_TIMEOUT * HZ) / 1000);
+		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
 		if ((!hna_local_entry->never_purge) &&
 		    time_after(jiffies, timeout))
 			hna_local_del(hna_local_entry, "address timed out");
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index ed2c1f9..ddee0f2 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -597,7 +597,7 @@ static void purge_vis_packets(void)
 		if (info == my_vis_info)	/* never purge own data. */
 			continue;
 		if (time_after(jiffies,
-			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
+			       info->first_seen + VIS_TIMEOUT * HZ)) {
 			hash_remove_bucket(vis_hash, &hashit);
 			send_list_del(info);
 			kref_put(&info->refcount, free_info);
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index 1cfadce..e152cd7 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -19,7 +19,7 @@
  *
  */
 
-#define VIS_TIMEOUT		200000
+#define VIS_TIMEOUT		200	/* timeout of vis packets in seconds */
 
 struct vis_info {
 	unsigned long       first_seen;
-- 
1.7.1

