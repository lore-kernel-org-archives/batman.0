Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/10] batman-adv: mcast: avoid redundant multicast TT entries
 with bridges
Date: Thu, 27 Jun 2019 12:39:35 +0200
Message-Id: <20190627103938.7488-8-sw@simonwunderlich.de>
In-Reply-To: <20190627103938.7488-1-sw@simonwunderlich.de>
References: <20190627103938.7488-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

When a bridge is added on top of bat0 we set the WANT_ALL_UNSNOOPABLES
flag. Which means we sign up for all traffic for ff02::1/128 and
224.0.0.0/24.

When the node itself had IPv6 enabled or joined a group in 224.0.0.0/24
itself then so far this would result in a multicast TT entry which is
redundant to the WANT_ALL_UNSNOOPABLES.

With this patch such redundant TT entries are avoided.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 693e3bba1a15..5940c2df641d 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -227,6 +227,10 @@ batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
 	rcu_read_lock();
 	for (pmc = rcu_dereference(in_dev->mc_list); pmc;
 	     pmc = rcu_dereference(pmc->next_rcu)) {
+		if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
+		    ipv4_is_local_multicast(pmc->multiaddr))
+			continue;
+
 		ip_eth_mc_map(pmc->multiaddr, mcast_addr);
 
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
@@ -287,6 +291,10 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
 		    IPV6_ADDR_SCOPE_LINKLOCAL)
 			continue;
 
+		if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
+		    ipv6_addr_is_ll_all_nodes(&pmc6->mca_addr))
+			continue;
+
 		ipv6_eth_mc_map(&pmc6->mca_addr, mcast_addr);
 
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
@@ -407,9 +415,8 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				       struct batadv_mcast_mla_flags *flags)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
-	bool all_ipv4 = flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV4;
-	bool all_ipv6 = flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6;
 	struct br_ip_list *br_ip_entry, *tmp;
+	u8 tvlv_flags = flags->tvlv_flags;
 	struct batadv_hw_addr *new;
 	u8 mcast_addr[ETH_ALEN];
 	int ret;
@@ -422,11 +429,25 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 		goto out;
 
 	list_for_each_entry(br_ip_entry, &bridge_mcast_list, list) {
-		if (all_ipv4 && br_ip_entry->addr.proto == htons(ETH_P_IP))
-			continue;
+		if (br_ip_entry->addr.proto == htons(ETH_P_IP)) {
+			if (tvlv_flags & BATADV_MCAST_WANT_ALL_IPV4)
+				continue;
 
-		if (all_ipv6 && br_ip_entry->addr.proto == htons(ETH_P_IPV6))
-			continue;
+			if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
+			    ipv4_is_local_multicast(br_ip_entry->addr.u.ip4))
+				continue;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (br_ip_entry->addr.proto == htons(ETH_P_IPV6)) {
+			if (tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6)
+				continue;
+
+			if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
+			    ipv6_addr_is_ll_all_nodes(&br_ip_entry->addr.u.ip6))
+				continue;
+		}
+#endif
 
 		batadv_mcast_mla_br_addr_cpy(mcast_addr, &br_ip_entry->addr);
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
-- 
2.11.0

