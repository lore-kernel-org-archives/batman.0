Return-Path: <dominik@heidler.eu>
From: Dominik Heidler <dominik@heidler.eu>
Date: Fri, 11 Mar 2016 18:02:48 +0100
Message-Id: <1457715768-14863-1-git-send-email-dominik@heidler.eu>
Subject: [B.A.T.M.A.N.] [PATCH v2] alfred: Allow setting the source mac via
	unix sock
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

The server will only overwrite the mac if it is zero.
Ths allows acting in place of (non-alfred) legacy clients
by injecting their data with the correct source mac.

Signed-off-by: Dominik Heidler <dominik@heidler.eu>
---
 unix_sock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/unix_sock.c b/unix_sock.c
index 3c7e583..d7578a3 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -119,7 +119,13 @@ static int unix_sock_add_data(struct globals *globals,
 
 	data = push->data;
 	data_len = ntohs(data->header.length);
-	memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
+
+	/* clients should set the source mac to 00:00:00:00:00:00
+	 * to make the server set the source for them
+	 */
+	static const char zero[ETH_ALEN] = { 0 };
+	if (!memcmp(zero, data->source, sizeof(data->source)))
+		memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
 
 	if ((int)(data_len + sizeof(*data)) > len)
 		goto err;
-- 
2.7.2

