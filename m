Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 13 Nov 2013 17:38:04 +0100
Message-Id: <1384360685-366-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 5/6] batman-adv: create helper function to
	get AP isolation status
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The AP isolation status may be evaluated in different spots.
Create an helper function to avoid code duplication.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 main.c              | 26 ++++++++++++++++++++++++++
 main.h              |  1 +
 translation-table.c | 13 +------------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/main.c b/main.c
index d51bc5f..a7da5ea 100644
--- a/main.c
+++ b/main.c
@@ -1168,6 +1168,32 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 	return vid;
 }
 
+/**
+ * batadv_vlan_ap_isola_get - return the AP isolation status for the given vlan
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier for which the AP isolation attributed as to be
+ *  looked up
+ *
+ * Returns true if AP isolation is on for the VLAN idenfied by vid, false
+ * otherwise
+ */
+bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
+{
+	bool ap_isolation_enabled = false;
+	struct batadv_softif_vlan *vlan;
+
+	/* if the AP isolation is requested on a VLAN, then check for its
+	 * setting in the proper VLAN private data structure
+	 */
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (vlan) {
+		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+		batadv_softif_vlan_free_ref(vlan);
+	}
+
+	return ap_isolation_enabled;
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/main.h b/main.h
index 6ee984c..e456762 100644
--- a/main.h
+++ b/main.h
@@ -367,5 +367,6 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 			      uint8_t *dst, uint8_t type, uint8_t version,
 			      void *tvlv_value, uint16_t tvlv_value_len);
 unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len);
+bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/translation-table.c b/translation-table.c
index 0c8b8b9..c3ed3ea 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1894,19 +1894,8 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
-	bool ap_isolation_enabled = false;
-	struct batadv_softif_vlan *vlan;
-
-	/* if the AP isolation is requested on a VLAN, then check for its
-	 * setting in the proper VLAN private data structure
-	 */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (vlan) {
-		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_free_ref(vlan);
-	}
 
-	if (src && ap_isolation_enabled) {
+	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
 		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
-- 
1.8.4.3

