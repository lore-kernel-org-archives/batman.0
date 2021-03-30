Return-Path: <ap420073@gmail.com>
Subject: Re: [PATCH net-next v3 7/7] mld: add mc_lock for protecting
 per-interface mld data
References: <20210325161657.10517-1-ap420073@gmail.com>
 <20210325161657.10517-8-ap420073@gmail.com>
 <fd460c2b-b974-db00-5097-4af08f12c670@gmail.com>
 <d3e101bb-14d2-4d91-6bc1-fbb766d69422@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Message-ID: <08f0a57c-8cad-2f62-0ba2-1bc6c6caad58@gmail.com>
Date: Wed, 31 Mar 2021 00:01:12 +0900
MIME-Version: 1.0
In-Reply-To: <d3e101bb-14d2-4d91-6bc1-fbb766d69422@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: jwi@linux.ibm.com, kgraul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On 3/30/21 9:24 PM, Eric Dumazet wrote:
 >
 >
 > On 3/30/21 1:59 PM, Eric Dumazet wrote:
 >>
 >>
 >> On 3/25/21 5:16 PM, Taehee Yoo wrote:
 >>> The purpose of this lock is to avoid a bottleneck in the query/report
 >>> event handler logic.
 >>>
 >>> By previous patches, almost all mld data is protected by RTNL.
 >>> So, the query and report event handler, which is data path logic
 >>> acquires RTNL too. Therefore if a lot of query and report events
 >>> are received, it uses RTNL for a long time.
 >>> So it makes the control-plane bottleneck because of using RTNL.
 >>> In order to avoid this bottleneck, mc_lock is added.
 >>>
 >>> mc_lock protect only per-interface mld data and per-interface mld
 >>> data is used in the query/report event handler logic.
 >>> So, no longer rtnl_lock is needed in the query/report event handler 
logic.
 >>> Therefore bottleneck will be disappeared by mc_lock.
 >>>
 >>
 >> What testsuite have you run exactly to validate this monster patch ?
 >>

I've been using an application, which calls setsockopt() with the below 
options.
IPV6_ADD_MEMBERSHIP
IPV6_DROP_MEMBERSHIP
MCAST_JOIN_SOURCE_GROUP
MCAST_LEAVE_SOURCE_GROUP
MCAST_BLOCK_SOURCE
MCAST_UNBLOCK_SOURCE
MCAST_MSFILTER
And checks out  /proc/net/mcfilter6 and /proc/net/igmp6.

 >> Have you used CONFIG_LOCKDEP=y / CONFIG_DEBUG_ATOMIC_SLEEP=y ?
 >>

Yes, I'm using both configs.

 >>> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
 >>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
 >>
 >> [...]
 >>
 >>>   /*
 >>> - *	device multicast group del
 >>> + * device multicast group del
 >>>    */
 >>>   int __ipv6_dev_mc_dec(struct inet6_dev *idev, const struct 
in6_addr *addr)
 >>>   {
 >>> @@ -943,8 +967,9 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, 
const struct in6_addr *addr)
 >>>
 >>>   	ASSERT_RTNL();
 >>>
 >>> +	mutex_lock(&idev->mc_lock);
 >>>   	for (map = &idev->mc_list;
 >>> -	     (ma = rtnl_dereference(*map));
 >>> +	     (ma = mc_dereference(*map, idev));
 >>>   	     map = &ma->next) {
 >>>   		if (ipv6_addr_equal(&ma->mca_addr, addr)) {
 >>>   			if (--ma->mca_users == 0) {
 >>
 >> This can be called with rcu_bh held, thus :
 >>
 >> BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:928
 >> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4624, name: 
kworker/1:2
 >> 4 locks held by kworker/1:2/4624:
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: set_work_data kernel/workqueue.c:616 [inline]
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 >>   #0: ffff88802135d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, 
at: process_one_work+0x871/0x1600 kernel/workqueue.c:2246
 >>   #1: ffffc90009adfda8 ((addr_chk_work).work){+.+.}-{0:0}, at: 
process_one_work+0x8a5/0x1600 kernel/workqueue.c:2250
 >>   #2: ffffffff8d66d328 (rtnl_mutex){+.+.}-{3:3}, at: 
addrconf_verify_work+0xa/0x20 net/ipv6/addrconf.c:4572
 >>   #3: ffffffff8bf74300 (rcu_read_lock_bh){....}-{1:2}, at: 
addrconf_verify_rtnl+0x2b/0x1150 net/ipv6/addrconf.c:4459
 >> Preemption disabled at:
 >> [<ffffffff87b39f41>] local_bh_disable include/linux/bottom_half.h:19 
[inline]
 >> [<ffffffff87b39f41>] rcu_read_lock_bh include/linux/rcupdate.h:727 
[inline]
 >> [<ffffffff87b39f41>] addrconf_verify_rtnl+0x41/0x1150 
net/ipv6/addrconf.c:4461
 >> CPU: 1 PID: 4624 Comm: kworker/1:2 Not tainted 5.12.0-rc4-syzkaller #0
 >> Hardware name: Google Google Compute Engine/Google Compute Engine, 
BIOS Google 01/01/2011
 >> Workqueue: ipv6_addrconf addrconf_verify_work
 >> Call Trace:
 >>   __dump_stack lib/dump_stack.c:79 [inline]
 >>   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 >>   ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:8328
 >>   __mutex_lock_common kernel/locking/mutex.c:928 [inline]
 >>   __mutex_lock+0xa9/0x1120 kernel/locking/mutex.c:1096
 >>   __ipv6_dev_mc_dec+0x5f/0x340 net/ipv6/mcast.c:970
 >>   addrconf_leave_solict net/ipv6/addrconf.c:2182 [inline]
 >>   addrconf_leave_solict net/ipv6/addrconf.c:2174 [inline]
 >>   __ipv6_ifa_notify+0x5b6/0xa90 net/ipv6/addrconf.c:6077
 >>   ipv6_ifa_notify net/ipv6/addrconf.c:6100 [inline]
 >>   ipv6_del_addr+0x463/0xae0 net/ipv6/addrconf.c:1294
 >>   addrconf_verify_rtnl+0xd59/0x1150 net/ipv6/addrconf.c:4488
 >>   addrconf_verify_work+0xf/0x20 net/ipv6/addrconf.c:4573
 >>   process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 >>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 >>   kthread+0x3b1/0x4a0 kernel/kthread.c:292
 >>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
 >>
 >
 > I will test this fix:

Thanks a lot!

 >
 > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
 > index 
120073ffb666b18678e3145d91dac59fa865a592..8f3883f4cb4a15a0749b8f0fe00061e483ea26ca 
100644
 > --- a/net/ipv6/addrconf.c
 > +++ b/net/ipv6/addrconf.c
 > @@ -4485,7 +4485,9 @@ static void addrconf_verify_rtnl(void)
 >                              age >= ifp->valid_lft) {
 >                                  spin_unlock(&ifp->lock);
 >                                  in6_ifa_hold(ifp);
 > +                               rcu_read_unlock_bh();
 >                                  ipv6_del_addr(ifp);
 > +                               rcu_read_lock_bh();
 >                                  goto restart;
 >                          } else if (ifp->prefered_lft == 
INFINITY_LIFE_TIME) {
 >                                  spin_unlock(&ifp->lock);
 >
