Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue,  9 Mar 2010 08:15:17 +0100
Message-Id: <1268118917-6654-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing source-if info in
	vis raw
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

With this patch, a line for each _source interface_ for every node will
be used in the vis raw output instead of one line per originator. This
stops discarding valuable information about secondary interfaces.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 proc.c |   33 ++++++++++++++++++++++++++-------
 vis.c  |   25 +++++++++----------------
 vis.h  |    7 +++++--
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/proc.c b/proc.c
index 1c12613..ab5047f 100644
--- a/proc.c
+++ b/proc.c
@@ -370,6 +370,8 @@ static int proc_vis_data_read(struct seq_file *seq, void *offset)
 	struct vis_info *info;
 	struct vis_info_entry *entries;
 	HLIST_HEAD(vis_if_list);
+	struct if_list_entry *entry;
+	struct hlist_node *pos, *n;
 	int i;
 	char tmp_addr_str[ETH_STR_LEN];
 	unsigned long flags;
@@ -388,17 +390,34 @@ static int proc_vis_data_read(struct seq_file *seq, void *offset)
 		info = hashit.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
-		addr_to_string(tmp_addr_str, info->packet.vis_orig);
-		seq_printf(seq, "%s,", tmp_addr_str);
 
 		for (i = 0; i < info->packet.entries; i++) {
-			proc_vis_read_entry(seq, &entries[i], &vis_if_list,
-					    info->packet.vis_orig);
+			if (entries[i].quality == 0)
+				continue;
+			proc_vis_insert_interface(entries[i].src, &vis_if_list,
+				compare_orig(entries[i].src,
+						info->packet.vis_orig));
 		}
 
-		/* add primary/secondary records */
-		proc_vis_read_prim_sec(seq, &vis_if_list);
-		seq_printf(seq, "\n");
+		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
+			addr_to_string(tmp_addr_str, entry->addr);
+			seq_printf(seq, "%s,", tmp_addr_str);
+
+			for (i = 0; i < info->packet.entries; i++)
+				proc_vis_read_entry(seq, &entries[i],
+						entry->addr, entry->primary);
+
+			/* add primary/secondary records */
+			if (compare_orig(entry->addr, info->packet.vis_orig))
+				proc_vis_read_prim_sec(seq, &vis_if_list);
+
+			seq_printf(seq, "\n");
+		}
+
+		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
+			hlist_del(&entry->list);
+			kfree(entry);
+		}
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 
diff --git a/vis.c b/vis.c
index 4f1339a..fa8a487 100644
--- a/vis.c
+++ b/vis.c
@@ -87,7 +87,7 @@ static int vis_info_choose(void *data, int size)
 
 /* insert interface to the list of interfaces of one originator, if it
  * does not already exist in the list */
-static void proc_vis_insert_interface(const uint8_t *interface,
+void proc_vis_insert_interface(const uint8_t *interface,
 				      struct hlist_head *if_list,
 				      bool primary)
 {
@@ -112,39 +112,32 @@ void proc_vis_read_prim_sec(struct seq_file *seq,
 			    struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
-	struct hlist_node *pos, *n;
+	struct hlist_node *pos;
 	char tmp_addr_str[ETH_STR_LEN];
 
-	hlist_for_each_entry_safe(entry, pos, n, if_list, list) {
-		if (entry->primary) {
+	hlist_for_each_entry(entry, pos, if_list, list) {
+		if (entry->primary)
 			seq_printf(seq, "PRIMARY, ");
-		} else {
+		else {
 			addr_to_string(tmp_addr_str, entry->addr);
 			seq_printf(seq, "SEC %s, ", tmp_addr_str);
 		}
-
-		hlist_del(&entry->list);
-		kfree(entry);
 	}
 }
 
 /* read an entry  */
 void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
-				struct hlist_head *if_list,
-				uint8_t *vis_orig)
+				uint8_t *src,
+				bool primary)
 {
 	char to[40];
 
 	addr_to_string(to, entry->dest);
-	if (entry->quality == 0) {
-		proc_vis_insert_interface(vis_orig, if_list, true);
+	if (primary && entry->quality == 0)
 		seq_printf(seq, "HNA %s, ", to);
-	} else {
-		proc_vis_insert_interface(entry->src, if_list,
-					  compare_orig(entry->src, vis_orig));
+	else if (compare_orig(entry->src, src))
 		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
-	}
 }
 
 /* add the info packet to the send list, if it was not
diff --git a/vis.h b/vis.h
index 465da47..a1f92a4 100644
--- a/vis.h
+++ b/vis.h
@@ -49,10 +49,13 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
+void proc_vis_insert_interface(const uint8_t *interface,
+				      struct hlist_head *if_list,
+				      bool primary);
 void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
-				struct hlist_head *if_list,
-				uint8_t *vis_orig);
+				uint8_t *src,
+				bool primary);
 void proc_vis_read_prim_sec(struct seq_file *seq,
 			    struct hlist_head *if_list);
 void receive_server_sync_packet(struct vis_packet *vis_packet,
-- 
1.7.0

