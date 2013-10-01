Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:10 +0200
Message-Id: <1380628934-22220-3-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] alfred: Don't access netsock when it is
	invalid
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

Alfred currently doesn't invalidate the netsock but it could happen in future
changes. Accessing it in an invalid state would otherwise cause the program to
crash or behave unexpected.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 recv.c   |  3 +++
 send.c   |  3 +++
 server.c | 19 ++++++++++++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/recv.c b/recv.c
index 5ed4a62..b755681 100644
--- a/recv.c
+++ b/recv.c
@@ -378,6 +378,9 @@ int recv_alfred_packet(struct globals *globals)
 	struct sockaddr_in6 source;
 	socklen_t sourcelen;
 
+	if (globals->netsock < 0)
+		return -1;
+
 	sourcelen = sizeof(source);
 	length = recvfrom(globals->netsock, buf, sizeof(buf), 0,
 			  (struct sockaddr *)&source, &sourcelen);
diff --git a/send.c b/send.c
index 607afa1..603e84a 100644
--- a/send.c
+++ b/send.c
@@ -158,6 +158,9 @@ int send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 	dest_addr.sin6_scope_id = globals->scope_id;
 	memcpy(&dest_addr.sin6_addr, dest, sizeof(*dest));
 
+	if (globals->netsock < 0)
+		return 0;
+
 	ret = sendto(globals->netsock, buf, length, 0,
 		     (struct sockaddr *)&dest_addr,
 		     sizeof(struct sockaddr_in6));
diff --git a/server.c b/server.c
index 0d8e6c8..6864c1d 100644
--- a/server.c
+++ b/server.c
@@ -236,10 +236,6 @@ int alfred_server(struct globals *globals)
 	if (netsock_open(globals))
 		return -1;
 
-	maxsock = globals->netsock;
-	if (globals->unix_sock > maxsock)
-		maxsock = globals->unix_sock;
-
 	clock_gettime(CLOCK_MONOTONIC, &last_check);
 
 	while (1) {
@@ -250,9 +246,16 @@ int alfred_server(struct globals *globals)
 			tv.tv_nsec = 0;
 		}
 
+		maxsock = -1;
+		if (globals->netsock > maxsock)
+			maxsock = globals->netsock;
+		if (globals->unix_sock > maxsock)
+			maxsock = globals->unix_sock;
+
 		FD_ZERO(&fds);
 		FD_SET(globals->unix_sock, &fds);
-		FD_SET(globals->netsock, &fds);
+		if (globals->netsock >= 0)
+			FD_SET(globals->netsock, &fds);
 		ret = pselect(maxsock + 1, &fds, NULL, NULL, &tv, NULL);
 
 		if (ret == -1) {
@@ -263,7 +266,8 @@ int alfred_server(struct globals *globals)
 				printf("read unix socket\n");
 				unix_sock_read(globals);
 				continue;
-			} else if (FD_ISSET(globals->netsock, &fds)) {
+			} else if (globals->netsock >= 0 &&
+				   FD_ISSET(globals->netsock, &fds)) {
 				recv_alfred_packet(globals);
 				continue;
 			}
@@ -282,7 +286,8 @@ int alfred_server(struct globals *globals)
 		purge_data(globals);
 	}
 
-	netsock_close(globals->netsock);
+	if (globals->netsock >= 0)
+		netsock_close(globals->netsock);
 	unix_sock_close(globals);
 	return 0;
 }
-- 
1.8.4.rc3

