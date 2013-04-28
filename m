Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 28 Apr 2013 10:09:26 +0200
Message-Id: <1367136566-12593-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use the BigEndian notation for
	variables sent over the wire
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
Cc: Antonio Quartulli <ordex@autistici.org>

All the variables sent over the wire must report the
BigEndian (__be*) notation so that sparse can easily spot
any bug due to missing conversions.

This patch changes the type used by the up and download
bandwidth in the new GW TVLV from uint32_t to __be32 and
adds all the related conversions.

Introduced by: 0853ec7fafe0a195754454832993c6b35e22b842
("batman-adv: tvlv - gateway download/upload bandwidth container")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v1 was:
batman-adv: properly handle Network Ordered variables

v2:
change subject and commit message



 gateway_client.c | 24 +++++++++++++-----------
 gateway_common.c |  4 ++--
 packet.h         |  4 ++--
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index f00db73..973f02d 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -344,8 +344,10 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
 		   orig_node->orig,
-		   gateway->bandwidth_down / 10, gateway->bandwidth_down % 10,
-		   gateway->bandwidth_up / 10, gateway->bandwidth_up % 10);
+		   ntohl(gateway->bandwidth_down) / 10,
+		   ntohl(gateway->bandwidth_down) % 10,
+		   ntohl(gateway->bandwidth_up) / 10,
+		   ntohl(gateway->bandwidth_up) % 10);
 }
 
 /**
@@ -399,8 +401,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
-	if ((gw_node->bandwidth_down == gateway->bandwidth_down) &&
-	    (gw_node->bandwidth_up == gateway->bandwidth_up))
+	if ((gw_node->bandwidth_down == ntohl(gateway->bandwidth_down)) &&
+	    (gw_node->bandwidth_up == ntohl(gateway->bandwidth_up)))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -410,16 +412,16 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		   gw_node->bandwidth_down % 10,
 		   gw_node->bandwidth_up / 10,
 		   gw_node->bandwidth_up % 10,
-		   gateway->bandwidth_down / 10,
-		   gateway->bandwidth_down % 10,
-		   gateway->bandwidth_up / 10,
-		   gateway->bandwidth_up % 10);
+		   ntohl(gateway->bandwidth_down) / 10,
+		   ntohl(gateway->bandwidth_down) % 10,
+		   ntohl(gateway->bandwidth_up) / 10,
+		   ntohl(gateway->bandwidth_up) % 10);
 
-	gw_node->bandwidth_down = gateway->bandwidth_down;
-	gw_node->bandwidth_up = gateway->bandwidth_up;
+	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
+	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 
 	gw_node->deleted = 0;
-	if (gateway->bandwidth_down == 0) {
+	if (ntohl(gateway->bandwidth_down) == 0) {
 		gw_node->deleted = jiffies;
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Gateway %pM removed from gateway list\n",
diff --git a/gateway_common.c b/gateway_common.c
index 9904710..07fd877 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -202,8 +202,8 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		gateway.bandwidth_up = 0;
 	} else {
 		gateway_ptr = tvlv_value;
-		gateway.bandwidth_down = ntohl(gateway_ptr->bandwidth_down);
-		gateway.bandwidth_up = ntohl(gateway_ptr->bandwidth_up);
+		gateway.bandwidth_down = gateway_ptr->bandwidth_down;
+		gateway.bandwidth_up = gateway_ptr->bandwidth_up;
 		if ((gateway.bandwidth_down == 0) ||
 		    (gateway.bandwidth_up == 0)) {
 			gateway.bandwidth_down = 0;
diff --git a/packet.h b/packet.h
index 58fe4eb..559c738 100644
--- a/packet.h
+++ b/packet.h
@@ -372,8 +372,8 @@ struct batadv_tvlv_long {
  * @bandwidth_up: advertised uplink upload bandwidth
  */
 struct batadv_tvlv_gateway_data {
-	uint32_t bandwidth_down;
-	uint32_t bandwidth_up;
+	__be32 bandwidth_down;
+	__be32 bandwidth_up;
 };
 
 /**
-- 
1.8.1.5

