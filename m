Return-Path: <xrb@kalrong.net>
Message-ID: <4F79953D.1040803@kalrong.net>
Date: Mon, 02 Apr 2012 14:02:05 +0200
From: Xabier R B <xrb@kalrong.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Changed the wrong option in log
 level that was, showing arp as and option where it should be dat
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Signed-off-by: Xabier Rodriguez <xrb@kalrong.net>
---
 sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys.c b/sys.c
index e0dcb07..d3bf7fa 100644
--- a/sys.c
+++ b/sys.c
@@ -257,7 +257,7 @@ int handle_loglevel(char *mesh_iface, int argc,
char **argv)
 	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
 	printf("[%c] %s (%s)\n", (log_level & 16) ? 'x' : ' ',
-	       "messages related to the distributed arp table", "arp");
+	       "messages related to the distributed arp table", "dat");

 out:
 	free(path_buff);
-- 1.7.9.1
