Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Sep 2015 20:09:56 +0200
Message-Id: <1441217396-18043-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maintv3 3/3] batman-adv: detect local excess
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

If the local representation of the global TT table of one originator has
more VLAN entries than the respective TT update, there is some
inconsistency present. By detecting and reporting this inconsistency,
the global table gets updated and the excess VLAN will get removed in
the process.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
Changes to PATCH:
 * count instead of explicitly comparing VLANs, which makes it much
   simpler (thank Antonio)
---
 net/batman-adv/translation-table.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f629c21..e7f2998 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2391,8 +2391,8 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
+	int i, orig_num_vlan;
 	uint32_t crc;
-	int i;
 
 	/* check if each received CRC matches the locally stored one */
 	for (i = 0; i < num_vlan; i++) {
@@ -2418,6 +2418,18 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 	}
 
+	/* check if any excess VLANs exist locally for the originator
+	 * which are not mentioned in the TVLV from the originator.
+	 */
+	rcu_read_lock();
+	orig_num_vlan = 0;
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list)
+		orig_num_vlan++;
+	rcu_read_unlock();
+
+	if (orig_num_vlan > num_vlan)
+		return false;
+
 	return true;
 }
 
-- 
2.5.0

