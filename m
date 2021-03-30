Return-Path: <ap420073@gmail.com>
Subject: Re: [PATCH net-next v3 5/7] mld: convert ifmcaddr6 to RCU
References: <20210325161657.10517-1-ap420073@gmail.com>
 <20210325161657.10517-6-ap420073@gmail.com>
 <6262890a-7789-e3dd-aa04-58e5e06499dc@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Message-ID: <f054971d-8be0-92ba-009b-9681e08f841c@gmail.com>
Date: Tue, 30 Mar 2021 12:41:40 +0900
MIME-Version: 1.0
In-Reply-To: <6262890a-7789-e3dd-aa04-58e5e06499dc@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: ko
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
To: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: jwi@linux.ibm.com, kgraul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, xiyou.wangcong@gmail.com

On 2021. 3. 30. 오전 4:56, Eric Dumazet wrote:
 >
 >

Hi Eric,
Thank you for the review!

 > On 3/25/21 5:16 PM, Taehee Yoo wrote:
 >> The ifmcaddr6 has been protected by inet6_dev->lock(rwlock) so that
 >> the critical section is atomic context. In order to switch this context,
 >> changing locking is needed. The ifmcaddr6 actually already protected by
 >> RTNL So if it's converted to use RCU, its control path context can be
 >> switched to sleepable.
 >>
 >
 > I do not really understand the changelog.
 >
 > You wanted to convert from RCU to RTNL, right ?

The purpose of this is to use both RCU and RTNL.
In the control path, ifmcaddr6 is protected by RTNL
(setsockopt_needs_rtnl() in the do_ipv6_setsockopt())
And in the data path, ifmcaddr6 will be protected by RCU.

But ifmcaddr6 is already protected by RTNL in the control path.
So, this patch is to convert ifmcaddr6 to RCU only for datapath.
Therefore, by this patch, ifmcaddr6 will be protected by both RTNL and RCU.

I'm so sorry for this strange changelog.

 >
 > Also :
 >
 >> @@ -571,13 +573,9 @@ int ip6_mc_msfget(struct sock *sk, struct 
group_filter *gsf,
 >>   	if (!ipv6_addr_is_multicast(group))
 >>   		return -EINVAL;
 >>
 >> -	rcu_read_lock();
 >> -	idev = ip6_mc_find_dev_rcu(net, group, gsf->gf_interface);
 >> -
 >> -	if (!idev) {
 >> -		rcu_read_unlock();
 >> +	idev = ip6_mc_find_dev_rtnl(net, group, gsf->gf_interface);
 >> +	if (!idev)
 >>   		return -ENODEV;
 >> -	}
 >>
 >
 > I do not see RTNL being acquired before entering ip6_mc_msfget()
 >

Thank you so much for catching this.
I will send a patch to fix this problem!

Thanks a lot!
Taehee Yoo
