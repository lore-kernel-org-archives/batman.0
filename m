Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Feb 2016 22:56:34 +0100
Message-Id: <1456178194-29307-2-git-send-email-sven@narfation.org>
In-Reply-To: <1456178194-29307-1-git-send-email-sven@narfation.org>
References: <1456178194-29307-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Split
	batadv_iv_ogm_orig_del_if function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

batadv_iv_ogm_orig_del_if handles two different buffers bcast_own and
bcast_own_sum which should be resized. The error handling two for
allocating these buffers causes the complexity of this function. This can
be avoided completely when the function is split into a main function
handling the locking, freeing and call of the subfunctions.

The subfunction can then independently handle the resize of the buffers.
This also allows to easily reuse the old buffer (which always is larger) in
case a smaller buffer could not be allocated without increasing the code
complexity.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 131 ++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 47 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index af8bd86..a7d5cc4 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
 #include <linux/printk.h>
@@ -173,6 +174,79 @@ unlock:
 }
 
 /**
+ * batadv_iv_ogm_drop_bcast_own_entry - drop section of bcast_own
+ * @orig_node: the orig_node that has to be changed
+ * @max_if_num: the current amount of interfaces
+ * @del_if_num: the index of the interface being removed
+ */
+static void
+batadv_iv_ogm_drop_bcast_own_entry(struct batadv_orig_node *orig_node,
+				   int max_if_num, int del_if_num)
+{
+	size_t chunk_size;
+	size_t if_offset;
+	void *data_ptr;
+
+	lockdep_assert_held(&orig_node->bat_iv.ogm_cnt_lock);
+
+	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
+	data_ptr = kmalloc_array(max_if_num, chunk_size, GFP_ATOMIC);
+	if (!data_ptr)
+		/* use old buffer when new one could not be allocated */
+		data_ptr = orig_node->bat_iv.bcast_own;
+
+	/* copy first part */
+	memmove(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
+
+	/* copy second part */
+	if_offset = (del_if_num + 1) * chunk_size;
+	memmove((char *)data_ptr + del_if_num * chunk_size,
+		(uint8_t *)orig_node->bat_iv.bcast_own + if_offset,
+		(max_if_num - del_if_num) * chunk_size);
+
+	/* bcast_own was shrunk down in new buffer; free old one */
+	if (orig_node->bat_iv.bcast_own != data_ptr) {
+		kfree(orig_node->bat_iv.bcast_own);
+		orig_node->bat_iv.bcast_own = data_ptr;
+	}
+}
+
+/**
+ * batadv_iv_ogm_drop_bcast_own_sum_entry - drop section of bcast_own_sum
+ * @orig_node: the orig_node that has to be changed
+ * @max_if_num: the current amount of interfaces
+ * @del_if_num: the index of the interface being removed
+ */
+static void
+batadv_iv_ogm_drop_bcast_own_sum_entry(struct batadv_orig_node *orig_node,
+				       int max_if_num, int del_if_num)
+{
+	size_t if_offset;
+	void *data_ptr;
+
+	lockdep_assert_held(&orig_node->bat_iv.ogm_cnt_lock);
+
+	data_ptr = kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
+	if (!data_ptr)
+		/* use old buffer when new one could not be allocated */
+		data_ptr = orig_node->bat_iv.bcast_own_sum;
+
+	memmove(data_ptr, orig_node->bat_iv.bcast_own_sum,
+		del_if_num * sizeof(u8));
+
+	if_offset = (del_if_num + 1) * sizeof(u8);
+	memmove((char *)data_ptr + del_if_num * sizeof(u8),
+		orig_node->bat_iv.bcast_own_sum + if_offset,
+		(max_if_num - del_if_num) * sizeof(u8));
+
+	/* bcast_own_sum was shrunk down in new buffer; free old one */
+	if (orig_node->bat_iv.bcast_own_sum != data_ptr) {
+		kfree(orig_node->bat_iv.bcast_own_sum);
+		orig_node->bat_iv.bcast_own_sum = data_ptr;
+	}
+}
+
+/**
  * batadv_iv_ogm_orig_del_if - change the private structures of the orig_node to
  *  exclude the removed interface
  * @orig_node: the orig_node that has to be changed
@@ -184,60 +258,23 @@ unlock:
 static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 				     int max_if_num, int del_if_num)
 {
-	int ret = -ENOMEM;
-	size_t chunk_size, if_offset;
-	void *data_ptr = NULL;
-
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
-	/* last interface was removed */
-	if (max_if_num == 0)
-		goto free_bcast_own;
-
-	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc_array(max_if_num, chunk_size, GFP_ATOMIC);
-	if (!data_ptr)
-		goto unlock;
-
-	/* copy first part */
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
-
-	/* copy second part */
-	if_offset = (del_if_num + 1) * chunk_size;
-	memcpy((char *)data_ptr + del_if_num * chunk_size,
-	       (uint8_t *)orig_node->bat_iv.bcast_own + if_offset,
-	       (max_if_num - del_if_num) * chunk_size);
-
-free_bcast_own:
-	kfree(orig_node->bat_iv.bcast_own);
-	orig_node->bat_iv.bcast_own = data_ptr;
-
-	if (max_if_num == 0)
-		goto free_own_sum;
-
-	data_ptr = kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
-	if (!data_ptr) {
+	if (max_if_num == 0) {
 		kfree(orig_node->bat_iv.bcast_own);
-		goto unlock;
+		kfree(orig_node->bat_iv.bcast_own_sum);
+		orig_node->bat_iv.bcast_own = NULL;
+		orig_node->bat_iv.bcast_own_sum = NULL;
+	} else {
+		batadv_iv_ogm_drop_bcast_own_entry(orig_node, max_if_num,
+						   del_if_num);
+		batadv_iv_ogm_drop_bcast_own_sum_entry(orig_node, max_if_num,
+						       del_if_num);
 	}
 
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
-	       del_if_num * sizeof(u8));
-
-	if_offset = (del_if_num + 1) * sizeof(u8);
-	memcpy((char *)data_ptr + del_if_num * sizeof(u8),
-	       orig_node->bat_iv.bcast_own_sum + if_offset,
-	       (max_if_num - del_if_num) * sizeof(u8));
-
-free_own_sum:
-	kfree(orig_node->bat_iv.bcast_own_sum);
-	orig_node->bat_iv.bcast_own_sum = data_ptr;
-
-	ret = 0;
-unlock:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.7.0

