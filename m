Return-Path: <ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next v3 2/7] mld: get rid of inet6_dev->mc_lock
Date: Thu, 25 Mar 2021 16:16:52 +0000
Message-Id: <20210325161657.10517-3-ap420073@gmail.com>
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

The purpose of mc_lock is to protect inet6_dev->mc_tomb.
But mc_tomb is already protected by RTNL and all functions,
which manipulate mc_tomb are called under RTNL.
So, mc_lock is not needed.
Furthermore, it is spinlock so the critical section is atomic.
In order to reduce atomic context, it should be removed.

Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
v2 -> v3:
 - No change
v1 -> v2:
 - Separated from previous big one patch.

 include/net/if_inet6.h | 1 -
 net/ipv6/mcast.c       | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index af5244c9ca5c..1080d2248304 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -167,7 +167,6 @@ struct inet6_dev {
 
 	struct ifmcaddr6	*mc_list;
 	struct ifmcaddr6	*mc_tomb;
-	spinlock_t		mc_lock;
 
 	unsigned char		mc_qrv;		/* Query Robustness Variable */
 	unsigned char		mc_gq_running;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 692a6dec8959..35962aa3cc22 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -752,10 +752,8 @@ static void mld_add_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 	}
 	spin_unlock_bh(&im->mca_lock);
 
-	spin_lock_bh(&idev->mc_lock);
 	pmc->next = idev->mc_tomb;
 	idev->mc_tomb = pmc;
-	spin_unlock_bh(&idev->mc_lock);
 }
 
 static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
@@ -764,7 +762,6 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 	struct ip6_sf_list *psf;
 	struct in6_addr *pmca = &im->mca_addr;
 
-	spin_lock_bh(&idev->mc_lock);
 	pmc_prev = NULL;
 	for (pmc = idev->mc_tomb; pmc; pmc = pmc->next) {
 		if (ipv6_addr_equal(&pmc->mca_addr, pmca))
@@ -777,7 +774,6 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 		else
 			idev->mc_tomb = pmc->next;
 	}
-	spin_unlock_bh(&idev->mc_lock);
 
 	spin_lock_bh(&im->mca_lock);
 	if (pmc) {
@@ -801,10 +797,8 @@ static void mld_clear_delrec(struct inet6_dev *idev)
 {
 	struct ifmcaddr6 *pmc, *nextpmc;
 
-	spin_lock_bh(&idev->mc_lock);
 	pmc = idev->mc_tomb;
 	idev->mc_tomb = NULL;
-	spin_unlock_bh(&idev->mc_lock);
 
 	for (; pmc; pmc = nextpmc) {
 		nextpmc = pmc->next;
@@ -1907,7 +1901,6 @@ static void mld_send_cr(struct inet6_dev *idev)
 	int type, dtype;
 
 	read_lock_bh(&idev->lock);
-	spin_lock(&idev->mc_lock);
 
 	/* deleted MCA's */
 	pmc_prev = NULL;
@@ -1941,7 +1934,6 @@ static void mld_send_cr(struct inet6_dev *idev)
 		} else
 			pmc_prev = pmc;
 	}
-	spin_unlock(&idev->mc_lock);
 
 	/* change recs */
 	for (pmc = idev->mc_list; pmc; pmc = pmc->next) {
@@ -2582,7 +2574,6 @@ void ipv6_mc_up(struct inet6_dev *idev)
 void ipv6_mc_init_dev(struct inet6_dev *idev)
 {
 	write_lock_bh(&idev->lock);
-	spin_lock_init(&idev->mc_lock);
 	idev->mc_gq_running = 0;
 	INIT_DELAYED_WORK(&idev->mc_gq_work, mld_gq_work);
 	idev->mc_tomb = NULL;
-- 
2.17.1

