Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat,  5 May 2018 17:30:20 +0200
Message-Id: <20180505153020.29636-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
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
 net/batman-adv/translation-table.c | 42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0225616d..a95724ea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2914,6 +2914,41 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 }
 
 /**
+ * batadv_tt_get_flags() - get TT flags for a given entry
+ * @tt_common_entry: the TT entry to get the flags for
+ * @orig: for a TT global entry the specific node to get the flags for
+ *
+ * Return: -ENOENT on error or the TT flags otherwise.
+ */
+static int
+batadv_tt_get_flags(struct batadv_tt_common_entry *tt_common_entry,
+		    struct batadv_orig_node *orig)
+{
+	const struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	int flags;
+
+	/* a tt-local entry has no 'per orig' entries */
+	if (!orig)
+		return tt_common_entry->flags;
+
+	/* else this is a tt-global entry, get flags for node */
+	tt_global_entry = container_of(tt_common_entry,
+				       struct batadv_tt_global_entry,
+				       common);
+
+	orig_entry = batadv_tt_global_orig_entry_find(tt_global_entry, orig);
+	if (!orig_entry)
+		return -ENOENT;
+
+	flags = orig_entry->flags;
+
+	batadv_tt_orig_list_entry_put(orig_entry);
+
+	return flags;
+}
+
+/**
  * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries from the
  *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
@@ -2934,6 +2969,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
 	u16 tt_tot, tt_num_entries = 0;
+	int flags;
 	u32 i;
 
 	tt_tot = batadv_tt_entries(tt_len);
@@ -2951,8 +2987,12 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
 				continue;
 
+			flags = batadv_tt_get_flags(tt_common_entry, cb_data);
+			if (flags < 0)
+				continue;
+
 			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
-			tt_change->flags = tt_common_entry->flags;
+			tt_change->flags = flags;
 			tt_change->vid = htons(tt_common_entry->vid);
 			memset(tt_change->reserved, 0,
 			       sizeof(tt_change->reserved));
-- 
2.11.0

