Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Dec 2009 01:11:03 +0800
Message-Id: <1261242667-11525-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <200912200101.55746.lindner_marek@yahoo.de>
References: <200912200101.55746.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: moving vis output formats
	out of the kernel land
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

The batman-adv kernel module is able to output visualization data using the
dot draw or JSON format. This patch transforms the output into a generic
format (called vis raw). User space tool may convert the raw data to support
a variety of formats without the need of modifying the kernel module.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/proc.c |  171 +++++++++++++++---------------------------
 batman-adv-kernelland/proc.h |    9 --
 2 files changed, 61 insertions(+), 119 deletions(-)

diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 22471ee..60eec83 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -322,166 +322,117 @@ static int proc_transt_global_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_transt_global_read, NULL);
 }
 
-/* insert interface to the list of interfaces of one originator */
+/* While scanning for vis-entries of a particular vis-originator
+ * this list collects its interfaces to create a subgraph/cluster
+ * out of them later
+ */
+struct if_list_entry {
+	uint8_t addr[ETH_ALEN];
+	bool primary;
+	struct hlist_node list;
+};
 
+/* insert interface to the list of interfaces of one originator, if it
+ * does not already exist in the list */
 static void proc_vis_insert_interface(const uint8_t *interface,
-				      struct vis_if_list **if_entry,
+				      struct hlist_head *if_list,
 				      bool primary)
 {
-	/* Did we get an empty list? (then insert imediately) */
-	if (*if_entry == NULL) {
-		*if_entry = kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
-		if (*if_entry == NULL)
+	struct if_list_entry *entry;
+	struct hlist_node *pos;
+
+	hlist_for_each_entry(entry, pos, if_list, list) {
+		if (compare_orig(entry->addr, (void *)interface))
 			return;
+	}
 
-		(*if_entry)->primary = primary;
-		(*if_entry)->next = NULL;
-		memcpy((*if_entry)->addr, interface, ETH_ALEN);
-	} else {
-		struct vis_if_list *head_if_entry = *if_entry;
-		/* Do we already have this interface in our list? */
-		while (!compare_orig((*if_entry)->addr, (void *)interface)) {
-
-			/* Or did we reach the end (then append the interface) */
-			if ((*if_entry)->next == NULL) {
-				(*if_entry)->next = kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
-				if ((*if_entry)->next == NULL)
-					return;
-
-				memcpy((*if_entry)->next->addr, interface, ETH_ALEN);
-				(*if_entry)->next->primary = primary;
-				(*if_entry)->next->next = NULL;
-				break;
-			}
-			*if_entry = (*if_entry)->next;
+	/* its a new address, add it to the list */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return;
+	memcpy(entry->addr, interface, ETH_ALEN);
+	entry->primary = primary;
+	hlist_add_head(&entry->list, if_list);
+}
+
+static void proc_vis_read_prim_sec(struct seq_file *seq,
+				   struct hlist_head *if_list)
+{
+	struct if_list_entry *entry;
+	struct hlist_node *pos, *n;
+	char tmp_addr_str[ETH_STR_LEN];
+
+	hlist_for_each_entry_safe(entry, pos, n, if_list, list) {
+		if (entry->primary) {
+			seq_printf(seq, "PRIMARY, ");
+		} else {
+			addr_to_string(tmp_addr_str, entry->addr);
+			seq_printf(seq, "SEC %s, ", tmp_addr_str);
 		}
-		/* Rewind the list to its head */
-		*if_entry = head_if_entry;
+
+		hlist_del(&entry->list);
+		kfree(entry);
 	}
 }
-/* read an entry  */
 
+/* read an entry  */
 static void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
-				struct vis_if_list **if_entry,
-				uint8_t *vis_orig,
-				uint8_t current_format,
-				uint8_t first_line)
+				struct hlist_head *if_list,
+				uint8_t *vis_orig)
 {
-	char from[40];
 	char to[40];
-	int int_part, frac_part;
 
 	addr_to_string(to, entry->dest);
 	if (entry->quality == 0) {
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		proc_vis_insert_interface(vis_orig, if_entry, true);
-#endif /* VIS_SUBCLUSTERS_DISABLED */
-		addr_to_string(from, vis_orig);
-		if (current_format == DOT_DRAW) {
-			seq_printf(seq, "\t\"%s\" -> \"%s\" [label=\"HNA\"]\n",
-				   from, to);
-		} else {
-			seq_printf(seq,
-				   "%s\t{ router : \"%s\", gateway   : \"%s\", label : \"HNA\" }",
-				   (first_line ? "" : ",\n"), from, to);
-		}
+		proc_vis_insert_interface(vis_orig, if_list, true);
+		seq_printf(seq, "HNA %s, ", to);
 	} else {
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		proc_vis_insert_interface(entry->src, if_entry, compare_orig(entry->src, vis_orig));
-#endif /* VIS_SUBCLUSTERS_DISABLED */
-		addr_to_string(from, entry->src);
-
-		/* kernel has no printf-support for %f? it'd be better to return
-		 * this in float. */
-
-		int_part = TQ_MAX_VALUE / entry->quality;
-		frac_part = 1000 * TQ_MAX_VALUE / entry->quality - int_part * 1000;
-
-		if (current_format == DOT_DRAW) {
-			seq_printf(seq,
-				   "\t\"%s\" -> \"%s\" [label=\"%d.%d\"]\n",
-				   from, to, int_part, frac_part);
-		} else {
-			seq_printf(seq,
-				   "%s\t{ router : \"%s\", neighbor : \"%s\", label : %d.%d }",
-				   (first_line ? "" : ",\n"), from, to, int_part, frac_part);
-		}
+		proc_vis_insert_interface(entry->src, if_list,
+					  compare_orig(entry->src, vis_orig));
+		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
 	}
 }
 
