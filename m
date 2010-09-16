Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 23:32:01 +0200
Message-Id: <1284672721-28527-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284672174-27464-3-git-send-email-sven.eckelmann@gmx.de>
References: <1284672174-27464-3-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use refcnt to track usage
	count of batman_if
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

get_batman_if_by_netdev and get_active_batman_if may leak data from the
rcu protected list of interfaces. The rcu protected list of all gateway
nodes leaks the actual data outside the read-side critical area. This is
not valid as we may free the data using a call_rcu created callback
after we unlock using rcu_read_unlock. A workaround is to provide a
reference count to be sure that the memory isn't freed to early.

It is currently only to implement the already existing functionality and
doesn't provide the full tracking of all usage cases.

Additionally, we must hardif_hold inside the
rcu_read_lock()..rcu_read_unlock() before we attach to the structure
which "leaks" it. When another function now removed it from its usage
context (primary_if, usage on stack, ...) then we must hardif_put it. If
it is decremented to zero then we can issue the call_rcu to the freeing
function. So "put" is not allowed inside an rcu_read_lock.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Hmpf, small copy and paste failure (used hardif_hold instead of hardif_put).

 batman-adv/hard-interface.c |    6 ++++--
 batman-adv/hard-interface.h |   13 +++++++++++++
 batman-adv/types.h          |    1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 3cd7cb1..4513856 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -403,6 +403,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&batman_if->list);
+	atomic_set(&batman_if->refcnt, 0);
+	hardif_hold(batman_if);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
 
@@ -420,7 +422,7 @@ out:
 	return NULL;
 }
 
-static void hardif_free_interface(struct rcu_head *rcu)
+void hardif_free_interface(struct rcu_head *rcu)
 {
 	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
 
@@ -442,7 +444,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 	list_del_rcu(&batman_if->list);
 	sysfs_del_hardif(&batman_if->hardif_obj);
 	dev_put(batman_if->net_dev);
-	call_rcu(&batman_if->rcu, hardif_free_interface);
+	hardif_put(batman_if);
 }
 
 void hardif_remove_interfaces(void)
diff --git a/batman-adv/hard-interface.h b/batman-adv/hard-interface.h
index 4b49527..0f72b17 100644
--- a/batman-adv/hard-interface.h
+++ b/batman-adv/hard-interface.h
@@ -41,5 +41,18 @@ int batman_skb_recv(struct sk_buff *skb,
 				struct net_device *orig_dev);
 int hardif_min_mtu(struct net_device *soft_iface);
 void update_min_mtu(struct net_device *soft_iface);
+void hardif_free_interface(struct rcu_head *rcu);
+
+static inline void hardif_hold(struct batman_if *batman_if)
+{
+	atomic_inc(&batman_if->refcnt);
+}
+
+static inline void hardif_put(struct batman_if *batman_if)
+{
+	if (atomic_dec_and_test(&batman_if->refcnt))
+		call_rcu(&batman_if->rcu, hardif_free_interface);
+}
+
 
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index a088064..80880cf 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -44,6 +44,7 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
+	atomic_t refcnt;
 	struct rcu_head rcu;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
-- 
1.7.2.3

