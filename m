Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Oct 2016 21:01:45 +0200
Message-Id: <20161027190150.7880-13-sw@simonwunderlich.de>
In-Reply-To: <20161027190150.7880-1-sw@simonwunderlich.de>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/17] batman-adv: Less function calls in
	batadv_is_ap_isolated() after error detection
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Markus Elfring <elfring@users.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>

The variables "tt_local_entry" and "tt_global_entry" were eventually
checked again despite of a corresponding null pointer test before.

* Avoid this double check by reordering a function call sequence
  and the better selection of jump targets.

* Omit the initialisation for these variables at the beginning then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7f66309..ad1e3bc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3835,8 +3835,8 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 			   unsigned short vid)
 {
-	struct batadv_tt_local_entry *tt_local_entry = NULL;
-	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_softif_vlan *vlan;
 	bool ret = false;
 
@@ -3845,27 +3845,24 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 		return false;
 
 	if (!atomic_read(&vlan->ap_isolation))
-		goto out;
+		goto vlan_put;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
 	if (!tt_local_entry)
-		goto out;
+		goto vlan_put;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src, vid);
 	if (!tt_global_entry)
-		goto out;
-
-	if (!_batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
-		goto out;
+		goto local_entry_put;
 
-	ret = true;
+	if (_batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
+		ret = true;
 
-out:
+	batadv_tt_global_entry_put(tt_global_entry);
+local_entry_put:
+	batadv_tt_local_entry_put(tt_local_entry);
+vlan_put:
 	batadv_softif_vlan_put(vlan);
-	if (tt_global_entry)
-		batadv_tt_global_entry_put(tt_global_entry);
-	if (tt_local_entry)
-		batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
 
-- 
2.10.1

