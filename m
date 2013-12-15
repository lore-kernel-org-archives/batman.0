Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 15 Dec 2013 13:26:55 +0100
Message-Id: <1387110415-1062-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix alignment for
	batadv_tvlv_tt_change
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Make struct batadv_tvlv_tt_change 4 bytes long to avoid
padding on any architecture.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 packet.h            | 4 ++--
 translation-table.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/packet.h b/packet.h
index 04cf27c..2dd8f24 100644
--- a/packet.h
+++ b/packet.h
@@ -484,13 +484,13 @@ struct batadv_tvlv_tt_vlan_data {
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
  *  batadv_tt_client_flags)
- * @reserved: reserved field
+ * @reserved: reserved field - useful for alignment purposes only
  * @addr: mac address of non-mesh client that triggered this tt change
  * @vid: VLAN identifier
  */
 struct batadv_tvlv_tt_change {
 	uint8_t flags;
-	uint8_t reserved;
+	uint8_t reserved[3];
 	uint8_t addr[ETH_ALEN];
 	__be16 vid;
 };
diff --git a/translation-table.c b/translation-table.c
index 4add57d..ff625fe 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -333,7 +333,8 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		return;
 
 	tt_change_node->change.flags = flags;
-	tt_change_node->change.reserved = 0;
+	memset(tt_change_node->change.reserved, 0,
+	       sizeof(tt_change_node->change.reserved));
 	memcpy(tt_change_node->change.addr, common->addr, ETH_ALEN);
 	tt_change_node->change.vid = htons(common->vid);
 
@@ -2221,7 +2222,8 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 			       ETH_ALEN);
 			tt_change->flags = tt_common_entry->flags;
 			tt_change->vid = htons(tt_common_entry->vid);
-			tt_change->reserved = 0;
+			memset(tt_change->reserved, 0,
+			       sizeof(tt_change->reserved));
 
 			tt_num_entries++;
 			tt_change++;
-- 
1.8.5.1

