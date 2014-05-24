Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:15 +0200
Message-Id: <1400931855-7961-10-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] alfred: Fix length check for push_data
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

The client receives the push_data header and the header of a data_block when
it tries to parse the answer of an request. The remaining buffer size to store
the actual data has to remove these two headers from its available, original
buffer size. The read of the data would otherwise (potentially) overflow
the output buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client.c b/client.c
index 3670f4f..0283f57 100644
--- a/client.c
+++ b/client.c
@@ -38,6 +38,7 @@ int alfred_client_request_data(struct globals *globals)
 	struct alfred_tlv *tlv;
 	struct alfred_data *data;
 	int ret, len, data_len, i;
+	const size_t buf_data_len = sizeof(buf) - sizeof(*push) + sizeof(*data);
 
 	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
 		return -1;
@@ -88,7 +89,7 @@ int alfred_client_request_data(struct globals *globals)
 		data_len = ntohs(data->header.length);
 
 		/* would it fit? it should! */
-		if (data_len > (int)(sizeof(buf) - sizeof(*push)))
+		if (data_len > (int)buf_data_len)
 			break;
 
 		/* read the data */
-- 
2.0.0.rc2

