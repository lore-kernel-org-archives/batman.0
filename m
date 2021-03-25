Return-Path: <ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next v3 0/7] mld: change context from atomic to sleepable
Date: Thu, 25 Mar 2021 16:16:50 +0000
Message-Id: <20210325161657.10517-1-ap420073@gmail.com>
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

This patchset changes the context of MLD module.
Before this patchset, MLD functions are atomic context so it couldn't use
sleepable functions and flags.

There are several reasons why MLD functions are under atomic context.
1. It uses timer API.
Timer expiration functions are executed in the atomic context.
2. atomic locks
MLD functions use rwlock and spinlock to protect their own resources.

So, in order to switch context, this patchset converts resources to use
RCU and removes atomic locks and timer API.

1. The first patch convert from the timer API to delayed work.
Timer API is used for delaying some works.
MLD protocol has a delay mechanism, which is used for replying to a query.
If a listener receives a query from a router, it should send a response
after some delay. But because of timer expire function is executed in
the atomic context, this patch convert from timer API to the delayed work.

2. The fourth patch deletes inet6_dev->mc_lock.
The mc_lock has protected inet6_dev->mc_tomb pointer.
But this pointer is already protected by RTNL and it isn't be used by
datapath. So, it isn't be needed and because of this, many atomic context
critical sections are deleted.

3. The fifth patch convert ip6_sf_socklist to RCU.
ip6_sf_socklist has been protected by ipv6_mc_socklist->sflock(rwlock).
But this is already protected by RTNL So if it is converted to use RCU
in order to be used in the datapath, the sflock is no more needed.
So, its control path context can be switched to sleepable.

4. The sixth patch convert ip6_sf_list to RCU.
The reason for this patch is the same as the previous patch.

5. The seventh patch convert ifmcaddr6 to RCU.
The reason for this patch is the same as the previous patch.

6. Add new workqueues for processing query/report event.
By this patch, query and report events are processed by workqueue
So context is sleepable, not atomic.
While this logic, it acquires RTNL.

7. Add new mc_lock.
The purpose of this lock is to protect per-interface mld data.
Per-interface mld data is usually used by query/report event handler.
So, query/report event workers need only this lock instead of RTNL.
Therefore, it could reduce bottleneck.

Changelog:
v2 -> v3:
1. Do not use msecs_to_jiffies().
(by Cong Wang)
2. Do not add unnecessary rtnl_lock() and rtnl_unlock().
(by Cong Wang)
3. Fix sparse warnings because of rcu annotation.
(by kernel test robot)
   - Remove some rcu_assign_pointer(), which was used for non-rcu pointer.
   - Add union for rcu pointer.
   - Use rcu API in mld_clear_zeros().
   - Remove remained rcu_read_unlock().
   - Use rcu API for tomb resources.
4. withdraw prevopus 2nd and 3rd patch.
   - "separate two flags from ifmcaddr6->mca_flags"
   - "add a new delayed_work, mc_delrec_work"
5. Add 6th and 7th patch.

v1 -> v2:
1. Withdraw unnecessary refactoring patches.
(by Cong Wang, Eric Dumazet, David Ahern)
    a) convert from array to list.
    b) function rename.
2. Separate big one patch into small several patches.
3. Do not rename 'ifmcaddr6->mca_lock'.
In the v1 patch, this variable was changed to 'ifmcaddr6->mca_work_lock'.
But this is actually not needed.
4. Do not use atomic_t for 'ifmcaddr6->mca_sfcount' and
'ipv6_mc_socklist'->sf_count'.
5. Do not add mld_check_leave_group() function.
6. Do not add ip6_mc_del_src_bulk() function.
7. Do not add ip6_mc_add_src_bulk() function.
8. Do not use rcu_read_lock() in the qeth_l3_add_mcast_rtnl().
(by Julian Wiedmann)

Taehee Yoo (7):
  mld: convert from timer to delayed work
  mld: get rid of inet6_dev->mc_lock
  mld: convert ipv6_mc_socklist->sflist to RCU
  mld: convert ip6_sf_list to RCU
  mld: convert ifmcaddr6 to RCU
  mld: add new workqueues for process mld events
  mld: add mc_lock for protecting per-interface mld data

 drivers/s390/net/qeth_l3_main.c |    6 +-
 include/net/if_inet6.h          |   37 +-
 include/net/mld.h               |    3 +
 net/batman-adv/multicast.c      |    6 +-
 net/ipv6/addrconf.c             |    9 +-
 net/ipv6/addrconf_core.c        |    2 +-
 net/ipv6/af_inet6.c             |    2 +-
 net/ipv6/icmp.c                 |    4 +-
 net/ipv6/mcast.c                | 1080 ++++++++++++++++++-------------
 9 files changed, 678 insertions(+), 471 deletions(-)

-- 
2.17.1

