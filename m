Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 May 2011 23:14:52 +0200
Message-Id: <1305407694-16789-7-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-1-git-send-email-sven@narfation.org>
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv: Remove explicit casts cast
	from void* for store
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

It is not necessary to cast a void* to the pointer type when we just
store it and don't want to do pointer arithmetic before the actual
assignment.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bitarray.c          |    2 +-
 hard-interface.c    |    2 +-
 translation-table.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index 767e237..700ee4f 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -130,7 +130,7 @@ static void bit_reset_window(unsigned long *seq_bits)
 char bit_get_packet(void *priv, unsigned long *seq_bits,
 		    int32_t seq_num_diff, int8_t set_mark)
 {
-	struct bat_priv *bat_priv = (struct bat_priv *)priv;
+	struct bat_priv *bat_priv = priv;
 
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it. */
diff --git a/hard-interface.c b/hard-interface.c
index 915e12b..e626e75 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -523,7 +523,7 @@ void hardif_remove_interfaces(void)
 static int hard_if_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
-	struct net_device *net_dev = (struct net_device *)ptr;
+	struct net_device *net_dev = ptr;
 	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
 	struct hard_iface *primary_if = NULL;
 	struct bat_priv *bat_priv;
diff --git a/translation-table.c b/translation-table.c
index be7b5cc..802eace 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -313,7 +313,7 @@ out:
 
 static void _tt_local_del(struct hlist_node *node, void *arg)
 {
-	struct bat_priv *bat_priv = (struct bat_priv *)arg;
+	struct bat_priv *bat_priv = arg;
 	void *data = container_of(node, struct tt_local_entry, hash_entry);
 
 	kfree(data);
-- 
1.7.5.1

