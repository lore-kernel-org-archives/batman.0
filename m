Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2011 22:51:40 +0200
Message-Id: <1307998300-5898-1-git-send-email-sven@narfation.org>
In-Reply-To: <1307986680-21113-1-git-send-email-ordex@autistici.org>
References: <1307986680-21113-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: clean up the tt_query flags
	field
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>

The tt_query subtype is represented by the two leading bits (lsb) of
the tt_query->flags field. Therefore it cannot be handled by simple
"flags" but by two bits wide integer. The TT_QUERY_TYPE_MASK is used to
extract the relevant bits that can be compared to the related enum
values (TT_RESPONSE, TT_REQUEST)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 * Just added three missing tabs as mentioned in the last mail.

 packet.h  |   10 ++++++++--
 routing.c |   34 ++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/packet.h b/packet.h
index ef7476f..c5f081d 100644
--- a/packet.h
+++ b/packet.h
@@ -65,10 +65,16 @@ enum unicast_frag_flags {
 	UNI_FRAG_LARGETAIL = 1 << 1
 };
 
+/* TT_QUERY subtypes */
+#define TT_QUERY_TYPE_MASK 0x3
+
+enum tt_query_packettype {
+	TT_REQUEST    = 0,
+	TT_RESPONSE   = 1
+};
+
 /* TT_QUERY flags */
 enum tt_query_flags {
-	TT_RESPONSE   = 1 << 0,
-	TT_REQUEST    = 1 << 1,
 	TT_FULL_TABLE = 1 << 2
 };
 
diff --git a/routing.c b/routing.c
index 7f458e9..3a3cfb8 100644
--- a/routing.c
+++ b/routing.c
@@ -1218,7 +1218,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	tt_query->tt_data = ntohs(tt_query->tt_data);
 
-	if (tt_query->flags & TT_REQUEST) {
+	switch (tt_query->flags & TT_QUERY_TYPE_MASK) {
+	case TT_REQUEST:
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
 		if (!send_tt_response(bat_priv, tt_query)) {
@@ -1229,22 +1230,23 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 			tt_query->tt_data = htons(tt_query->tt_data);
 			return route_unicast_packet(skb, recv_if);
 		}
-		ret = NET_RX_SUCCESS;
-		goto out;
-	}
-	/* packet needs to be linearised to access the TT changes records */
-	if (skb_linearize(skb) < 0)
-		goto out;
+		break;
+	case TT_RESPONSE:
+		/* packet needs to be linearised to access the TT changes records */
+		if (skb_linearize(skb) < 0)
+			goto out;
 
-	if (is_my_mac(tt_query->dst))
-		handle_tt_response(bat_priv, tt_query);
-	else {
-		bat_dbg(DBG_TT, bat_priv,
-			"Routing TT_RESPONSE to %pM [%c]\n",
-			tt_query->dst,
-			(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
-		tt_query->tt_data = htons(tt_query->tt_data);
-		return route_unicast_packet(skb, recv_if);
+		if (is_my_mac(tt_query->dst))
+			handle_tt_response(bat_priv, tt_query);
+		else {
+			bat_dbg(DBG_TT, bat_priv,
+				"Routing TT_RESPONSE to %pM [%c]\n",
+				tt_query->dst,
+				(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
+			tt_query->tt_data = htons(tt_query->tt_data);
+			return route_unicast_packet(skb, recv_if);
+		}
+		break;
 	}
 	ret = NET_RX_SUCCESS;
 
-- 
1.7.5.4

