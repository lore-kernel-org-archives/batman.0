Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 17 Oct 2012 14:53:04 +0200
Message-Id: <1350478385-676-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix broadcast packet CRC
	calculation
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

So far the crc16 checksum for a batman-adv broadcast data packet, received
on a batman-adv hard interface, was calculated over zero bytes of its
content leading to many incoming broadcast data packets wrongly being
dropped.

This patch fixes this issue by calculating the crc16 over the actual,
complete broadcast payload.

The issue is a regression introduced by
"batman-adv: add broadcast duplicate check".

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
It led to about 60-80% broadcast packet loss to a direct neighbor
with a ping6 with a 1s interval in our scenario, but about no
packet loss with an interval smaller than 0.2s.

Also see: https://projects.universe-factory.net/issues/65 (German)

v2:
~ fixed typo (regrission vs. regression)
~ commit name instead of commit hash in the commit message

 bridge_loop_avoidance.c |    8 ++++----
 routing.c               |    8 +++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index a617f2c..b828875 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1247,8 +1247,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 /**
  * batadv_bla_check_bcast_duplist
  * @bat_priv: the bat priv with all the soft interface information
- * @bcast_packet: originator mac address
- * @hdr_size: maximum length of the frame
+ * @bcast_packet: encapsulated broadcast frame plus batman header
+ * @bcast_packet_len: length of encapsulated broadcast frame plus batman header
  *
  * check if it is on our broadcast list. Another gateway might
  * have sent the same packet because it is connected to the same backbone,
@@ -1261,14 +1261,14 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  */
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
-				   int hdr_size)
+				   int bcast_packet_len)
 {
 	int i, length, curr;
 	uint8_t *content;
 	uint16_t crc;
 	struct batadv_bcast_duplist_entry *entry;
 
-	length = hdr_size - sizeof(*bcast_packet);
+	length = bcast_packet_len - sizeof(*bcast_packet);
 	content = (uint8_t *)bcast_packet;
 	content += sizeof(*bcast_packet);
 
diff --git a/routing.c b/routing.c
index 6b2104d..5da62df 100644
--- a/routing.c
+++ b/routing.c
@@ -1181,8 +1181,14 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
+	/* keep skb linear for crc calculation */
+	if (skb_linearize(skb) < 0)
+		goto out;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	/* check whether this has been sent by another originator before */
-	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_size))
+	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, skb->len))
 		goto out;
 
 	/* rebroadcast packet */
-- 
1.7.10.4

