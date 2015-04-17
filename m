Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:34:17 +0200
Message-Id: <1429288461-26260-2-git-send-email-sven@narfation.org>
In-Reply-To: <1429288461-26260-1-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 2/6] batman-adv: replace strnicmp with
	strncasecmp
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

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics and
a slightly buggy strncasecmp.  The latter is the POSIX name, so strnicmp
was renamed to strncasecmp, and strnicmp made into a wrapper for the new
strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in the
future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gateway_common.c b/gateway_common.c
index 6f5e621..88a1bc3 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -44,10 +44,10 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 	if (strlen(buff) > 4) {
 		tmp_ptr = buff + strlen(buff) - 4;
 
-		if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+		if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
 			bw_unit_type = BATADV_BW_UNIT_MBIT;
 
-		if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+		if ((strncasecmp(tmp_ptr, "kbit", 4) == 0) ||
 		    (bw_unit_type == BATADV_BW_UNIT_MBIT))
 			*tmp_ptr = '\0';
 	}
@@ -77,10 +77,10 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 		if (strlen(slash_ptr + 1) > 4) {
 			tmp_ptr = slash_ptr + 1 - 4 + strlen(slash_ptr + 1);
 
-			if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+			if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
 				bw_unit_type = BATADV_BW_UNIT_MBIT;
 
-			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+			if ((strncasecmp(tmp_ptr, "kbit", 4) == 0) ||
 			    (bw_unit_type == BATADV_BW_UNIT_MBIT))
 				*tmp_ptr = '\0';
 		}
-- 
2.1.4

