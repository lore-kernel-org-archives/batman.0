Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri,  2 Dec 2011 15:15:44 +0100
Message-Id: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Move is_out_of_time() to main.c
	for general use
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
To: b.a.t.m.a.n@lists.open-mesh.org

Both translation tables and network coding use timeouts to do house
keeping, so we might as well share the function used to compare a
timestamp+timeout with current time.

Also, this patch removes a trailing newline in is_my_mac() to satisfy checkpatch

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 main.c              |    4 ++++
 main.h              |    1 +
 translation-table.c |    8 --------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/main.c b/main.c
index fb87bdc..0930bb4 100644
--- a/main.c
+++ b/main.c
@@ -170,7 +170,11 @@ int is_my_mac(const uint8_t *addr)
 	}
 	rcu_read_unlock();
 	return 0;
+}
 
+bool is_out_of_time(unsigned long timestamp, unsigned long timeout)
+{
+	return time_is_before_jiffies(timestamp + msecs_to_jiffies(timeout));
 }
 
 module_init(batman_init);
diff --git a/main.h b/main.h
index 464439f..92eb37b 100644
--- a/main.h
+++ b/main.h
@@ -159,6 +159,7 @@ void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
 int is_my_mac(const uint8_t *addr);
+bool is_out_of_time(unsigned long timestamp, unsigned long timeout);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 int debug_log(struct bat_priv *bat_priv, const char *fmt, ...) __printf(2, 3);
diff --git a/translation-table.c b/translation-table.c
index 7a7df4a..b22f8d9 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -108,14 +108,6 @@ static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
 
 }
 
-static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
-{
-	unsigned long deadline;
-	deadline = starting_time + msecs_to_jiffies(timeout);
-
-	return time_after(jiffies, deadline);
-}
-
 static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 {
 	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
-- 
1.7.7.4

