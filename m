Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 22 Jan 2012 19:31:03 +0100
Message-Id: <1327257063-13289-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <201201222146.51275.lindner_marek@yahoo.de>
References: <201201222146.51275.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: exit on parse error in batctl ll
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

If the argument could not be understood, we should not try to
apply something, but return from the function.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 sys.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sys.c b/sys.c
index 9cdccba..56f55dd 100644
--- a/sys.c
+++ b/sys.c
@@ -221,8 +221,11 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= (1 << 1);
 			else if (strcmp(argv[i], "tt") == 0)
 				log_level |= (1 << 2);
-			else
+			else {
 				log_level_usage();
+				res = EXIT_FAILURE;
+				goto out;
+			}
 		}
 
 		snprintf(str, sizeof(str), "%i", log_level);
-- 
1.7.8.3

