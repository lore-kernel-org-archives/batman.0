Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 17:03:22 +0800
Message-Id: <1356426206-8667-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
References: <1356426206-8667-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: rename batadv_if_list_entry
	struct to make clear it is used by vis
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |   19 ++++++++++---------
 vis.c   |    8 ++++----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/types.h b/types.h
index 9a66115..d17517c 100644
--- a/types.h
+++ b/types.h
@@ -426,15 +426,6 @@ struct batadv_forw_packet {
 	struct batadv_hard_iface *if_incoming;
 };
 
-/* While scanning for vis-entries of a particular vis-originator
- * this list collects its interfaces to create a subgraph/cluster
- * out of them later
- */
-struct batadv_if_list_entry {
-	uint8_t addr[ETH_ALEN];
-	bool primary;
-	struct hlist_node list;
-};
 struct batadv_frag_packet_list_entry {
 	struct list_head list;
 	uint16_t seqno;
@@ -467,6 +458,16 @@ struct batadv_recvlist_node {
 	uint8_t mac[ETH_ALEN];
 };
 
+/* While scanning for vis-entries of a particular vis-originator
+ * this list collects its interfaces to create a subgraph/cluster
+ * out of them later
+ */
+struct batadv_vis_if_list_entry {
+	uint8_t addr[ETH_ALEN];
+	bool primary;
+	struct hlist_node list;
+};
+
 struct batadv_algo_ops {
 	struct hlist_node list;
 	char *name;
diff --git a/vis.c b/vis.c
index 60eb9b7..f7c25ce 100644
--- a/vis.c
+++ b/vis.c
@@ -129,7 +129,7 @@ static void batadv_vis_data_insert_interface(const uint8_t *interface,
 					     struct hlist_head *if_list,
 					     bool primary)
 {
-	struct batadv_if_list_entry *entry;
+	struct batadv_vis_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
@@ -149,7 +149,7 @@ static void batadv_vis_data_insert_interface(const uint8_t *interface,
 static void batadv_vis_data_read_prim_sec(struct seq_file *seq,
 					  const struct hlist_head *if_list)
 {
-	struct batadv_if_list_entry *entry;
+	struct batadv_vis_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
@@ -199,7 +199,7 @@ static void batadv_vis_data_read_entries(struct seq_file *seq,
 					 struct batadv_vis_info_entry *entries)
 {
 	int i;
-	struct batadv_if_list_entry *entry;
+	struct batadv_vis_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, list, list) {
@@ -225,7 +225,7 @@ static void batadv_vis_seq_print_text_bucket(struct seq_file *seq,
 	struct batadv_vis_packet *packet;
 	uint8_t *entries_pos;
 	struct batadv_vis_info_entry *entries;
-	struct batadv_if_list_entry *entry;
+	struct batadv_vis_if_list_entry *entry;
 	struct hlist_node *pos, *n;
 
 	HLIST_HEAD(vis_if_list);
-- 
1.7.10.4

