Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 12 May 2018 00:23:07 +0800
Message-Id: <20180511162307.12255-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [maint v3] batman-adv: prevent TT request storms by
 not sending inconsistent TT TLVLs
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

A translation table TVLV changset sent with an OGM consists
of a number of headers (one per VLAN) plus the changeset
itself (addition and/or deletion of entries).

The per-VLAN headers are used by OGM recipients for consistency
checks. Said consistency check might determine that a full
translation table request is needed to restore consistency. If
the TT sender adds per-VLAN headers of empty VLANs into the OGM,
recipients are led to believe to have reached an inconsistent
state and thus request a full table update. The full table does
not contain empty VLANs (due to missing entries) the cycle
restarts when the next OGM is issued.

Consequently, when the translation table TVLV headers are
composed, empty VLANs are to be excluded.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---

v3:
 * rebased on top of maint

v2:
 * moved changes into batadv_tt_prepare_tvlv_local_data()
 * updated 'fixes' commit id

 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 23f9c212..39865513 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -931,15 +931,20 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_softif_vlan *vlan;
 	u16 num_vlan = 0;
-	u16 num_entries = 0;
+	u16 vlan_entries = 0;
+	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
 	int change_offset;
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 	}
 
 	change_offset = sizeof(**tt_data);
@@ -947,7 +952,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	tvlv_len = *tt_len;
 	tvlv_len += change_offset;
@@ -964,6 +969,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 
-- 
2.17.0

