Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Jul 2014 18:06:22 +0200
Message-Id: <1406649982-3577-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: add more debug output for libc errors
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
Cc: Sven Eckelmann <sven@narfation.org>

perror(..) can automatically decode the errno variable and print more
information for an error.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 2 +-
 main.c             | 2 +-
 send.c             | 2 +-
 vis/vis.c          | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 6e88dc7..d736ad1 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -443,7 +443,7 @@ static struct globals *gpsd_init(int argc, char *argv[])
 		gpsd_source_spec(NULL, &globals->gpsdsource);
 
 	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
-		fprintf(stderr, "could not register SIGPIPE handler\n");
+		perror("could not register SIGPIPE handler");
 	return globals;
 }
 
diff --git a/main.c b/main.c
index 0a79e08..1add44e 100644
--- a/main.c
+++ b/main.c
@@ -150,7 +150,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 	}
 
 	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
-		fprintf(stderr, "could not register SIGPIPE handler\n");
+		perror("could not register SIGPIPE handler");
 	return globals;
 }
 
diff --git a/send.c b/send.c
index dc0e428..32b7cbb 100644
--- a/send.c
+++ b/send.c
@@ -170,7 +170,7 @@ ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 		     (struct sockaddr *)&dest_addr,
 		     sizeof(struct sockaddr_in6));
 	if (ret == -EPERM) {
-		fprintf(stderr, "Error during sent\n");
+		perror("Error during sent");
 		netsock_close(globals->netsock);
 		globals->netsock = -1;
 	}
diff --git a/vis/vis.c b/vis/vis.c
index 6cc4034..00372ab 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -258,7 +258,7 @@ static int register_interfaces(struct globals *globals)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		perror("Error - could not allocate path buffer");
 		goto err;
 	}
 
@@ -880,7 +880,7 @@ static struct globals *vis_init(int argc, char *argv[])
 	}
 
 	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
-		fprintf(stderr, "could not register SIGPIPE handler\n");
+		perror("could not register SIGPIPE handler");
 	return globals;
 }
 
-- 
2.0.1

