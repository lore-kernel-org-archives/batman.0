Date: Thu, 25 Sep 2008 21:15:59 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080925191559.GA8866@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Don't use iterator of wip_hash to delete
	bucket in vip_hash
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The hash iterator of a hash has different pointers inside of it. When somebody
tries to delete a bucket in another hash with hash_remove_bucket most data will
be changed in the hash the iterator belongs and not the target hash.
---
 batman/linux/modules/gateway.c   |    2 +-
 batman/linux/modules/gateway24.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 1f2dc24..fcf4dd2 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -383,7 +383,7 @@ static int packet_recv_thread(void *data)
 					if( ( jiffies - client_data->last_keep_alive ) / HZ > LEASE_TIME ) {
 
 						hash_remove_bucket(wip_hash, hashit);
-						hash_remove_bucket(vip_hash, hashit);
+						hash_remove(vip_hash, client_data);
 
 						tmp_entry = kmalloc(sizeof(struct free_client_data), GFP_KERNEL);
 						if(tmp_entry != NULL) {
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index a8d58e6..e26154b 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -364,7 +364,7 @@ static int packet_recv_thread(void *data)
 					if( ( jiffies - client_data->last_keep_alive ) / HZ > LEASE_TIME ) {
 
 						hash_remove_bucket(wip_hash, hashit);
-						hash_remove_bucket(vip_hash, hashit);
+						hash_remove(vip_hash, client_data);
 
 						tmp_entry = kmalloc(sizeof(struct free_client_data), GFP_KERNEL);
 						if(tmp_entry != NULL) {
-- 
1.6.0.1


