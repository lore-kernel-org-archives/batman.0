Return-Path: <ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next v3 3/7] mld: convert ipv6_mc_socklist->sflist to RCU
Date: Thu, 25 Mar 2021 16:16:53 +0000
Message-Id: <20210325161657.10517-4-ap420073@gmail.com>
In-Reply-To: <20210325161657.10517-1-ap420073@gmail.com>
References: <20210325161657.10517-1-ap420073@gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: ap420073@gmail.com, jwi@linux.ibm.com, kgraul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

The sflist has been protected by rwlock so that the critical section
is atomic context.
In order to switch this context, changing locking is needed.
The sflist actually already protected by RTNL So if it's converted
to use RCU, its control path context can be switched to sleepable.

Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
v2 -> v3:
 - Fix sparse warnings because of rcu annotation
v1 -> v2:
 - Separated from previous big one patch.

 include/net/if_inet6.h |  4 ++--
 net/ipv6/mcast.c       | 52 ++++++++++++++++++------------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index 1080d2248304..062294aeeb6d 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -78,6 +78,7 @@ struct inet6_ifaddr {
 struct ip6_sf_socklist {
 	unsigned int		sl_max;
 	unsigned int		sl_count;
+	struct rcu_head		rcu;
 	struct in6_addr		sl_addr[];
 };
 
@@ -91,8 +92,7 @@ struct ipv6_mc_socklist {
 	int			ifindex;
 	unsigned int		sfmode;		/* MCAST_{INCLUDE,EXCLUDE} */
 	struct ipv6_mc_socklist __rcu *next;
-	rwlock_t		sflock;
-	struct ip6_sf_socklist	*sflist;
+	struct ip6_sf_socklist	__rcu *sflist;
 	struct rcu_head		rcu;
 };
 
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 35962aa3cc22..9da55d23a13c 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -178,8 +178,7 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 
 	mc_lst->ifindex = dev->ifindex;
 	mc_lst->sfmode = mode;
-	rwlock_init(&mc_lst->sflock);
-	mc_lst->sflist = NULL;
+	RCU_INIT_POINTER(mc_lst->sflist, NULL);
 
 	/*
 	 *	now add/increase the group membership on the device
@@ -335,7 +334,6 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	struct net *net = sock_net(sk);
 	int i, j, rv;
 	int leavegroup = 0;
-	int pmclocked = 0;
 	int err;
 
 	source = &((struct sockaddr_in6 *)&pgsr->gsr_source)->sin6_addr;
@@ -364,7 +362,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		goto done;
 	}
 	/* if a source filter was set, must be the same mode as before */
-	if (pmc->sflist) {
+	if (rcu_access_pointer(pmc->sflist)) {
 		if (pmc->sfmode != omode) {
 			err = -EINVAL;
 			goto done;
@@ -376,10 +374,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		pmc->sfmode = omode;
 	}
 
-	write_lock(&pmc->sflock);
-	pmclocked = 1;
-
-	psl = pmc->sflist;
+	psl = rtnl_dereference(pmc->sflist);
 	if (!add) {
 		if (!psl)
 			goto done;	/* err = -EADDRNOTAVAIL */
@@ -429,9 +424,11 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		if (psl) {
 			for (i = 0; i < psl->sl_count; i++)
 				newpsl->sl_addr[i] = psl->sl_addr[i];
-			sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
+			atomic_sub(IP6_SFLSIZE(psl->sl_max), &sk->sk_omem_alloc);
+			kfree_rcu(psl, rcu);
 		}
-		pmc->sflist = psl = newpsl;
+		psl = newpsl;
+		rcu_assign_pointer(pmc->sflist, psl);
 	}
 	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
 	for (i = 0; i < psl->sl_count; i++) {
@@ -447,8 +444,6 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	/* update the interface list */
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
-	if (pmclocked)
-		write_unlock(&pmc->sflock);
 	read_unlock_bh(&idev->lock);
 	rcu_read_unlock();
 	if (leavegroup)
@@ -526,17 +521,16 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 		(void) ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
 	}
 
-	write_lock(&pmc->sflock);
-	psl = pmc->sflist;
+	psl = rtnl_dereference(pmc->sflist);
 	if (psl) {
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode,
 			psl->sl_count, psl->sl_addr, 0);
-		sock_kfree_s(sk, psl, IP6_SFLSIZE(psl->sl_max));
+		atomic_sub(IP6_SFLSIZE(psl->sl_max), &sk->sk_omem_alloc);
+		kfree_rcu(psl, rcu);
 	} else
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
-	pmc->sflist = newpsl;
+	rcu_assign_pointer(pmc->sflist, newpsl);
 	pmc->sfmode = gsf->gf_fmode;
-	write_unlock(&pmc->sflock);
 	err = 0;
 done:
 	read_unlock_bh(&idev->lock);
@@ -585,16 +579,14 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	if (!pmc)		/* must have a prior join */
 		goto done;
 	gsf->gf_fmode = pmc->sfmode;
-	psl = pmc->sflist;
+	psl = rtnl_dereference(pmc->sflist);
 	count = psl ? psl->sl_count : 0;
 	read_unlock_bh(&idev->lock);
 	rcu_read_unlock();
 
 	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
 	gsf->gf_numsrc = count;
-	/* changes to psl require the socket lock, and a write lock
-	 * on pmc->sflock. We have the socket lock so reading here is safe.
-	 */
+
 	for (i = 0; i < copycount; i++, p++) {
 		struct sockaddr_in6 *psin6;
 		struct sockaddr_storage ss;
@@ -630,8 +622,7 @@ bool inet6_mc_check(struct sock *sk, const struct in6_addr *mc_addr,
 		rcu_read_unlock();
 		return np->mc_all;
 	}
-	read_lock(&mc->sflock);
-	psl = mc->sflist;
+	psl = rcu_dereference(mc->sflist);
 	if (!psl) {
 		rv = mc->sfmode == MCAST_EXCLUDE;
 	} else {
@@ -646,7 +637,6 @@ bool inet6_mc_check(struct sock *sk, const struct in6_addr *mc_addr,
 		if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
 			rv = false;
 	}
-	read_unlock(&mc->sflock);
 	rcu_read_unlock();
 
 	return rv;
@@ -2422,19 +2412,21 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
 			    struct inet6_dev *idev)
 {
+	struct ip6_sf_socklist *psl;
 	int err;
 
-	write_lock_bh(&iml->sflock);
-	if (!iml->sflist) {
+	psl = rtnl_dereference(iml->sflist);
+
+	if (!psl) {
 		/* any-source empty exclude case */
 		err = ip6_mc_del_src(idev, &iml->addr, iml->sfmode, 0, NULL, 0);
 	} else {
 		err = ip6_mc_del_src(idev, &iml->addr, iml->sfmode,
-				iml->sflist->sl_count, iml->sflist->sl_addr, 0);
-		sock_kfree_s(sk, iml->sflist, IP6_SFLSIZE(iml->sflist->sl_max));
-		iml->sflist = NULL;
+				psl->sl_count, psl->sl_addr, 0);
+		RCU_INIT_POINTER(iml->sflist, NULL);
+		atomic_sub(IP6_SFLSIZE(psl->sl_max), &sk->sk_omem_alloc);
+		kfree_rcu(psl, rcu);
 	}
-	write_unlock_bh(&iml->sflock);
 	return err;
 }
 
-- 
2.17.1

