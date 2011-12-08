Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  8 Dec 2011 19:33:06 +0800
Message-Id: <1323343986-5724-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix log level 'all'
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys.c b/sys.c
index e510bee..105bb51 100644
--- a/sys.c
+++ b/sys.c
@@ -213,7 +213,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 15;
+				log_level = 7;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= (1 << 0);
-- 
1.7.5.4

