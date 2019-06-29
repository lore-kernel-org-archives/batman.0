Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batctl: tcpdump: Add support for MCASTv2 RTR(4|6) flags
Date: Sat, 29 Jun 2019 10:28:17 +0200
Message-Id: <20190629082818.29466-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The batman-adv commit 0a7733468f95 ("batman-adv: mcast: detect, distribute
and maintain multicast router presence") added support for two new flags
BATADV_MCAST_WANT_NO_RTR4 and BATADV_MCAST_WANT_NO_RTR6. These are
announced in IV_OGM and OGMv2.

batctl's tcpdump requires support for it to make debugging of
router-to-router multicast problems in networks easier.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 158b82e..0e2ae8e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -230,10 +230,12 @@ static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len)
 
 	flags = tvlv->flags;
 
-	printf("\tTVLV MCASTv2: [%c%c%c]\n",
+	printf("\tTVLV MCASTv2: [%c%c%c%s%s]\n",
 	       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
 	       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
-	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.',
+	       !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
+	       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
 }
 
 typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
-- 
2.20.1

