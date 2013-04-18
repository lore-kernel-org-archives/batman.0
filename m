Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 18 Apr 2013 15:13:01 +0200
Message-Id: <1366290781-15376-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass a 16bit long flag
	argument to tt_global_add()
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
Cc: Antonio Quartulli <ordex@autistici.org>

it may be the case that we want to store some local TT client flags in a global
entry, therefore the tt_global_add needs to get a proper argument for this

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- add tt_global_add() kernel doc

 translation-table.c | 19 +++++++++++++++++--
 translation-table.h |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 52808c4..bbda424 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -798,10 +798,25 @@ out:
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
 }
 
-/* caller must hold orig_node refcount */
+/**
+ * batadv_tt_global_add - add a new TT global entry or update it
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: the originator announcing the client
+ * @tt_addr: the MAC address of the client
+ * @flags: TT flags that have to be set for this client
+ * @ttvn: the first originator's TT version number having this client
+ *
+ * Add a new TT global entry for the given originator. If the entry already
+ * exists add a new reference to the given originator (a global entry can have
+ * references to multiple originators) and adjust the flags attribute to reflect
+ * the function argument.
+ * If a TT local entry exists for this client remove it.
+ *
+ * The caller must hold orig_node refcount.
+ */
 int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
-			 const unsigned char *tt_addr, uint8_t flags,
+			 const unsigned char *tt_addr, uint16_t flags,
 			 uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
diff --git a/translation-table.h b/translation-table.h
index ab8e683..659a3bb 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -33,7 +33,7 @@ void batadv_tt_global_add_orig(struct batadv_priv *bat_priv,
 			       const unsigned char *tt_buff, int tt_buff_len);
 int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
-			 const unsigned char *addr, uint8_t flags,
+			 const unsigned char *addr, uint16_t flags,
 			 uint8_t ttvn);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
-- 
1.8.1.5

