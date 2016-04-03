Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Apr 2016 19:21:47 +0200
Message-Id: <1459704107-11844-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Don't accept user defined dataset
	source address in slave mode
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

The dataset source is used by master servers to identify if it has to be
forwarded to other master servers. The data::source of an incoming UDP
push_data is checked and compared against the address of the node sending
the dataset. If both are same then the dataset is marked as
SOURCE_FIRST_HAND. Otherwise it is already synced dataset (SOURCE_SYNCED).
Only datasets marked as SOURCE_FIRST_HAND or SOURCE_LOCAL will be forwarded
by master servers.

Allowing slave servers to accept push_data packets via unix socket with a
modified data::source would break the synchronization of datasets between
the master servers. The slave server would forward data to the master
server as always but the master would now mark the packet as SOURCE_SYNCED.
The synchronization process would end here. Parts of the alfred servers
would therefore have access to the dataset and some not.

Instead drop the incoming push_data with a set data::source on the slave.
No alfred server will have the dataset and the stable inconsistency is
avoided.

Fixes: 58e109973bbe ("alfred: Allow setting the source mac via unix sock")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Depends on the patch https://patchwork.open-mesh.org/patch/15954/
---
 unix_sock.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index ee6dd8f..150ad32 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -122,10 +122,18 @@ static int unix_sock_add_data(struct globals *globals,
 
 	/* clients should set the source mac to 00:00:00:00:00:00
 	 * to make the server set the source for them
+	 *
+	 * Only alfred in master mode can accept a user defined
+	 * source addresses. Otherwise the data would not be
+	 * synced between master servers.
 	 */
-	if (!is_valid_ether_addr(data->source))
-		memcpy(data->source, &interface->hwaddr,
-		       sizeof(interface->hwaddr));
+	if (is_valid_ether_addr(data->source)) {
+		if (memcmp(data->source, &interface->hwaddr, ETH_ALEN) != 0 &&
+		    globals->opmode != OPMODE_MASTER)
+			goto err;
+	} else {
+		memcpy(data->source, &interface->hwaddr, ETH_ALEN);
+	}
 
 	if ((int)(data_len + sizeof(*data)) > len)
 		goto err;
-- 
2.8.0.rc3

