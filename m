Return-Path: <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next v3 5/7] mld: convert ifmcaddr6 to RCU
References: <20210325161657.10517-1-ap420073@gmail.com>
 <20210325161657.10517-6-ap420073@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6262890a-7789-e3dd-aa04-58e5e06499dc@gmail.com>
Date: Mon, 29 Mar 2021 21:56:32 +0200
MIME-Version: 1.0
In-Reply-To: <20210325161657.10517-6-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: jwi@linux.ibm.com, kgraul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org



On 3/25/21 5:16 PM, Taehee Yoo wrote:
> The ifmcaddr6 has been protected by inet6_dev->lock(rwlock) so that
> the critical section is atomic context. In order to switch this context,
> changing locking is needed. The ifmcaddr6 actually already protected by
> RTNL So if it's converted to use RCU, its control path context can be
> switched to sleepable.
>

I do not really understand the changelog.

You wanted to convert from RCU to RTNL, right ?

Also :

> @@ -571,13 +573,9 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
>  	if (!ipv6_addr_is_multicast(group))
>  		return -EINVAL;
>  
> -	rcu_read_lock();
> -	idev = ip6_mc_find_dev_rcu(net, group, gsf->gf_interface);
> -
> -	if (!idev) {
> -		rcu_read_unlock();
> +	idev = ip6_mc_find_dev_rtnl(net, group, gsf->gf_interface);
> +	if (!idev)
>  		return -ENODEV;
> -	}
>  

I do not see RTNL being acquired before entering ip6_mc_msfget()


