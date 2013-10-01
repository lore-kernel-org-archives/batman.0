Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:11 +0200
Message-Id: <1380628934-22220-4-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] alfred: Try to detect error on socket
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

The netdev socket can have an error which needs a reinitialization. Alfred
should mark the socket as invalid instead of trying to send over the broken
socket.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 server.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/server.c b/server.c
index 6864c1d..bc3b551 100644
--- a/server.c
+++ b/server.c
@@ -216,7 +216,7 @@ int alfred_server(struct globals *globals)
 {
 	int maxsock, ret;
 	struct timespec last_check, now, tv;
-	fd_set fds;
+	fd_set fds, errfds;
 
 	if (create_hashes(globals))
 		return -1;
@@ -253,15 +253,25 @@ int alfred_server(struct globals *globals)
 			maxsock = globals->unix_sock;
 
 		FD_ZERO(&fds);
+		FD_ZERO(&errfds);
 		FD_SET(globals->unix_sock, &fds);
-		if (globals->netsock >= 0)
+		if (globals->netsock >= 0) {
 			FD_SET(globals->netsock, &fds);
-		ret = pselect(maxsock + 1, &fds, NULL, NULL, &tv, NULL);
+			FD_SET(globals->netsock, &errfds);
+		}
+		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
 
 		if (ret == -1) {
 			fprintf(stderr, "main loop select failed ...: %s\n",
 				strerror(errno));
 		} else if (ret) {
+			if (globals->netsock >= 0 &&
+			    FD_ISSET(globals->netsock, &errfds)) {
+				fprintf(stderr, "Error on netsock detected\n");
+				netsock_close(globals->netsock);
+				globals->netsock = -1;
+			}
+
 			if (FD_ISSET(globals->unix_sock, &fds)) {
 				printf("read unix socket\n");
 				unix_sock_read(globals);
-- 
1.8.4.rc3

