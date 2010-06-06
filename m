Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:28:20 +0200
Message-Id: <1275852501-28523-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] Staging: batman-adv: convert
	vis_interval into define
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

vis_interval does not neccesarily needs to be a variable, as there is
no way to change it anyway (and probably no need to). We can therefore
remove yet another global variable.

Thanks Marek for pointing this out.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    3 ---
 drivers/staging/batman-adv/main.h |    3 ++-
 drivers/staging/batman-adv/vis.c  |    4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 1d52018..ed18b08 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -42,7 +42,6 @@ DEFINE_SPINLOCK(orig_hash_lock);
 DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
 
-atomic_t vis_interval;
 atomic_t bcast_queue_left;
 atomic_t batman_queue_left;
 
@@ -81,8 +80,6 @@ int init_module(void)
 
 	atomic_set(&module_state, MODULE_INACTIVE);
 
-	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
-					 * for debugging now. */
 	atomic_set(&bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&batman_queue_left, BATMAN_QUEUE_LEN);
 
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 232fc25..7cb0b18 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -57,6 +57,8 @@
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 #define ETH_STR_LEN 20
 
+#define VIS_INTERVAL 5000	/* 5 seconds */
+
 #define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
 				   * change the size of
 				   * forw_packet->direct_link_flags */
@@ -135,7 +137,6 @@ extern spinlock_t orig_hash_lock;
 extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
 
-extern atomic_t vis_interval;
 extern atomic_t bcast_queue_left;
 extern atomic_t batman_queue_left;
 extern int16_t num_hna;
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 2b109db..c73774b 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -750,7 +750,7 @@ int vis_init(void)
 	}
 
 	/* prefill the vis info */
-	my_vis_info->first_seen = jiffies - atomic_read(&vis_interval);
+	my_vis_info->first_seen = jiffies - msecs_to_jiffies(VIS_INTERVAL);
 	INIT_LIST_HEAD(&my_vis_info->recv_list);
 	INIT_LIST_HEAD(&my_vis_info->send_list);
 	kref_init(&my_vis_info->refcount);
@@ -813,5 +813,5 @@ void vis_quit(void)
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval) * HZ) / 1000);
+			   (VIS_INTERVAL * HZ) / 1000);
 }
-- 
1.7.1

