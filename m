Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  5 Aug 2012 18:13:17 +0200
Message-Id: <1344183197-25945-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: consolidate duplicated
	primary_if checking code
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
 bridge_loop_avoidance.c |   36 ++++++------------------------------
 gateway_client.c        |   19 ++++---------------
 main.c                  |   29 +++++++++++++++++++++++++++++
 main.h                  |    2 ++
 originator.c            |   19 +++----------------
 translation-table.c     |   36 ++++++------------------------------
 6 files changed, 50 insertions(+), 91 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0a9084a..0921509 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1576,23 +1576,11 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	uint32_t i;
 	bool is_own;
-	int ret = 0;
 	uint8_t *primary_addr;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
-		goto out;
-	}
 
 	primary_addr = primary_if->net_dev->dev_addr;
 	seq_printf(seq,
@@ -1619,7 +1607,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
 
 int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
@@ -1634,23 +1622,11 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	int secs, msecs;
 	uint32_t i;
 	bool is_own;
-	int ret = 0;
 	uint8_t *primary_addr;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
-		goto out;
-	}
 
 	primary_addr = primary_if->net_dev->dev_addr;
 	seq_printf(seq,
@@ -1684,5 +1660,5 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
diff --git a/gateway_client.c b/gateway_client.c
index 15d67ab..dd07c7e 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -477,22 +477,11 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct batadv_gw_node *gw_node;
 	struct hlist_node *node;
-	int gw_count = 0, ret = 0;
+	int gw_count = 0;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
-		goto out;
-	}
 
 	seq_printf(seq,
 		   "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
@@ -519,7 +508,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
 
 static bool batadv_is_type_dhcprequest(struct sk_buff *skb, int header_len)
diff --git a/main.c b/main.c
index b4aa470..d4f780c 100644
--- a/main.c
+++ b/main.c
@@ -188,6 +188,35 @@ int batadv_is_my_mac(const uint8_t *addr)
 	return 0;
 }
 
+struct batadv_hard_iface *
+batadv_seq_print_text_primary_if_get(struct seq_file *seq)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+
+	if (!primary_if) {
+		seq_printf(seq,
+			   "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+			   net_dev->name);
+		goto out;
+	}
+
+	if (primary_if->if_status == BATADV_IF_ACTIVE)
+		goto out;
+
+	seq_printf(seq,
+		   "BATMAN mesh %s disabled - primary interface not active\n",
+		   net_dev->name);
+	batadv_hardif_free_ref(primary_if);
+	primary_if = NULL;
+
+out:
+	return primary_if;
+}
+
 static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 					struct batadv_hard_iface *recv_if)
 {
diff --git a/main.h b/main.h
index f9a3115..115fb56 100644
--- a/main.h
+++ b/main.h
@@ -155,6 +155,8 @@ void batadv_mesh_free(struct net_device *soft_iface);
 void batadv_inc_module_count(void);
 void batadv_dec_module_count(void);
 int batadv_is_my_mac(const uint8_t *addr);
+struct batadv_hard_iface *
+batadv_seq_print_text_primary_if_get(struct seq_file *seq);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
diff --git a/originator.c b/originator.c
index ac9bdf8..d9c14b8 100644
--- a/originator.c
+++ b/originator.c
@@ -415,23 +415,10 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	int last_seen_msecs;
 	unsigned long last_seen_jiffies;
 	uint32_t i;
-	int ret = 0;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
-		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
 
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
@@ -485,7 +472,7 @@ next:
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
 
 static int batadv_orig_node_add_if(struct batadv_orig_node *orig_node,
diff --git a/translation-table.c b/translation-table.c
index 37ae4a9..b3f311b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -433,22 +433,10 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
-	int ret = 0;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
-		goto out;
-	}
 
 	seq_printf(seq,
 		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
@@ -478,7 +466,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
 
 static void
@@ -841,22 +829,10 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
-	int ret = 0;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				 net_dev->name);
+	primary_if = batadv_seq_print_text_primary_if_get(seq);
+	if (!primary_if)
 		goto out;
-	}
-
-	if (primary_if->if_status != BATADV_IF_ACTIVE) {
-		ret = seq_printf(seq,
-				 "BATMAN mesh %s disabled - primary interface not active\n",
-				 net_dev->name);
-		goto out;
-	}
 
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
@@ -880,7 +856,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	return ret;
+	return 0;
 }
 
 /* deletes the orig list of a tt_global_entry */
-- 
1.7.9.1

