Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] batctl: mcast_flags: Add support for MCASTv2 RTR(4|6)
 flags
Date: Sat, 29 Jun 2019 10:28:18 +0200
Message-Id: <20190629082818.29466-2-sven@narfation.org>
In-Reply-To: <20190629082818.29466-1-sven@narfation.org>
References: <20190629082818.29466-1-sven@narfation.org>
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

The mcast_flags debug table requires support for it to make debugging of
router-to-router multicast problems in networks easier.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 mcast_flags.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mcast_flags.c b/mcast_flags.c
index a1fdf31..6af544b 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -80,10 +80,12 @@ static int mcast_flags_callback(struct nl_msg *msg, void *arg)
 	if (attrs[BATADV_ATTR_MCAST_FLAGS]) {
 		flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
 
-		printf("[%c%c%c]\n",
+		printf("[%c%c%c%s%s]\n",
 		       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
 		       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
-		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.',
+		       !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
+		       !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
 	} else {
 		printf("-\n");
 	}
@@ -124,7 +126,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
         }
 
 	ret = asprintf(&header,
-		"Multicast flags (own flags: [%c%c%c])\n"
+		"Multicast flags (own flags: [%c%c%c%s%s])\n"
 		 "* Bridged [U]\t\t\t\t%c\n"
 		 "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n"
 		 "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n"
@@ -133,6 +135,8 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 		 (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
 		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
 		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
+	         !(mcast_flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
+	         !(mcast_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
 		 bridged ? 'U' : '.',
 		 querier4, querier6, shadowing4, shadowing6,
 		 "Originator", "Flags");
-- 
2.20.1

