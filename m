Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:45 +0100
Message-Id: <1417519009-20699-28-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 27/31] batman-adv: main,
	batadv_compare_eth return bool
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Declare the returntype of batadv_compare_eth as bool.
The function called inside this helper function
(ether_addr_equal_unaligned) also uses bool as return value, so there is
no need to return int.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 6cd339090658..2e70d4dc748d 100644
--- a/main.h
+++ b/main.h
@@ -218,7 +218,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
  *
  * note: can't use ether_addr_equal() as it requires aligned memory
  */
-static inline int batadv_compare_eth(const void *data1, const void *data2)
+static inline bool batadv_compare_eth(const void *data1, const void *data2)
 {
 	return ether_addr_equal_unaligned(data1, data2);
 }
-- 
2.1.3

