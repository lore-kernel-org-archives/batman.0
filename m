Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2] batman-adv: Get inet(6) device inside RCU protected region
Date: Thu, 27 Jun 2019 19:22:06 +0200
Message-Id: <20190627172206.22683-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It is not necessary to get the inet(6)_dev outside of the rcu protected
region by using reference counting. Instead, the in(6)_dev_get can be
replaced by the non-refcnt function and everything can be moved inside the
rcu protected region.

Fixes: 0a7733468f95 ("batman-adv: mcast: detect, distribute and maintain multicast router presence")
Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:

* leave read_lock_bh for in6_dev->mc_list

 net/batman-adv/multicast.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 40ceab95..67d7f830 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -379,11 +379,14 @@ batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
 	if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV4)
 		return 0;
 
-	in_dev = in_dev_get(dev);
-	if (!in_dev)
+	rcu_read_lock();
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (!in_dev) {
+		rcu_read_unlock();
 		return 0;
+	}
 
-	rcu_read_lock();
 	for (pmc = rcu_dereference(in_dev->mc_list); pmc;
 	     pmc = rcu_dereference(pmc->next_rcu)) {
 		if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
@@ -410,7 +413,6 @@ batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
 		ret++;
 	}
 	rcu_read_unlock();
-	in_dev_put(in_dev);
 
 	return ret;
 }
@@ -444,9 +446,13 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
 	if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6)
 		return 0;
 
-	in6_dev = in6_dev_get(dev);
-	if (!in6_dev)
+	rcu_read_lock();
+
+	in6_dev = __in6_dev_get(dev);
+	if (!in6_dev) {
+		rcu_read_unlock();
 		return 0;
+	}
 
 	read_lock_bh(&in6_dev->lock);
 	for (pmc6 = in6_dev->mc_list; pmc6; pmc6 = pmc6->next) {
@@ -479,7 +485,7 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
 		ret++;
 	}
 	read_unlock_bh(&in6_dev->lock);
-	in6_dev_put(in6_dev);
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.20.1

