Return-Path: <kuba@kernel.org>
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] batman-adv: prepare for const netdev->dev_addr
Date: Tue, 19 Oct 2021 09:30:07 -0700
Message-Id: <20211019163007.1384352-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, b.a.t.m.a.n@lists.open-mesh.org

netdev->dev_addr will be constant soon, make sure
the qualifier is propagated thru batman-adv.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mareklindner@neomailbox.ch
CC: sw@simonwunderlich.de
CC: a@unstable.cc
CC: sven@narfation.org
CC: b.a.t.m.a.n@lists.open-mesh.org
---
 net/batman-adv/bridge_loop_avoidance.c | 14 +++++++-------
 net/batman-adv/routing.c               |  3 ++-
 net/batman-adv/tp_meter.c              |  2 +-
 net/batman-adv/tvlv.c                  |  4 ++--
 net/batman-adv/tvlv.h                  |  4 ++--
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 1669744304c5..7242b32fff80 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -254,7 +254,7 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
  * Return: backbone gateway if found or NULL otherwise
  */
 static struct batadv_bla_backbone_gw *
-batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
+batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
@@ -336,7 +336,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
  */
-static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
+static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 				  unsigned short vid, int claimtype)
 {
 	struct sk_buff *skb;
@@ -488,7 +488,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
  * Return: the (possibly created) backbone gateway or NULL on error
  */
 static struct batadv_bla_backbone_gw *
-batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
+batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 			   unsigned short vid, bool own_backbone)
 {
 	struct batadv_bla_backbone_gw *entry;
@@ -926,7 +926,7 @@ static bool batadv_handle_request(struct batadv_priv *bat_priv,
  */
 static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 				  struct batadv_hard_iface *primary_if,
-				  u8 *backbone_addr, u8 *claim_addr,
+				  const u8 *backbone_addr, const u8 *claim_addr,
 				  unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
@@ -964,7 +964,7 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
  */
 static bool batadv_handle_claim(struct batadv_priv *bat_priv,
 				struct batadv_hard_iface *primary_if,
-				u8 *backbone_addr, u8 *claim_addr,
+				const u8 *backbone_addr, const u8 *claim_addr,
 				unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
@@ -2126,7 +2126,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_hard_iface *primary_if,
 			    struct batadv_bla_claim *claim)
 {
-	u8 *primary_addr = primary_if->net_dev->dev_addr;
+	const u8 *primary_addr = primary_if->net_dev->dev_addr;
 	u16 backbone_crc;
 	bool is_own;
 	void *hdr;
@@ -2294,7 +2294,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_hard_iface *primary_if,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
-	u8 *primary_addr = primary_if->net_dev->dev_addr;
+	const u8 *primary_addr = primary_if->net_dev->dev_addr;
 	u16 backbone_crc;
 	bool is_own;
 	int msecs;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 970d0d7ccc98..83f31494ea4d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -747,7 +747,8 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	bool ret = false;
-	u8 *orig_addr, orig_ttvn;
+	const u8 *orig_addr;
+	u8 orig_ttvn;
 
 	if (batadv_is_my_client(bat_priv, dst_addr, vid)) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 56b9fe97b3b4..fbcb15c7c29b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -631,9 +631,9 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_vars *tp_vars;
+	const unsigned char *dev_addr;
 	size_t packet_len, mss;
 	u32 rtt, recv_ack, cwnd;
-	unsigned char *dev_addr;
 
 	packet_len = BATADV_TP_PLEN;
 	mss = BATADV_TP_PLEN;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 992773376e51..0cb58eb04093 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -587,8 +587,8 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  */
-void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
-			      u8 *dst, u8 type, u8 version,
+void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
+			      const u8 *dst, u8 type, u8 version,
 			      void *tvlv_value, u16 tvlv_value_len)
 {
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 54f2a35653d0..4cf8af00fc11 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -42,8 +42,8 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node,
 				   u8 *src, u8 *dst,
 				   void *tvlv_buff, u16 tvlv_buff_len);
-void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
-			      u8 *dst, u8 type, u8 version,
+void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
+			      const u8 *dst, u8 type, u8 version,
 			      void *tvlv_value, u16 tvlv_value_len);
 
 #endif /* _NET_BATMAN_ADV_TVLV_H_ */
-- 
2.31.1

