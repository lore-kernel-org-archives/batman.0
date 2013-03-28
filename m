Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Mar 2013 08:50:21 +0100
Message-Id: <1364457031-3194-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1364457031-3194-1-git-send-email-ordex@autistici.org>
References: <1364457031-3194-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 01/11] batman-adv: Fix endianness errors for
	network coding
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
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Martin Hundebøll <martin@hundeboll.net>

Add a htonl() in network_coding.c when reading the sequence number
from received ogm_packet, to avoid wrong byte ordering when comparing
with a host value. This bug was introduced in
3ed7ada3f0bbcd058567bc0a8f9729a73eba7db6 ("batman-adv: network coding -
detect coding nodes and remove these after timeout").

Change the type of coded_packet->coded_len from uint16 to __be16 to
avoid wrong assumptions about endianness in later uses. Introduced in
c3289f3650d34b60296000a629c99f2488f7c3dd ("batman-adv: network coding -
code and transmit packets if possible").

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/network-coding.c | 2 +-
 net/batman-adv/packet.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 5728079..086c107 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -654,7 +654,7 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *orig_node,
 				    struct batadv_ogm_packet *ogm_packet)
 {
-	if (orig_node->last_real_seqno != ogm_packet->seqno)
+	if (orig_node->last_real_seqno != ntohl(ogm_packet->seqno))
 		return false;
 	if (orig_node->last_ttl != ogm_packet->header.ttl + 1)
 		return false;
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index a079958..a51ccfc 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -308,7 +308,7 @@ struct batadv_coded_packet {
 	uint8_t  second_source[ETH_ALEN];
 	uint8_t  second_orig_dest[ETH_ALEN];
 	__be32   second_crc;
-	uint16_t coded_len;
+	__be16   coded_len;
 };
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
-- 
1.8.1.5

