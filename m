Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 21 Aug 2015 17:15:18 +0200
Message-Id: <1440170118-10876-5-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint 4/4] batman-adv: detect local excess
	vlans in TT request
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
Cc: alessandro@mediaspot.net

If the local representation of the global TT table of one originator has
more VLAN entries than the respective TT update, there is some
inconsistency present. By detecting and reporting this inconsistency,
the global table gets updated and the excess VLAN will get removed in
the process.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index dced2da..1adb72e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2392,6 +2392,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
 	uint32_t crc;
+	bool found;
 	int i;
 
 	/* check if each received CRC matches the locally stored one */
@@ -2418,6 +2419,26 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 	}
 
+	/* check if any excess VLANs exist locally for the originator
+	 * which are not mentioned in the TVLV from the originator.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+		found = false;
+
+		for (i = 0; i < num_vlan; i++) {
+			tt_vlan_tmp = tt_vlan + i;
+			if (ntohs(tt_vlan_tmp->vid) == vlan->vid) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			return false;
+	}
+	rcu_read_unlock();
+
 	return true;
 }
 
-- 
2.5.0

