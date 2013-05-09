Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 12:56:45 +0200
Message-Id: <1368097007-817-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1368097007-817-1-git-send-email-ordex@autistici.org>
References: <1368097007-817-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: check return value of
	pskb_trim_rcsum()
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/network-coding.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f7c5430..e84629e 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1514,6 +1514,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	struct ethhdr *ethhdr, ethhdr_tmp;
 	uint8_t *orig_dest, ttl, ttvn;
 	unsigned int coding_len;
+	int err;
 
 	/* Save headers temporarily */
 	memcpy(&coded_packet_tmp, skb->data, sizeof(coded_packet_tmp));
@@ -1568,8 +1569,11 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			 coding_len);
 
 	/* Resize decoded skb if decoded with larger packet */
-	if (nc_packet->skb->len > coding_len + h_size)
-		pskb_trim_rcsum(skb, coding_len + h_size);
+	if (nc_packet->skb->len > coding_len + h_size) {
+		err = pskb_trim_rcsum(skb, coding_len + h_size);
+		if (err)
+			return NULL;
+	}
 
 	/* Create decoded unicast packet */
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-- 
1.8.1.5

