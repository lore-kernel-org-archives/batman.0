Date: Thu, 11 Sep 2008 15:52:05 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080911135205.GA21654@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] kfree list nodes after deleting them from
	free_client_list in batgat
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

list_del will only move the next pointer of the previous entry to the next entry
and the do the same with the previous pointer of the next entry. The entry
itself will not be touched.
We allocated new memory for the list entry so we must free them or otherwise we
would only leak memory and run out of it after enough connecting and leaving
clients.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/modules/gateway.c   |    3 +++
 batman/linux/modules/gateway24.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 5786be8..e90be0b 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -148,6 +148,7 @@ void cleanup_module()
 		if(entry->gw_client != NULL) {
 			gw_client = entry->gw_client;
 			list_del(&entry->list);
+			kfree(entry);
 			kfree(gw_client);
 		}
 
@@ -267,6 +268,7 @@ static int batgat_ioctl( struct inode *inode, struct file *file, unsigned int cm
 				if(entry->gw_client) {
 					gw_client = entry->gw_client;
 					list_del(&entry->list);
+					kfree(entry);
 					kfree(gw_client);
 				}
 
@@ -653,6 +655,7 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
 		DBG("use free client from list");
 		gw_client = entry->gw_client;
 		list_del(&entry->list);
+		kfree(entry);
 		break;
 	}
 
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index 44dfc0e..585fe85 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -129,6 +129,7 @@ void cleanup_module()
 		if(entry->gw_client != NULL) {
 			gw_client = entry->gw_client;
 			list_del(&entry->list);
+			kfree(entry);
 			kfree(gw_client);
 		}
 
@@ -251,6 +252,7 @@ static int batgat_ioctl( struct inode *inode, struct file *file, unsigned int cm
 
 				gw_client = entry->gw_client;
 				list_del(&entry->list);
+				kfree(entry);
 				kfree(gw_client);
 
 			}
@@ -595,6 +597,7 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
 		printk(KERN_DEBUG "use free client from list");
 		gw_client = entry->gw_client;
 		list_del(&entry->list);
+		kfree(entry);
 		break;
 	}
 
-- 
1.6.0.1


