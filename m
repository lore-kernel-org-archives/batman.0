Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed,  3 Jul 2013 01:56:17 +0200
Message-Id: <1372809377-32042-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: refine API calls for unicast
	transmissions of SKBs
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

With this patch the functions batadv_send_skb_unicast() and
batadv_send_skb_unicast_4addr() are further refined into
batadv_send_skb_via_tt(), batadv_send_skb_via_tt_4addr() and
batadv_send_skb_via_gw(). This way we avoid any "guessing" about where to send
a packet in the unicast forwarding methods and let the callers decide.

This is going to be useful for the upcoming multicast related patches in
particular.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Made changes according to Marek's and Antonio's feedback on irc:
* changed _tt*()/_gw() to _via_tt*()/_via_gw()
* changed comment about return value:
  using defines "NET_RX_SUCCESS"/"NET_RX_DROP"
* changed a "ret = 0" to "ret = NET_RX_SUCCESS"

And added the changes Antonio suggested via eMail.

 distributed-arp-table.c |    8 ++---
 send.c                  |   83 +++++++++++++++++++++++++++++++++++++----------
 send.h                  |   51 +++++++++++++++++------------
 soft-interface.c        |    6 +++-
 4 files changed, 104 insertions(+), 44 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f2543c2..12e84f7 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1026,11 +1026,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	 * that a node not using the 4addr packet format doesn't support it.
 	 */
 	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
-		err = batadv_send_skb_unicast_4addr(bat_priv, skb_new,
-						    BATADV_P_DAT_CACHE_REPLY,
-						    vid);
+		err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
+						   BATADV_P_DAT_CACHE_REPLY,
+						   vid);
 	else
-		err = batadv_send_skb_unicast(bat_priv, skb_new, vid);
+		err = batadv_send_skb_via_tt(bat_priv, skb_new, vid);
 
 	if (!err) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
diff --git a/send.c b/send.c
index b631355..29b42fe 100644
--- a/send.c
+++ b/send.c
@@ -235,36 +235,32 @@ out:
 }
 
 /**
- * batadv_send_generic_unicast_skb - send an skb as unicast
+ * batadv_send_skb_unicast - encapsulate and send an skb via unicast
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
  *  4addr packets)
+ * @orig_node: the originator to send the packet to
  * @vid: the vid to be used to search the translation table
  *
- * Returns 1 in case of error or 0 otherwise.
+ * Wrap the given skb into a batman-adv unicast or unicast-4addr header
+ * depending on whether BATADV_UNICAST or BATADV_UNICAST_4ADDR was supplied
+ * as packet_type. Then send this frame to the given orig_node and release a
+ * reference to this orig_node.
+ *
+ * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.
  */
-int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb, int packet_type,
-				    int packet_subtype,
-				    unsigned short vid)
+static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb, int packet_type,
+				   int packet_subtype,
+				   struct batadv_orig_node *orig_node,
+				   unsigned short vid)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
-	struct batadv_orig_node *orig_node;
 	int ret = NET_RX_DROP;
 
-	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest))
-		orig_node = batadv_gw_get_selected_orig(bat_priv);
-	else
-		/* check for tt host - increases orig_node refcount.
-		 * returns NULL in case of AP isolation
-		 */
-		orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-						     ethhdr->h_dest, vid);
-
 	if (!orig_node)
 		goto out;
 
@@ -294,7 +290,7 @@ int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
-		ret = 0;
+		ret = NET_RX_SUCCESS;
 
 out:
 	if (orig_node)
@@ -304,6 +300,57 @@ out:
 	return ret;
 }
 
