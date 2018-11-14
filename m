Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 14:46:17 +0100
Message-Id: <20181114134618.17557-2-sw@simonwunderlich.de>
In-Reply-To: <20181114134618.17557-1-sw@simonwunderlich.de>
References: <20181114134618.17557-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Use explicit tvlv padding
 for ELP packets
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The announcement messages of batman-adv COMPAT_VERSION 15 have the
possibility to announce additional information via a dynamic TVLV part.
This part is optional for the ELP packets and currently not parsed by the
Linux implementation. Still out-of-tree versions are using it to transport
things like neighbor hashes to optimize the rebroadcast behavior.

Since the ELP broadcast packets are smaller than the minimal ethernet
packet, it often has to be padded. This is often done (as specified in
RFC894) with octets of zero and thus work perfectly fine with the TVLV
part (making it a zero length and thus empty). But not all ethernet
compatible hardware seems to follow this advice. To avoid ambiguous
situations when parsing the TVLV header, just force the 4 bytes (TVLV
length + padding) after the required ELP header to zero.

Fixes: d6f94d91f766 ("batman-adv: ELP - adding basic infrastructure")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 9f481cfdf77d..e8090f099eb8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -352,19 +352,21 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
  */
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
+	static const size_t tvlv_padding = sizeof(__be32);
 	struct batadv_elp_packet *elp_packet;
 	unsigned char *elp_buff;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
 
-	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
+	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN + tvlv_padding;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
 	if (!hard_iface->bat_v.elp_skb)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb,
+				BATADV_ELP_HLEN + tvlv_padding);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
 
 	elp_packet->packet_type = BATADV_ELP;
-- 
2.11.0

