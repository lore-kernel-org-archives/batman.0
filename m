Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:35:58 +0200
Message-Id: <1433072160-3260-4-git-send-email-sven@narfation.org>
In-Reply-To: <1433072160-3260-1-git-send-email-sven@narfation.org>
References: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] alfred: Check buffer size before pushing
	data over unix socket
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

Check if the data and its headers would fit in outgoing buffer before
copying the data to the output buffer. This is not a problem by itself
because the data + header in the dataset cannot be larger than
(MAX_PAYLOAD - sizeof(struct alfred_push_data_v0)).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unix_sock.c b/unix_sock.c
index 2c862d5..29c934e 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -183,4 +183,9 @@ static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 			continue;
 
+		/* too large? - should never happen */
+		if (dataset->data.header.length + sizeof(*data) >
+		    MAX_PAYLOAD - sizeof(*push))
+			continue;
+
 		data = push->data;
 		memcpy(data, &dataset->data, sizeof(*data));
-- 
2.1.4

