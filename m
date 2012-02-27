Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Feb 2012 11:43:36 +0100
Message-Id: <1330339416-25833-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix 'all' loglevel
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

After having added the "bla" log level, the numeric value for "all" is now 15,
not 7.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys.c b/sys.c
index 0b7ddf7..0b4cac3 100644
--- a/sys.c
+++ b/sys.c
@@ -214,7 +214,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 7;
+				log_level = 15;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
 				log_level |= (1 << 0);
-- 
1.7.3.4

