Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Apr 2016 19:22:36 +0200
Message-Id: <1459531356-8361-2-git-send-email-sven@narfation.org>
In-Reply-To: <1459531356-8361-1-git-send-email-sven@narfation.org>
References: <1459531356-8361-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Only accept valid mac addresses
	via unix socket
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

Not only 00:00:00:00:00:00 but also multicast addresses are invalid as data
source for alfred. These have to be checked too before accepting the mac
address received from the client over the unix socket.

Fixes: 58e109973bbe ("alfred: Allow setting the source mac via unix sock")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index a0ccc13..ee6dd8f 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -97,7 +97,6 @@ static int unix_sock_add_data(struct globals *globals,
 			      struct alfred_push_data_v0 *push,
 			      int client_sock)
 {
-	static const char zero[ETH_ALEN] = { 0 };
 	struct alfred_data *data;
 	struct dataset *dataset;
 	int len, data_len, ret = -1;
@@ -124,7 +123,7 @@ static int unix_sock_add_data(struct globals *globals,
 	/* clients should set the source mac to 00:00:00:00:00:00
 	 * to make the server set the source for them
 	 */
-	if (memcmp(zero, data->source, sizeof(data->source)) == 0)
+	if (!is_valid_ether_addr(data->source))
 		memcpy(data->source, &interface->hwaddr,
 		       sizeof(interface->hwaddr));
 
-- 
2.8.0.rc3

