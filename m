Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 28 Dec 2013 17:05:57 +0100
Message-Id: <1388246760-3335-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1388246760-3335-1-git-send-email-antonio@meshcoding.com>
References: <1388246760-3335-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: fix size of
	batadv_bla_claim_dst
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <sw@simonwunderlich.de>

Since this is a mac address and always 48 bit, and we can assume that
it is always aligned to 2-byte boundaries, add a pack(2) pragma.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/packet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 2a857ed..04cf27c 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -155,6 +155,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_ROAM	= 0x05,
 };
 
+#pragma pack(2)
 /* the destination hardware field in the ARP frame is used to
  * transport the claim type and the group id
  */
@@ -163,6 +164,7 @@ struct batadv_bla_claim_dst {
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
+#pragma pack()
 
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
-- 
1.8.5.2

