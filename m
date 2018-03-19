Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Mar 2018 18:40:16 +0100
Message-Id: <20180319174016.23779-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batctl: Enable mcast log level with
 "all"
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

The BIT(6) has to be set when the "all" loglevel is used to really get all
the log output which is known to batctl.

Fixes: 55042b3a3bbf ("batctl: adding multicast debug level")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys.c b/sys.c
index bf77b7d..068aa31 100644
--- a/sys.c
+++ b/sys.c
@@ -169,7 +169,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 63;
+				log_level = 127;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= BIT(0);
-- 
2.16.2

