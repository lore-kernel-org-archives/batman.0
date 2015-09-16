Return-Path: <uol@pengutronix.de>
From: =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
Date: Wed, 16 Sep 2015 15:01:49 +0200
Message-Id: <1442408509-14706-1-git-send-email-u.oelmann@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Fix typos
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

Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 README       | 2 +-
 main.c       | 4 ++--
 man/alfred.8 | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 938a275..6bbf915 100644
--- a/README
+++ b/README
@@ -74,7 +74,7 @@ list of options, run alfred -h):
                               the system (default: bat0). use 'none' to disable
                               the batman-adv based best server selection
   -m, --master                start up the daemon in master mode, which
-                              accepts data from slaves and synces it with
+                              accepts data from slaves and syncs it with
                               other masters
 
 The -b option is optional, and only needed if you run alfred on a batman-adv
diff --git a/main.c b/main.c
index db1f8b0..452d9ae 100644
--- a/main.c
+++ b/main.c
@@ -50,13 +50,13 @@ static void alfred_usage(void)
 	printf("  -I, --change-interface [interface]  change to the specified interface(s)\n");
 	printf("\n");
 	printf("server mode options:\n");
-	printf("  -i, --interface                     specify the interface (or comma separated list of interfaes) to listen on\n");
+	printf("  -i, --interface                     specify the interface (or comma separated list of interfaces) to listen on\n");
 	printf("  -b                                  specify the batman-adv interface\n");
 	printf("                                      configured on the system (default: bat0)\n");
 	printf("                                      use 'none' to disable the batman-adv\n");
 	printf("                                      based best server selection\n");
 	printf("  -m, --master                        start up the daemon in master mode, which\n");
-	printf("                                      accepts data from slaves and synces it with\n");
+	printf("                                      accepts data from slaves and syncs it with\n");
 	printf("                                      other masters\n");
 	printf("\n");
 	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
diff --git a/man/alfred.8 b/man/alfred.8
index e21bb55..95241a7 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -90,7 +90,7 @@ Change the alfred server to use the new \fBinterface\fP(s)
 .SH SERVER OPTIONS
 .TP
 \fB\-i\fP, \fB\-\-interface\fP \fiface\fP
-Specify the interface (or comma separated list of interfaes) to listen on
+Specify the interface (or comma separated list of interfaces) to listen on
 .TP
 \fB\-b\fP \fIbatmanif\fP
 Specify the batman-adv interface configured on the system (default: bat0).
@@ -102,7 +102,7 @@ batman-adv interface not called bat0, or if you don't use batman-adv at all
 able to find the best next master server based on metrics.
 .TP
 \fB\-m\fP, \fB\-\-master\fP
-Start up the daemon in master mode, which accepts data from slaves and synces
+Start up the daemon in master mode, which accepts data from slaves and syncs
 it with other masters.
 
 alfred servers may either run as master or slave in the network. Masters will
-- 
2.5.0

