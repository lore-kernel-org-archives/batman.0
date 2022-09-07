Return-Path: <syoshida@redhat.com>
Date: Thu, 08 Sep 2022 01:00:37 +0900 (JST)
Message-Id: <20220908.010037.1643964170435041362.syoshida@redhat.com>
Subject: Re: [PATCH] batman-adv: Fix hang up with small MTU hard-interface
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220820032516.200446-1-syoshida@redhat.com>
References: <20220820032516.200446-1-syoshida@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, syoshida@redhat.com

ping?

On Sat, 20 Aug 2022 12:25:16 +0900, Shigeru Yoshida wrote:
> The system hangs up when batman-adv soft-interface is created on
> hard-interface with small MTU.  For example, the following commands
> create batman-adv soft-interface on dummy interface with zero MTU:
> 
>   # ip link add name dummy0 type dummy
>   # ip link set mtu 0 dev dummy0
>   # ip link set up dev dummy0
>   # ip link add name bat0 type batadv
>   # ip link set dev dummy0 master bat0
> 
> These commands cause the system hang up with the following messages:
> 
>   [   90.578925][ T6689] batman_adv: bat0: Adding interface: dummy0
>   [   90.580884][ T6689] batman_adv: bat0: The MTU of interface dummy0 is too small (0) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
>   [   90.586264][ T6689] batman_adv: bat0: Interface activated: dummy0
>   [   90.590061][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
>   [   90.595517][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
>   [   90.598499][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
> 
> This patch fixes this issue by returning error when enabling
> hard-interface with small MTU size.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/batman-adv/hard-interface.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index b8f8da7ee3de..dce5557800e9 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -700,6 +700,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>  	int max_header_len = batadv_max_header_len();
>  	int ret;
>  
> +	if (hard_iface->net_dev->mtu < ETH_MIN_MTU + max_header_len)
> +		return -EINVAL;
> +
>  	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
>  		goto out;
>  
> -- 
> 2.37.2
> 

