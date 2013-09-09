Return-Path: <nils@nilsschneider.net>
From: Nils Schneider <nils@nilsschneider.net>
Date: Mon,  9 Sep 2013 03:39:02 +0200
Message-Id: <1378690742-19656-1-git-send-email-nils@nilsschneider.net>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: free globals. Fixes memory leak
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

---
 main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 86acfb7..58622f8 100644
--- a/main.c
+++ b/main.c
@@ -142,6 +142,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 int main(int argc, char *argv[])
 {
 	struct globals *globals;
+	int ret;
 
 	globals = alfred_init(argc, argv);
 
@@ -150,15 +151,21 @@ int main(int argc, char *argv[])
 
 	switch (globals->clientmode) {
 	case CLIENT_NONE:
-		return alfred_server(globals);
+		ret = alfred_server(globals);
 		break;
 	case CLIENT_REQUEST_DATA:
-		return alfred_client_request_data(globals);
+		ret = alfred_client_request_data(globals);
 		break;
 	case CLIENT_SET_DATA:
-		return alfred_client_set_data(globals);
+		ret = alfred_client_set_data(globals);
 		break;
+	default:
+		ret = 0;
 	}
 
-	return 0;
+	free(globals->interface);
+	free(globals->mesh_iface);
+	free(globals);
+
+	return ret;
 }
-- 
1.8.4