-
 static int proc_vis_read(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
 	struct vis_info *info;
 	struct vis_info_entry *entries;
-	struct vis_if_list *if_entries = NULL;
+	HLIST_HEAD(vis_if_list);
 	int i;
-	uint8_t current_format, first_line = 1;
-#ifndef VIS_SUBCLUSTERS_DISABLED
+	uint8_t current_format;
 	char tmp_addr_str[ETH_STR_LEN];
-	struct vis_if_list *tmp_if_next;
-#endif /* VIS_SUBCLUSTERS_DISABLED */
 
 	current_format = vis_format;
 
 	rcu_read_lock();
 	if (list_empty(&if_list) || (!is_vis_server())) {
 		rcu_read_unlock();
-		if (current_format == DOT_DRAW)
-			seq_printf(seq, "digraph {\n}\n");
 		goto end;
 	}
 
 	rcu_read_unlock();
 
-	if (current_format == DOT_DRAW)
-		seq_printf(seq, "digraph {\n");
-
 	spin_lock(&vis_hash_lock);
 	while (hash_iterate(vis_hash, &hashit)) {
 		info = hashit.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
+		addr_to_string(tmp_addr_str, info->packet.vis_orig);
+		seq_printf(seq, "%s,", tmp_addr_str);
 
 		for (i = 0; i < info->packet.entries; i++) {
-			proc_vis_read_entry(seq, &entries[i], &if_entries,
-					    info->packet.vis_orig,
-					    current_format, first_line);
-			if (first_line)
-				first_line = 0;
+			proc_vis_read_entry(seq, &entries[i], &vis_if_list,
+					    info->packet.vis_orig);
 		}
 
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		/* Generate subgraphs from the collected items */
-		if (current_format == DOT_DRAW) {
-
-			addr_to_string(tmp_addr_str, info->packet.vis_orig);
-			seq_printf(seq, "\tsubgraph \"cluster_%s\" {\n", tmp_addr_str);
-			while (if_entries != NULL) {
-
-				addr_to_string(tmp_addr_str, if_entries->addr);
-				if (if_entries->primary)
-					seq_printf(seq, "\t\t\"%s\" [peripheries=2]\n", tmp_addr_str);
-				else
-					seq_printf(seq, "\t\t\"%s\"\n", tmp_addr_str);
-
-				/* ... and empty the list while doing this */
-				tmp_if_next = if_entries->next;
-				kfree(if_entries);
-				if_entries = tmp_if_next;
-			}
-			seq_printf(seq, "\t}\n");
-		}
-#endif /* VIS_SUBCLUSTERS_DISABLED */
+		/* add primary/secondary records */
+		proc_vis_read_prim_sec(seq, &vis_if_list);
+		seq_printf(seq, "\n");
 	}
 	spin_unlock(&vis_hash_lock);
 
-	if (current_format == DOT_DRAW)
-		seq_printf(seq, "}\n");
-	else
-		seq_printf(seq, "\n");
 end:
 	return 0;
 }
diff --git a/batman-adv-kernelland/proc.h b/batman-adv-kernelland/proc.h
index 16d3efd..761c5f8 100644
--- a/batman-adv-kernelland/proc.h
+++ b/batman-adv-kernelland/proc.h
@@ -38,12 +38,3 @@
 void cleanup_procfs(void);
 int setup_procfs(void);
 
-/* While scanning for vis-entries of a particular vis-originator
- * this list collects its interfaces to create a subgraph/cluster
- * out of them later
- */
-struct vis_if_list {
-	uint8_t addr[ETH_ALEN];
-	bool primary;
-	struct vis_if_list *next;
-};
-- 
1.6.5.7

