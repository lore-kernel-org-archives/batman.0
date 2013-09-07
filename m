Return-Path: <nils@nilsschneider.net>
From: Nils Schneider <nils@nilsschneider.net>
Date: Sat,  7 Sep 2013 22:19:46 +0200
Message-Id: <1378585186-7970-1-git-send-email-nils@nilsschneider.net>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: output valid JSON
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

With this patch alfred -r will output JSON like this:

{
  "00:11:22:33:44:55" : "...",
  "22:33:44:55:66:FF" : "..."
}
---
 client.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/client.c b/client.c
index a535f5a..ec882d9 100644
--- a/client.c
+++ b/client.c
@@ -39,7 +39,7 @@ int alfred_client_request_data(struct globals *globals)
 	struct alfred_status_v0 *status;
 	struct alfred_tlv *tlv;
 	struct alfred_data *data;
-	int ret, len, data_len, i;
+	int ret, len, data_len, i, count;
 
 	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
 		return -1;
@@ -59,6 +59,9 @@ int alfred_client_request_data(struct globals *globals)
 		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
 			__func__, ret, len, strerror(errno));
 
+	printf("{");
+
+	count = 0;
 	push = (struct alfred_push_data_v0 *)buf;
 	tlv = (struct alfred_tlv *)buf;
 	while ((ret = read(globals->unix_sock, buf, sizeof(*tlv))) > 0) {
@@ -98,9 +101,12 @@ int alfred_client_request_data(struct globals *globals)
 		if (ret < data_len)
 			break;
 
+		if (count > 0)
+			printf(",\n");
+
 		pos = data->data;
 
-		printf("{ \"%02x:%02x:%02x:%02x:%02x:%02x\", \"",
+		printf("\n  \"%02x:%02x:%02x:%02x:%02x:%02x\": \"",
 		       data->source[0], data->source[1],
 		       data->source[2], data->source[3],
 		       data->source[4], data->source[5]);
@@ -110,14 +116,18 @@ int alfred_client_request_data(struct globals *globals)
 			else if (pos[i] == '\\')
 				printf("\\\\");
 			else if (!isprint(pos[i]))
-				printf("\\x%02x", pos[i]);
+				printf("\\u00%02x", pos[i]);
 			else
 				printf("%c", pos[i]);
 		}
 
-		printf("\" },\n");
+		printf("\"");
+
+		count++;
 	}
 
+	printf("\n}\n");
+
 	unix_sock_close(globals);
 
 	return 0;
-- 
1.8.4

