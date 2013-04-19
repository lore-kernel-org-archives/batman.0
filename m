Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 21:52:27 +0200
Message-Id: <1366401149-31600-5-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366401149-31600-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1366401149-31600-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/6] batman-adv: remove packed from
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

As we decreased the struct size from 26 to 24 byte, we can remove
__packed as the compile will not add any more padding.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 packet.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index c90856d..88d3aa6 100644
--- a/packet.h
+++ b/packet.h
@@ -178,7 +178,10 @@ struct batadv_ogm_packet {
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
1.7.10.4