+/**
+ * batadv_send_skb_via_tt_generic - send an skb via TT lookup
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: payload to send
+ * @packet_type: the batman unicast packet type to use
+ * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
+ *  4addr packets)
+ * @vid: the vid to be used to search the translation table
+ *
+ * Look up the recipient node for the destination address in the ethernet
+ * header via the translation table. Wrap the given skb into a batman-adv
+ * unicast or unicast-4addr header depending on whether BATADV_UNICAST or
+ * BATADV_UNICAST_4ADDR was supplied as packet_type. Then send this frame
+ * to the according destination node.
+ *
+ * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.
+ */
+int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb, int packet_type,
+				   int packet_subtype, unsigned short vid)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+					     ethhdr->h_dest, vid);
+	return batadv_send_skb_unicast(bat_priv, skb, packet_type,
+				       packet_subtype, orig_node, vid);
+}
+
+/**
+ * batadv_send_skb_via_gw - send an skb via gateway lookup
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: payload to send
+ * @vid: the vid to be used to search the translation table
+ *
+ * Look up the currently selected gateway. Wrap the given skb into a batman-adv
+ * unicast header and send this frame to this gateway node.
+ *
+ * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.
+ */
+int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   unsigned short vid)
+{
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_gw_get_selected_orig(bat_priv);
+	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
+				       orig_node, vid);
+}
+
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
diff --git a/send.h b/send.h
index c030cb7..1bf52ba 100644
--- a/send.h
+++ b/send.h
@@ -38,45 +38,54 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
 					   struct batadv_orig_node *orig_node,
 					   int packet_subtype);
-int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb, int packet_type,
-				    int packet_subtype,
-				    unsigned short vid);
+int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb, int packet_type,
+				   int packet_subtype, unsigned short vid);
+int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   unsigned short vid);
 
 /**
- * batadv_send_unicast_skb - send the skb encapsulated in a unicast packet
+ * batadv_send_skb_via_tt - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @vid: the vid to be used to search the translation table
  *
- * Returns 1 in case of error or 0 otherwise.
+ * Look up the recipient node for the destination address in the ethernet
+ * header via the translation table. Wrap the given skb into a batman-adv
+ * unicast header. Then send this frame to the according destination node.
+ *
+ * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.
  */
-static inline int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
-					  struct sk_buff *skb,
-					  unsigned short vid)
+static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
+					 struct sk_buff *skb,
+					 unsigned short vid)
 {
-	return batadv_send_skb_generic_unicast(bat_priv, skb, BATADV_UNICAST,
-					       0, vid);
+	return batadv_send_skb_via_tt_generic(bat_priv, skb, BATADV_UNICAST, 0,
+					      vid);
 }
 
 /**
- * batadv_send_4addr_unicast_skb - send the skb encapsulated in a unicast 4addr
- *  packet
+ * batadv_send_skb_via_tt_4addr - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
  * @vid: the vid to be used to search the translation table
  *
- * Returns 1 in case of error or 0 otherwise.
+ * Look up the recipient node for the destination address in the ethernet
+ * header via the translation table. Wrap the given skb into a batman-adv
+ * unicast-4addr header. Then send this frame to the according destination
+ * node.
+ *
+ * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.
  */
-static inline int batadv_send_skb_unicast_4addr(struct batadv_priv *bat_priv,
-						struct sk_buff *skb,
-						int packet_subtype,
-						unsigned short vid)
+static inline int batadv_send_skb_via_tt_4addr(struct batadv_priv *bat_priv,
+					       struct sk_buff *skb,
+					       int packet_subtype,
+					       unsigned short vid)
 {
-	return batadv_send_skb_generic_unicast(bat_priv, skb,
-					       BATADV_UNICAST_4ADDR,
-					       packet_subtype, vid);
+	return batadv_send_skb_via_tt_generic(bat_priv, skb,
+					      BATADV_UNICAST_4ADDR,
+					      packet_subtype, vid);
 }
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index d897194..0136e5a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -289,7 +289,11 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
-		ret = batadv_send_skb_unicast(bat_priv, skb, vid);
+		if (is_multicast_ether_addr(ethhdr->h_dest))
+			ret = batadv_send_skb_via_gw(bat_priv, skb, vid);
+		else
+			ret = batadv_send_skb_via_tt(bat_priv, skb, vid);
+
 		if (ret != 0)
 			goto dropped_freed;
 	}
-- 
1.7.10.4

