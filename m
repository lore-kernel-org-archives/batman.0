Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Nov 2015 19:57:21 +0100
Message-Id: <1448305042-5806-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: add kerneldoc for
	batadv_iv_ogm_aggr_packet
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 net/batman-adv/bat_iv_ogm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ad678f0..a594496 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -394,7 +394,14 @@ static u8 batadv_hop_penalty(u8 tq, const struct batadv_priv *bat_priv)
 	return new_tq;
 }
 
-/* is there another aggregated packet here? */
+/**
+ * batadv_iv_ogm_aggr_packet - checks if there is another OGM attached
+ * @buff_pos: current position in the skb
+ * @packet_len: total length of the skb
+ * @tvlv_len: tvlv length of the previously considered OGM
+ *
+ * Return: true if there is enough space for another OGM, false otherwise.
+ */
 static bool batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 				      __be16 tvlv_len)
 {
-- 
2.6.2

