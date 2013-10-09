Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  9 Oct 2013 14:40:17 +0200
Message-Id: <1381322418-1349-16-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
References: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: remove packed from
	batadv_ogm_packet
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <lindner_marek@yahoo.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

As we decreased the struct size from 26 to 24 byte, we can remove
__packed as the compiler will not add any more padding.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/packet.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index f02dbb1..4e5fe7d 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -175,7 +175,10 @@ struct batadv_ogm_packet {
 	uint8_t  reserved;
 	uint8_t  tq;
 	__be16   tvlv_len;
-} __packed;
+	/* __packed is not needed as the struct size is divisible by 4,
+	 * and the largest data type in this struct has a size of 4.
+	 */
+};
 
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
-- 
1.8.3.2

