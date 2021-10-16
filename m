Return-Path: <nikolay@nvidia.com>
Message-ID: <badf4e55-ddeb-cfdd-4162-b8b9ae3fed04@nvidia.com>
Date: Sat, 16 Oct 2021 13:56:26 +0300
Subject: Re: [PATCH v2 net-next] net: make use of helper
 netif_is_bridge_master()
Content-Language: en-US
References: <20211016050439.2592877-1-acadx0@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211016050439.2592877-1-acadx0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org

On 16/10/2021 08:04, Kyungrok Chung wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
> ---
> 
> v1->v2:
>   - Apply fixes to batman-adv, core too.
> 
>  net/batman-adv/multicast.c      | 2 +-
>  net/bridge/br.c                 | 4 ++--
>  net/bridge/br_fdb.c             | 6 +++---
>  net/bridge/br_if.c              | 2 +-
>  net/bridge/br_ioctl.c           | 2 +-
>  net/bridge/br_mdb.c             | 4 ++--
>  net/bridge/br_netfilter_hooks.c | 2 +-
>  net/bridge/br_netlink.c         | 4 ++--
>  net/core/rtnetlink.c            | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
> 
[snip]
>  	err = br_afspec(br, p, afspec, RTM_DELLINK, &changed, NULL);
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 2dc1b209ba91..d3676666a529 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4384,7 +4384,7 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  					continue;
>  
>  				if (br_dev != netdev_master_upper_dev_get(dev) &&
> -				    !(dev->priv_flags & IFF_EBRIDGE))
> +				    netif_is_bridge_master(dev))
>  					continue;
>  				cops = ops;
>  			}
> 

This looks wrong, the original check is if it's _not_ a bridge master.
