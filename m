Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:12 +0200
Message-Id: <1380628934-22220-5-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] alfred: Handle failed announcement as
	netsock error
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
Cc: Sven Eckelmann <sven@open-mesh.com>

An error detected by select doesn't include a missing/down device or other
things which prevent sending. Detecting these can be done by checking -EPERM of
a send like the announcment.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h |  4 ++--
 send.c   | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/alfred.h b/alfred.h
index e931b1b..0b7a5ab 100644
--- a/alfred.h
+++ b/alfred.h
@@ -137,8 +137,8 @@ int push_data(struct globals *globals, struct in6_addr *destination,
 int announce_master(struct globals *globals);
 int push_local_data(struct globals *globals);
 int sync_data(struct globals *globals);
-int send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
-		       void *buf, int length);
+ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
+			   void *buf, int length);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
 int unix_sock_open_daemon(struct globals *globals, const char *path);
diff --git a/send.c b/send.c
index 603e84a..85d1234 100644
--- a/send.c
+++ b/send.c
@@ -24,20 +24,32 @@
 #include <stdint.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <errno.h>
+#include <stdio.h>
 #include "alfred.h"
 #include "hash.h"
 #include "packet.h"
 
 int announce_master(struct globals *globals)
 {
+	ssize_t ret;
 	struct alfred_announce_master_v0 announcement;
 
+	if (globals->netsock < 0)
+		return -1;
+
 	announcement.header.type = ALFRED_ANNOUNCE_MASTER;
 	announcement.header.version = ALFRED_VERSION;
 	announcement.header.length = htons(0);
 
-	send_alfred_packet(globals, &in6addr_localmcast, &announcement,
-			   sizeof(announcement));
+	ret = send_alfred_packet(globals, &in6addr_localmcast, &announcement,
+				 sizeof(announcement));
+	if (ret == -EPERM) {
+		fprintf(stderr, "Error during announcement\n");
+		netsock_close(globals->netsock);
+		globals->netsock = -1;
+	}
+
 
 	return 0;
 }
@@ -146,10 +158,10 @@ int push_local_data(struct globals *globals)
 	return 0;
 }
 
-int send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
-		       void *buf, int length)
+ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
+			   void *buf, int length)
 {
-	int ret;
+	ssize_t ret;
 	struct sockaddr_in6 dest_addr;
 
 	memset(&dest_addr, 0, sizeof(dest_addr));
@@ -165,5 +177,5 @@ int send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 		     (struct sockaddr *)&dest_addr,
 		     sizeof(struct sockaddr_in6));
 
-	return (ret == length);
+	return ret;
 }
-- 
1.8.4.rc3

