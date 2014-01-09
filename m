Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  9 Jan 2014 15:53:01 +0100
Message-Id: <1389279182-3256-13-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
References: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 12/13] batman-adv: create helper function to
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The AP isolation status may be evaluated in different spots.
Create an helper function to avoid code duplication.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/main.c              | 26 ++++++++++++++++++++++++++
 net/batman-adv/main.h              |  1 +
 net/batman-adv/translation-table.c | 13 +------------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8abda42..945e441 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1171,6 +1171,32 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
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
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index fa9edbf..a468760 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -369,5 +369,6 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 			      uint8_t *dst, uint8_t type, uint8_t version,
 			      void *tvlv_value, uint16_t tvlv_value_len);
 unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len);
+bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a874d08..1337b69 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1900,19 +1900,8 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
-	bool ap_isolation_enabled = false;
-	struct batadv_softif_vlan *vlan;
 
-	/* if the AP isolation is requested on a VLAN, then check for its
-	 * setting in the proper VLAN private data structure
-	 */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (vlan) {
-		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_free_ref(vlan);
-	}
-
-	if (src && ap_isolation_enabled) {
+	if (src && batadv_vlan_ap_isola_get(bat_priv, vid)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
 		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
-- 
1.8.5.2

