Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 19 Jan 2013 21:27:52 +0800
Message-Id: <1358602079-24024-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1358602079-24024-1-git-send-email-ordex@autistici.org>
References: <1358602079-24024-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batman-adv: rename
	batadv_recvlist_node struct to make clear it is used by vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/types.h | 2 +-
 net/batman-adv/vis.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d17517c..c56e0d9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -453,7 +453,7 @@ struct batadv_vis_info_entry {
 	uint8_t  quality;	/* quality = 0 client */
 } __packed;
 
-struct batadv_recvlist_node {
+struct batadv_vis_recvlist_node {
 	struct list_head list;
 	uint8_t mac[ETH_ALEN];
 };
diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index 3d42b17..2e70ec1 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -36,7 +36,7 @@ static void batadv_free_info(struct kref *ref)
 {
 	struct batadv_vis_info *info;
 	struct batadv_priv *bat_priv;
-	struct batadv_recvlist_node *entry, *tmp;
+	struct batadv_vis_recvlist_node *entry, *tmp;
 
 	info = container_of(ref, struct batadv_vis_info, refcount);
 	bat_priv = info->bat_priv;
@@ -305,7 +305,7 @@ static void batadv_send_list_del(struct batadv_vis_info *info)
 static void batadv_recv_list_add(struct batadv_priv *bat_priv,
 				 struct list_head *recv_list, const char *mac)
 {
-	struct batadv_recvlist_node *entry;
+	struct batadv_vis_recvlist_node *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -322,7 +322,7 @@ static int batadv_recv_list_is_in(struct batadv_priv *bat_priv,
 				  const struct list_head *recv_list,
 				  const char *mac)
 {
-	const struct batadv_recvlist_node *entry;
+	const struct batadv_vis_recvlist_node *entry;
 
 	spin_lock_bh(&bat_priv->vis.list_lock);
 	list_for_each_entry(entry, recv_list, list) {
-- 
1.8.0.2

