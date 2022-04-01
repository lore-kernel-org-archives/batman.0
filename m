Return-Path: <sashal@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 10/37] ipv6: make mc_forwarding atomic
Date: Fri,  1 Apr 2022 10:44:19 -0400
Message-Id: <20220401144446.1954694-10-sashal@kernel.org>
In-Reply-To: <20220401144446.1954694-1-sashal@kernel.org>
References: <20220401144446.1954694-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, yoshfuji@linux-ipv6.org, dsahern@kernel.org, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 145c7a793838add5e004e7d49a67654dc7eba147 ]

This fixes minor data-races in ip6_mc_input() and
batadv_mcast_mla_rtr_flags_softif_get_ipv6()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ipv6.h       | 2 +-
 net/batman-adv/multicast.c | 2 +-
 net/ipv6/addrconf.c        | 4 ++--
 net/ipv6/ip6_input.c       | 2 +-
 net/ipv6/ip6mr.c           | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index bbe297bbbca5..d5c507311efb 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -50,7 +50,7 @@ struct ipv6_devconf {
 	__s32		use_optimistic;
 #endif
 #ifdef CONFIG_IPV6_MROUTE
-	__s32		mc_forwarding;
+	atomic_t	mc_forwarding;
 #endif
 	__s32		disable_ipv6;
 	__s32		drop_unicast_in_l2_multicast;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 09d81f9c2a64..6f0a9f439233 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -136,7 +136,7 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv6(struct net_device *dev)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
-	if (in6_dev && in6_dev->cnf.mc_forwarding)
+	if (in6_dev && atomic_read(&in6_dev->cnf.mc_forwarding))
 		return BATADV_NO_FLAGS;
 	else
 		return BATADV_MCAST_WANT_NO_RTR6;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 60d070b25484..69aef71f32ea 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -542,7 +542,7 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 #ifdef CONFIG_IPV6_MROUTE
 	if ((all || type == NETCONFA_MC_FORWARDING) &&
 	    nla_put_s32(skb, NETCONFA_MC_FORWARDING,
-			devconf->mc_forwarding) < 0)
+			atomic_read(&devconf->mc_forwarding)) < 0)
 		goto nla_put_failure;
 #endif
 	if ((all || type == NETCONFA_PROXY_NEIGH) &&
@@ -5460,7 +5460,7 @@ static inline void ipv6_store_devconf(struct ipv6_devconf *cnf,
 	array[DEVCONF_USE_OPTIMISTIC] = cnf->use_optimistic;
 #endif
 #ifdef CONFIG_IPV6_MROUTE
-	array[DEVCONF_MC_FORWARDING] = cnf->mc_forwarding;
+	array[DEVCONF_MC_FORWARDING] = atomic_read(&cnf->mc_forwarding);
 #endif
 	array[DEVCONF_DISABLE_IPV6] = cnf->disable_ipv6;
 	array[DEVCONF_ACCEPT_DAD] = cnf->accept_dad;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 7e5df23cbe7b..e6c4966aa956 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -485,7 +485,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding &&
+	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index aee1f6bc039a..6248e00c2bf7 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -736,7 +736,7 @@ static int mif6_delete(struct mr_table *mrt, int vifi, int notify,
 
 	in6_dev = __in6_dev_get(dev);
 	if (in6_dev) {
-		in6_dev->cnf.mc_forwarding--;
+		atomic_dec(&in6_dev->cnf.mc_forwarding);
 		inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
 					     NETCONFA_MC_FORWARDING,
 					     dev->ifindex, &in6_dev->cnf);
@@ -904,7 +904,7 @@ static int mif6_add(struct net *net, struct mr_table *mrt,
 
 	in6_dev = __in6_dev_get(dev);
 	if (in6_dev) {
-		in6_dev->cnf.mc_forwarding++;
+		atomic_inc(&in6_dev->cnf.mc_forwarding);
 		inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
 					     NETCONFA_MC_FORWARDING,
 					     dev->ifindex, &in6_dev->cnf);
@@ -1553,7 +1553,7 @@ static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
 	} else {
 		rcu_assign_pointer(mrt->mroute_sk, sk);
 		sock_set_flag(sk, SOCK_RCU_FREE);
-		net->ipv6.devconf_all->mc_forwarding++;
+		atomic_inc(&net->ipv6.devconf_all->mc_forwarding);
 	}
 	write_unlock_bh(&mrt_lock);
 
@@ -1586,7 +1586,7 @@ int ip6mr_sk_done(struct sock *sk)
 			 * so the RCU grace period before sk freeing
 			 * is guaranteed by sk_destruct()
 			 */
-			net->ipv6.devconf_all->mc_forwarding--;
+			atomic_dec(&net->ipv6.devconf_all->mc_forwarding);
 			write_unlock_bh(&mrt_lock);
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_MC_FORWARDING,
-- 
2.34.1

