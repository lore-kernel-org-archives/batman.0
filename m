Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 28 Apr 2017 22:26:10 +0200
Message-Id: <20170428202610.27022-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: handle race condition for claims
	also in batadv_bla_rx
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

From: Andreas Pape <apape@phoenixcontact.com>

Like in the case of the patch for batadv_bla_tx to handle a race
condition when claiming a mac address for bla, a similar situation
can occur when claiming is triggered via batadv_bla_rx. This patch
solves this with a similar approach as for batadv_bla_tx.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/bridge_loop_avoidance.c |   31 ++++++++++++++++++++-----------
 net/batman-adv/translation-table.c     |   26 ++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |    3 +++
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d07e89e..cab8980 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1847,19 +1847,28 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	if (!claim) {
 		/* possible optimization: race for a claim */
-		/* No claim exists yet, claim it for us!
+		/* Make sure this packet is not looping back
+		 * from our own backbone.
 		 */
 
-		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_rx(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
-			   ethhdr->h_source,
-			   batadv_is_my_client(bat_priv,
-					       ethhdr->h_source, vid) ?
-			   "yes" : "no");
-		batadv_handle_claim(bat_priv, primary_if,
-				    primary_if->net_dev->dev_addr,
-				    ethhdr->h_source, vid);
-		goto allow;
+		if (batadv_tt_local_has_timed_out(bat_priv, ethhdr->h_source,
+						  vid, 100)) {
+			/* No claim exists yet, claim it for us!
+			 */
+			batadv_dbg(BATADV_DBG_BLA, bat_priv,
+				   "bla_rx(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
+				   ethhdr->h_source,
+				   batadv_is_my_client(bat_priv,
+						       ethhdr->h_source, vid) ?
+				   "yes" : "no");
+
+			batadv_handle_claim(bat_priv, primary_if,
+					    primary_if->net_dev->dev_addr,
+					    ethhdr->h_source, vid);
+			goto allow;
+		} else {
+			goto handled;
+		}
 	}
 
 	/* if it is our own claim ... */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e75b493..b908195 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4380,3 +4380,29 @@ void batadv_tt_cache_destroy(void)
 	kmem_cache_destroy(batadv_tt_req_cache);
 	kmem_cache_destroy(batadv_tt_roam_cache);
 }
+
+bool batadv_tt_local_has_timed_out(struct batadv_priv *bat_priv,
+				   const u8 *addr, unsigned short vid,
+				   unsigned int timeout)
+{
+	struct batadv_tt_local_entry *tt_local_entry;
+	bool ret = true;
+
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
+	if (!tt_local_entry)
+		goto out;
+	/* Check if the client has been logically deleted (but is kept for
+	 * consistency purpose)
+	 */
+	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
+		goto out;
+	/* Check that the tt_local_entry has a certain age */
+	if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
+		ret = false;
+
+out:
+	if (tt_local_entry)
+		batadv_tt_local_entry_put(tt_local_entry);
+	return ret;
+}
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 411d586..b05d0d8 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -65,5 +65,8 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 
 int batadv_tt_cache_init(void);
 void batadv_tt_cache_destroy(void);
+bool batadv_tt_local_has_timed_out(struct batadv_priv *bat_priv,
+				   const u8 *addr, unsigned short vid,
+				   unsigned int timeout);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
-- 
1.7.0.4

