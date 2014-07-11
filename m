Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:34 +0200
Message-Id: <1405081595-23371-12-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/13] batman-adv: kernel fixes for
	translation-table.c
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 translation-table.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 5f59e7f..ffc594e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -195,7 +195,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
- * @hash: hash table containing the tt entries
+ * @bat_priv: batman-adv private data
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -280,7 +280,7 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_size_mod - change the size by v of the local table
  *  identified by vid
- * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig_node to change table on
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -691,7 +691,7 @@ out:
  *  function reserves the amount of space needed to send the entire global TT
  *  table. In case of success the value is updated with the real amount of
  *  reserved bytes
-
+ *
  * Allocate the needed amount of memory for the entire TT TVLV and write its
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
@@ -2339,7 +2339,6 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
  * @orig_node: originator for which the CRCs have to be checked
  * @tt_vlan: pointer to the first tvlv VLAN entry
  * @num_vlan: number of tvlv VLAN entries
- * @create: if true, create VLAN objects if not found
  *
  * Return true if all the received CRCs match the locally stored ones, false
  * otherwise
@@ -3284,13 +3283,12 @@ out:
  * batadv_tt_update_orig - update global translation table with new tt
  *  information received via ogms
  * @bat_priv: the bat priv with all the soft interface information
- * @orig: the orig_node of the ogm
- * @tt_vlan: pointer to the first tvlv VLAN entry
+ * @orig_node: the orig_node of the ogm
+ * @tt_buff: pointer to the first tvlv VLAN entry
  * @tt_num_vlan: number of tvlv VLAN entries
  * @tt_change: pointer to the first entry in the TT buffer
  * @tt_num_changes: number of tt changes inside the tt buffer
  * @ttvn: translation table version number of this changeset
- * @tt_crc: crc32 checksum of orig node's translation table
  */
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
-- 
2.0.1

