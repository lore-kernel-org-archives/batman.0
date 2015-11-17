Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 17 Nov 2015 16:40:52 +0800
Message-Id: <1447749653-26430-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1447749653-26430-1-git-send-email-antonio@meshcoding.com>
References: <1447749653-26430-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: fix kerneldoc for TT
	functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 92af58b..cd40fbc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -69,9 +69,13 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
- * batadv_compare_tt
+ * batadv_compare_tt - check if two TT entries are the same
+ * @node: the list element pointer of the first TT entry
+ * @data2: pointer to the tt_common_entry of the second TT entry
  *
- * Return: 1 if they are the same mac addr and vid
+ * Compare the MAC address and the VLAN ID of the two TT entries and check if
+ * they are the same TT client.
+ * Return: 1 if the two TT clients are the same, 0 otherwise
  */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
@@ -221,6 +225,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -303,8 +308,9 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_size_mod - change the size by v of the local table
- *  identified by vid
+ * batadv_tt_global_size_mod - change the size by v of the global table
+ *  for orig_node identified by vid
+ * @orig_node: the originator for which the table has to be modified
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -723,7 +729,6 @@ out:
  *  function reserves the amount of space needed to send the entire global TT
  *  table. In case of success the value is updated with the real amount of
  *  reserved bytes
-
  * Allocate the needed amount of memory for the entire TT TVLV and write its
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
@@ -1245,9 +1250,12 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_orig_entry_find
+ * batadv_tt_global_orig_entry_find - find a TT orig_list_entry
+ * @entry: the TT global entry where the orig_list_entry has to be
+ *  extracted from
+ * @orig_node: the originator for which the orig_list_entry has to be found
  *
- * retrieves the orig_tt_list_entry belonging to orig_node from the
+ * retrieve the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
  *
  * Return: it with an increased refcounter, NULL if not found
@@ -1276,7 +1284,10 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 }
 
 /**
- * batadv_tt_global_entry_has_orig
+ * batadv_tt_global_entry_has_orig - check if a TT global entry is also handled
+ *  by a given originator
+ * @entry: the TT global entry to check
+ * @orig_node: the originator to search in the list
  *
  * find out if an orig_node is already in the list of a tt_global_entry.
  *
@@ -2521,6 +2532,8 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
  * @num_vlan: number of tvlv VLAN entries
  * @full_table: ask for the entire translation table if true, while only for the
  *  last TT diff otherwise
+ *
+ * Return: true if the TT Request was sent, false otherwise
  */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
@@ -3064,7 +3077,9 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_check_roam_count
+ * batadv_tt_check_roam_count - check if a client has roamed too frequently
+ * @bat_priv: the bat priv with all the soft interface information
+ * @client: mac address of the roaming client
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
-- 
2.6.3

