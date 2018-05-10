Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 10 May 2018 19:44:28 +0200
Message-Id: <20180510174428.8646-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
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

The previous TT sync fix so far only fixed TT responses issued by the
target node directly. So far, TT responses issued by intermediate nodes
still lead to the wrong flags being added, leading to CRC mismatches.

This behaviour was observed at Freifunk Hannover in a 800 nodes setup
where a considerable amount of nodes were still infected with 'WI'
TT flags even with (most) nodes having the previous TT sync fix applied.

I was able to reproduce the issue with intermediate TT responses in a
four node test setup and this patch fixes this issue by ensuring to
use the per originator instead of the summarized, OR'd ones.

Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
Changes v3:
- renamed batadv_tt_{local,global}_get_flags() back to
  batadv_tt_{global,local}_valid as Antonio and I could not come
  up with a generic naming suiting both purposes
- renamed flags_cb back to valid_cb
- undid the rename from orig_node to orig and just used a newline
- moved the valid_cb not NULL check to the top of
  batadv_tt_tvlv_generate() as it is unclear what to do about the
  flags otherwise (technically this does not change behaviour
  as so far valid_cb is never and has never been NULL)

Changes v2:
- repurpose current valid_cb callback to get the flags
  -> saves us a second, duplicate orig-entry hash table lookup
  -> avoids the "guessing" of TT local vs. TT global / cb_data type
---
 net/batman-adv/translation-table.c | 60 +++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 78993dd7..5176db25 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1538,6 +1538,7 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
  *  handled by a given originator
  * @entry: the TT global entry to check
  * @orig_node: the originator to search in the list
+ * @flags: a pointer to store TT flags for the given @orig_node and @entry to
  *
  * find out if an orig_node is already in the list of a tt_global_entry.
  *
@@ -1545,7 +1546,8 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
  */
 static bool
 batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
-				const struct batadv_orig_node *orig_node)
+				const struct batadv_orig_node *orig_node,
+				u8 *flags)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	bool found = false;
@@ -1553,6 +1555,10 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
+
+		if (flags)
+			*flags = orig_entry->flags;
+
 		batadv_tt_orig_list_entry_put(orig_entry);
 	}
 
@@ -1731,7 +1737,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
 				goto out;
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
-							    orig_node))
+							    orig_node, NULL))
 				goto out_remove;
 			batadv_tt_global_del_orig_list(tt_global_entry);
 			goto add_orig_entry;
@@ -2880,23 +2886,46 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_valid() - verify that given tt entry is a valid one
+ * batadv_tt_local_valid() - verify local tt entry and get flags
  * @entry_ptr: to be checked local tt entry
  * @data_ptr: not used but definition required to satisfy the callback prototype
+ * @flags: a pointer to store TT flags for this client to
+ *
+ * Checks the validity of the given local TT entry. If it is, then the provided
+ * flags pointer is updated.
  *
  * Return: true if the entry is a valid, false otherwise.
  */
-static bool batadv_tt_local_valid(const void *entry_ptr, const void *data_ptr)
+static bool batadv_tt_local_valid(const void *entry_ptr,
+				  const void *data_ptr,
+				  u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
 		return false;
+
+	if (flags)
+		*flags = tt_common_entry->flags;
+
 	return true;
 }
 
+/**
+ * batadv_tt_global_valid() - verify global tt entry and get flags
+ * @entry_ptr: to be checked global tt entry
+ * @data_ptr: an orig_node object (may be NULL)
+ * @flags: a pointer to store TT flags to
+ *
+ * Checks the validity of the given global TT entry. If it is, then the provided
+ * flags pointer is updated either with the common (summed) TT flags if data_ptr
+ * is NULL or the specific, per originator TT flags otherwise.
+ *
+ * Return: true if the entry is a valid, false otherwise.
+ */
 static bool batadv_tt_global_valid(const void *entry_ptr,
-				   const void *data_ptr)
+				   const void *data_ptr,
+				   u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 	const struct batadv_tt_global_entry *tt_global_entry;
@@ -2910,7 +2939,8 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 				       struct batadv_tt_global_entry,
 				       common);
 
-	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node);
+	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node,
+					       flags);
 }
 
 /**
@@ -2920,25 +2950,34 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
  * @hash: hash table containing the tt entries
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
- * @valid_cb: function to filter tt change entries
+ * @valid_cb: function to filter tt change entries and to return TT flags
  * @cb_data: data passed to the filter function as argument
+ *
+ * Fills the tvlv buff with the tt entries from the specified hash. If valid_cb
+ * is not provided then this becomes a no-op.
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				    struct batadv_hashtable *hash,
 				    void *tvlv_buff, u16 tt_len,
 				    bool (*valid_cb)(const void *,
-						     const void *),
+						     const void *,
+						     u8 *flags),
 				    void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
 	u16 tt_tot, tt_num_entries = 0;
+	u8 flags;
+	bool ret;
 	u32 i;
 
 	tt_tot = batadv_tt_entries(tt_len);
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
+	if (!valid_cb)
+		return;
+
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2948,11 +2987,12 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 			if (tt_tot == tt_num_entries)
 				break;
 
-			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
+			ret = valid_cb(tt_common_entry, cb_data, &flags);
+			if (!ret)
 				continue;
 
 			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
-			tt_change->flags = tt_common_entry->flags;
+			tt_change->flags = flags;
 			tt_change->vid = htons(tt_common_entry->vid);
 			memset(tt_change->reserved, 0,
 			       sizeof(tt_change->reserved));
-- 
2.11.0

