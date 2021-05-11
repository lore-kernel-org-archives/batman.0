Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 10/11] net: bridge: mcast: add ip4+ip6 mcast router
 timers to mdb netlink
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-11-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <04761487-8abe-830e-7cf1-84a270d58ff5@nvidia.com>
Date: Tue, 11 May 2021 12:30:26 +0300
In-Reply-To: <20210509194509.10849-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org

On 09/05/2021 22:45, Linus L=C3=BCssing wrote:
> Now that we have split the multicast router state into two, one for IPv=
4
> and one for IPv6, also add individual timers to the mdb netlink router
> port dump. Leaving the old timer attribute for backwards compatibility.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/if_bridge.h | 2 ++
>  net/bridge/br_mdb.c            | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bri=
dge.h
> index 13d59c5..6b56a75 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -627,6 +627,8 @@ enum {
>  	MDBA_ROUTER_PATTR_UNSPEC,
>  	MDBA_ROUTER_PATTR_TIMER,
>  	MDBA_ROUTER_PATTR_TYPE,
> +	MDBA_ROUTER_PATTR_INET_TIMER,
> +	MDBA_ROUTER_PATTR_INET6_TIMER,
>  	__MDBA_ROUTER_PATTR_MAX
>  };
>  #define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 3c608da..2cdd9b6 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -79,7 +79,13 @@ static int br_rports_fill_info(struct sk_buff *skb, =
struct netlink_callback *cb,
>  		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
>  				max(ip4_timer, ip6_timer)) ||
>  		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
> -			       p->multicast_router)) {
> +			       p->multicast_router) ||
> +		    (have_ip4_mc_rtr &&
> +		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET_TIMER,
> +				 ip4_timer)) ||
> +		    (have_ip6_mc_rtr &&
> +		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET6_TIMER,
> +				 ip6_timer))) {
>  			nla_nest_cancel(skb, port_nest);
>  			goto fail;
>  		}
>=20
