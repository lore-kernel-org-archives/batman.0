Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 16 Mar 2017 14:34:28 +0100
Message-Id: <20170316133429.3923-5-sw@simonwunderlich.de>
In-Reply-To: <20170316133429.3923-1-sw@simonwunderlich.de>
References: <20170316133429.3923-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv8 4/5] batman-adv: changed debug messages for
	easier bla debugging
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
Cc: a@unstable.cc

From: Andreas Pape <APape@phoenixcontact.com>

Some of the bla debug messages are extended and additional messages are
added for easier bla debugging. Some debug messages introduced with the
dat changes in prior patches of this patch series have been changed to
be more compliant to other existing debug messages.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 18 ++++++++++++++----
 net/batman-adv/routing.c               |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 546e66ec..852a2be1 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -739,8 +739,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			goto claim_free_ref;
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
-			   mac, batadv_print_vid(vid));
+			   "bla_add_claim(): changing ownership for %pM, vid %d to gw %pM\n",
+			   mac, batadv_print_vid(vid), backbone_gw->orig);
 
 		remove_crc = true;
 	}
@@ -1295,10 +1295,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				goto skip;
 
 			batadv_dbg(BATADV_DBG_BLA, bat_priv,
-				   "bla_purge_claims(): %pM, vid %d, time out\n",
+				   "bla_purge_claims(): timed out.\n");
+
+purge_now:
+			batadv_dbg(BATADV_DBG_BLA, bat_priv,
+				   "bla_purge_claims(): %pM, vid %d\n",
 				   claim->addr, claim->vid);
 
-purge_now:
 			batadv_handle_unclaim(bat_priv, primary_if,
 					      backbone_gw->orig,
 					      claim->addr, claim->vid);
@@ -1846,6 +1849,13 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		/* possible optimization: race for a claim */
 		/* No claim exists yet, claim it for us!
 		 */
+
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
+			   "bla_rx(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
+			   ethhdr->h_source,
+			   batadv_is_my_client(bat_priv,
+					       ethhdr->h_source, vid) ?
+			   "yes" : "no");
 		batadv_handle_claim(bat_priv, primary_if,
 				    primary_if->net_dev->dev_addr,
 				    ethhdr->h_source, vid);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c85dc310..e1ebe14e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -985,7 +985,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
-					   "Dropped unicast pkt received from another backbone gw %pM.\n",
+					   "recv_unicast_packet(): Dropped unicast pkt received from another backbone gw %pM.\n",
 					   orig_addr_gw);
 				return NET_RX_DROP;
 			}
-- 
2.11.0

