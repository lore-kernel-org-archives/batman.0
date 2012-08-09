Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 Aug 2012 02:35:43 +0200
Message-Id: <1344472543-11913-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: use the BIT macro instead of
	constant values
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 sys.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys.c b/sys.c
index e40ddcd..6f94483 100644
--- a/sys.c
+++ b/sys.c
@@ -318,14 +318,14 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 
 	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
 	       "all debug output disabled", "none");
-	printf("[%c] %s (%s)\n", (log_level & 1) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level & BIT(0)) ? 'x' : ' ',
 	       "messages related to routing / flooding / broadcasting",
 	       "batman");
-	printf("[%c] %s (%s)\n", (log_level & 2) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level & BIT(1)) ? 'x' : ' ',
 	       "messages related to route added / changed / deleted", "routes");
-	printf("[%c] %s (%s)\n", (log_level & 4) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level & BIT(2)) ? 'x' : ' ',
 	       "messages related to translation table operations", "tt");
-	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
 
 out:
-- 
1.7.9.4

