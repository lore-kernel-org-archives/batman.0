Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 13 Apr 2011 17:27:00 +0200
Message-Id: <1302708420-8552-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: avoid error message when command was
	successful
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

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys.c b/sys.c
index 729f898..3511b40 100644
--- a/sys.c
+++ b/sys.c
@@ -420,10 +420,10 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 	case GW_MODE_SERVER:
 		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
 		break;
-	default:
-		goto out;
 	}
 
+	goto out;
+
 opt_err:
 	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
 	printf("The following values are allowed:\n");
-- 
1.7.2.3

