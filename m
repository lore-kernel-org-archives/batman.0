Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 Feb 2012 09:58:25 +0100
Message-Id: <1328777905-9503-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1328777831-8788-1-git-send-email-ordex@autistici.org>
References: <1328777831-8788-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: fix DBG_BLA log level value
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

When "batctl ll" is launched with argument "bla", the wrong log_level value (1
<< 4) is written into sysfs instead of the correct (1 << 3)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

Sorry, I made a mistake in the commit subject. Now it is ok.




 sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys.c b/sys.c
index 6cf4714..eeb7005 100644
--- a/sys.c
+++ b/sys.c
@@ -223,7 +223,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 			else if (strcmp(argv[i], "tt") == 0)
 				log_level |= (1 << 2);
 			else if (strcmp(argv[i], "bla") == 0)
-				log_level |= (1 << 4);
+				log_level |= (1 << 3);
 			else {
 				log_level_usage();
 				goto out;
-- 
1.7.3.4

