Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 11 Nov 2013 20:32:12 +0100
Message-Id: <1384198332-25345-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: silence smatch errors in
	multicast compat code
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

smatch is reporting problems of unreachable code parts:

multicast.c:170 batadv_mcast_get_bridge() info: ignoring unreachable
code.
tmp/multicast.c:172 batadv_mcast_get_bridge() info: ignoring
unreachable code.

These are caused by compat code which returns within a loop, never
giving the rest of the function a chance to be processed. This can be
changed by slightly adjusting the compat code, setting the iterator
variable to NULL and let the original function handle the rest. This
does not introduce any functional change.

Introduced by: a3f58139efedb96222dffdda89896c243fdff49e
("batman-adv: Multicast Listener Announcements via Translation Table")

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
Changes to PATCH:
 * remove useless \
---
 compat.h |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/compat.h b/compat.h
index 186547b..86ef366 100644
--- a/compat.h
+++ b/compat.h
@@ -160,14 +160,12 @@ static inline int batadv_param_set_copystring(const char *val,
 #define NET_ADDR_RANDOM 0
 
 #define netdev_master_upper_dev_get_rcu(dev) \
-	upper; \
-	rcu_read_unlock(); \
+	NULL; \
 	if (dev->br_port ? 1 : 0) { \
+		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	} \
-\
-	return NULL\
+	}
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
@@ -344,14 +342,12 @@ static int __batadv_interface_set_mac_addr(x, y)
 
 #ifndef netdev_master_upper_dev_get_rcu
 #define netdev_master_upper_dev_get_rcu(dev) \
-	upper; \
-	rcu_read_unlock(); \
+	NULL; \
 	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
+		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	} \
-\
-	return NULL\
+	}
 
 #endif /* netdev_master_upper_dev_get_rcu */
 
-- 
1.7.10.4

