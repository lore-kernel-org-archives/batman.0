Return-Path: <dominik@heidler.eu>
From: Dominik Heidler <dominik@heidler.eu>
Date: Wed, 17 Feb 2016 00:51:10 +0100
Message-Id: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Allow setting the source mac via
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

Signed-off-by: Dominik Heidler <dominik@heidler.eu>
---

The alfred client sets the mac to zero by default
so this shouldn't break existing behaviour.


 unix_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unix_sock.c b/unix_sock.c
index 3c7e583..12a10e6 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -119,7 +119,9 @@ static int unix_sock_add_data(struct globals *globals,
 
 	data = push->data;
 	data_len = ntohs(data->header.length);
-	memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
+	static const char zero[ETH_ALEN] = { 0 };
+	if (!memcmp(zero, data->source, sizeof(data->source)))
+		memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
 
 	if ((int)(data_len + sizeof(*data)) > len)
 		goto err;
-- 
2.7.0

