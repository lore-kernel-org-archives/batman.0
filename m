Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri,  9 Aug 2013 17:20:17 +0200
Message-Id: <1376061617-18493-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: handle failing write() in unix
	sockets
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This is not really critical, but some compilers seem to complain about
that.

Reported-by: Braden Aran <bradenaran@gmail.com>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 unix_sock.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index b29f635..c778a61 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -158,7 +158,7 @@ static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 	struct alfred_push_data_v0 *push;
 	struct hash_it_t *hashit = NULL;
 	uint8_t buf[MAX_PAYLOAD];
-	uint16_t seqno = 0;
+	uint16_t seqno = 0, ret = 0;
 
 	/* send some data back through the unix socket */
 
@@ -184,12 +184,15 @@ static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 		push->header.length = htons(len);
 		push->tx.seqno = htons(seqno++);
 
-		write(client_sock, buf, sizeof(push->header) + len);
+		if (write(client_sock, buf, sizeof(push->header) + len) < 0) {
+			ret = -1;
+			break;
+		}
 	}
 
 	close(client_sock);
 
-	return 0;
+	return ret;
 }
 
 static int unix_sock_req_data(struct globals *globals,
@@ -234,7 +237,7 @@ int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head)
 {
 	struct alfred_status_v0 status;
-	int send_data = 1;
+	int ret = 0, send_data = 1;
 	int client_sock;
 	uint16_t id;
 	uint8_t requested_type;
@@ -258,10 +261,11 @@ int unix_sock_req_data_finish(struct globals *globals,
 	status.header.length = htons(sizeof(status) - sizeof(status.header));
 	status.tx.id = htons(id);
 	status.tx.seqno = 1;
-	write(client_sock, &status, sizeof(status));
+	if (write(client_sock, &status, sizeof(status)) < 0)
+		ret = -1;
 
 	close(client_sock);
-	return 0;
+	return ret;
 }
 
 int unix_sock_read(struct globals *globals)
-- 
1.7.10.4

