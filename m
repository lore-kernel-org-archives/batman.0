Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  5 Feb 2015 15:47:13 +0100
Message-Id: <1423147633-13147-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Close socket after connect failure
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

The socket is still using one file descriptor of the process when the
connection fails. This fd leak is non-problematic in the current client process
code because the client would be closed in this situation anyway and therefore
the socket would be closed when the process is stopped. But people using this
as example code may not stop the process on this error. The unclosed and unused
sockets would accumulate and the process would hit the limit for open file
descriptors.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 2 ++
 unix_sock.c        | 2 ++
 vis/vis.c          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index d736ad1..4bc18ae 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -40,6 +40,8 @@ static int alfred_open_sock(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
+		close(globals->unix_sock);
+		globals->unix_sock = -1;
 		perror("can't connect to unix socket");
 		return -1;
 	}
diff --git a/unix_sock.c b/unix_sock.c
index 8a99327..693b55d 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -84,6 +84,8 @@ int unix_sock_open_client(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
+		close(globals->unix_sock);
+		globals->unix_sock = -1;
 		perror("can't connect to unix socket");
 		return -1;
 	}
diff --git a/vis/vis.c b/vis/vis.c
index 3dd5c8c..1916ea3 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -173,6 +173,8 @@ static int alfred_open_sock(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
+		close(globals->unix_sock);
+		globals->unix_sock = -1;
 		perror("can't connect to unix socket");
 		return -1;
 	}
-- 
2.1.4

