Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  3 Nov 2012 21:55:10 +0100
Message-Id: <1351976110-3671-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH stable 3.5] batman-adv: Fix broadcast packet
	CRC calculation
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
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

commit 7f112af40fecf5399b61e69ffc6b55a9d82789f7 upstream.

So far the crc16 checksum for a batman-adv broadcast data packet, received
on a batman-adv hard interface, was calculated over zero bytes of its
content leading to many incoming broadcast data packets wrongly being
dropped (60-80% packet loss).

This patch fixes this issue by calculating the crc16 over the actual,
complete broadcast payload.

The issue is a regression introduced by
("batman-adv: add broadcast duplicate check").

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 16 +++++++---------
 net/batman-adv/routing.c               |  8 +++++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c5863f4..740bb6f 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1172,8 +1172,8 @@ int bla_init(struct bat_priv *bat_priv)
 
 /**
  * @bat_priv: the bat priv with all the soft interface information
- * @bcast_packet: originator mac address
- * @hdr_size: maximum length of the frame
+ * @bcast_packet: encapsulated broadcast frame plus batman header
+ * @bcast_packet_len: length of encapsulated broadcast frame plus batman header
  *
  * check if it is on our broadcast list. Another gateway might
  * have sent the same packet because it is connected to the same backbone,
@@ -1183,19 +1183,17 @@ int bla_init(struct bat_priv *bat_priv)
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
- *
- **/
-
-int bla_check_bcast_duplist(struct bat_priv *bat_priv,
-			    struct bcast_packet *bcast_packet,
-			    int hdr_size)
+ */
+int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
+				   struct batadv_bcast_packet *bcast_packet,
+				   int bcast_packet_len)
 {
 	int i, length, curr;
 	uint8_t *content;
 	uint16_t crc;
 	struct bcast_duplist_entry *entry;
 
-	length = hdr_size - sizeof(*bcast_packet);
+	length = bcast_packet_len - sizeof(*bcast_packet);
 	content = (uint8_t *)bcast_packet;
 	content += sizeof(*bcast_packet);
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 015471d..0c2cb6b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1081,8 +1081,14 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
+	/* keep skb linear for crc calculation */
+	if (skb_linearize(skb) < 0)
+		goto out;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	/* check whether this has been sent by another originator before */
-	if (bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_size))
+	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, skb->len))
 		goto out;
 
 	/* rebroadcast packet */
-- 
1.8.0

