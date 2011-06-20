Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2011 12:16:54 +0200
Message-Id: <1308565025-21293-2-git-send-email-sven@narfation.org>
In-Reply-To: <1308565025-21293-1-git-send-email-sven@narfation.org>
References: <1308565025-21293-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/12] batman-adv: Move compare_orig to
	originator.c
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

compare_orig is only used in context of orig_node which is managed
inside originator.c. It is not necessary to keep that function inside
the header originator.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c |    8 ++++++++
 net/batman-adv/originator.h |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a6c35d4..991a6e7 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -37,6 +37,14 @@ static void start_purge_timer(struct bat_priv *bat_priv)
 	queue_delayed_work(bat_event_workqueue, &bat_priv->orig_work, 1 * HZ);
 }
 
+/* returns 1 if they are the same originator */
+static int compare_orig(const struct hlist_node *node, const void *data2)
+{
+	const void *data1 = container_of(node, struct orig_node, hash_entry);
+
+	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+}
+
 int originator_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 8e307af..cfc1f60 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -40,14 +40,6 @@ int orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num);
 int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
 
 
-/* returns 1 if they are the same originator */
-static inline int compare_orig(const struct hlist_node *node, const void *data2)
-{
-	const void *data1 = container_of(node, struct orig_node, hash_entry);
-
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
-}
-
 /* hashfunction to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline int choose_orig(const void *data, int32_t size)
-- 
1.7.5.3

