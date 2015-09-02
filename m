Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Sep 2015 20:09:54 +0200
Message-Id: <1441217396-18043-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maintv3 1/3] batman-adv: fix speedy join for
	DAT cache replies
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

DAT Cache replies are answered on behalf of other clients which are not
connected to the answering originator. Therefore, we shouldn't add these
clients to the answering originators TT table through speed join to
avoid bogus entries.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>

---
Changes to PATCH:
 * only allow speedy join for BATADV_P_DATA to avoid adding more
   corner cases in the future
---
 net/batman-adv/routing.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c360c0c..96b5daa 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -836,6 +836,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	uint8_t *orig_addr;
 	struct batadv_orig_node *orig_node = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
+	enum batadv_subtype subtype;
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -863,10 +864,20 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
-			batadv_dat_inc_counter(bat_priv,
-					       unicast_4addr_packet->subtype);
-			orig_addr = unicast_4addr_packet->src;
-			orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+			subtype = unicast_4addr_packet->subtype;
+			batadv_dat_inc_counter(bat_priv, subtype);
+
+			/* Only payload data should be considered for speedy
+			 * join. For example, DAT also uses unicast 4addr
+			 * types, but those packets should not be considered
+			 * for speedy join, since the clients do not actually
+			 * reside at the sending originator.
+			 */
+			if (subtype == BATADV_P_DATA) {
+				orig_addr = unicast_4addr_packet->src;
+				orig_node = batadv_orig_hash_find(bat_priv,
+								  orig_addr);
+			}
 		}
 
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
-- 
2.5.0

