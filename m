Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:47 +0100
Message-Id: <1426333379-17777-3-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/14] alfred: checkpatch - else is not
	generally useful after a break or return
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 2a607b9..c289b80 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -269,10 +269,10 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 				} else if (strlen(token) == 1) {
 					pos = orig_tqvalue;
 					break;
-				} else {
-					/* fall through */
-					token++;
 				}
+
+				token++;
+				/* fall through */
 			case orig_tqvalue:
 				if (token[strlen(token) - 1] != ')') {
 					line_invalid = 1;
-- 
2.1.4

