Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 04/11] net: bridge: mcast: prepare query reception
 for mcast router split
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-5-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <02190208-f5b9-d761-abf5-1d85d0c62cd6@nvidia.com>
Date: Tue, 11 May 2021 12:13:45 +0300
In-Reply-To: <20210509194509.10849-5-linus.luessing@c0d3.blue>
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
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants and as the br_multicast_mark_router() will
> be split for that remove the select querier wrapper and instead add
> ip4 and ip6 variants for br_multicast_query_received().
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 53 ++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
>=20

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 6fe93a3..7edbbc9 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2615,22 +2615,6 @@ update:
>  }
>  #endif
> =20
> -static bool br_multicast_select_querier(struct net_bridge *br,
> -					struct net_bridge_port *port,
> -					struct br_ip *saddr)
> -{
> -	switch (saddr->proto) {
> -	case htons(ETH_P_IP):
> -		return br_ip4_multicast_select_querier(br, port, saddr->src.ip4);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	case htons(ETH_P_IPV6):
> -		return br_ip6_multicast_select_querier(br, port, &saddr->src.ip6);
> -#endif
> -	}
> -
> -	return false;
> -}
> -
>  static void
>  br_multicast_update_query_timer(struct net_bridge *br,
>  				struct bridge_mcast_other_query *query,
> @@ -2708,19 +2692,36 @@ static void br_multicast_mark_router(struct net=
_bridge *br,
>  		  now + br->multicast_querier_interval);
>  }
> =20
> -static void br_multicast_query_received(struct net_bridge *br,
> -					struct net_bridge_port *port,
> -					struct bridge_mcast_other_query *query,
> -					struct br_ip *saddr,
> -					unsigned long max_delay)
> +static void
> +br_ip4_multicast_query_received(struct net_bridge *br,
> +				struct net_bridge_port *port,
> +				struct bridge_mcast_other_query *query,
> +				struct br_ip *saddr,
> +				unsigned long max_delay)
>  {
> -	if (!br_multicast_select_querier(br, port, saddr))
> +	if (!br_ip4_multicast_select_querier(br, port, saddr->src.ip4))
>  		return;
> =20
>  	br_multicast_update_query_timer(br, query, max_delay);
>  	br_multicast_mark_router(br, port);
>  }
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +static void
> +br_ip6_multicast_query_received(struct net_bridge *br,
> +				struct net_bridge_port *port,
> +				struct bridge_mcast_other_query *query,
> +				struct br_ip *saddr,
> +				unsigned long max_delay)
> +{
> +	if (!br_ip6_multicast_select_querier(br, port, &saddr->src.ip6))
> +		return;
> +
> +	br_multicast_update_query_timer(br, query, max_delay);
> +	br_multicast_mark_router(br, port);
> +}
> +#endif
> +
>  static void br_ip4_multicast_query(struct net_bridge *br,
>  				   struct net_bridge_port *port,
>  				   struct sk_buff *skb,
> @@ -2768,8 +2769,8 @@ static void br_ip4_multicast_query(struct net_bri=
dge *br,
>  		saddr.proto =3D htons(ETH_P_IP);
>  		saddr.src.ip4 =3D iph->saddr;
> =20
> -		br_multicast_query_received(br, port, &br->ip4_other_query,
> -					    &saddr, max_delay);
> +		br_ip4_multicast_query_received(br, port, &br->ip4_other_query,
> +						&saddr, max_delay);
>  		goto out;
>  	}
> =20
> @@ -2856,8 +2857,8 @@ static int br_ip6_multicast_query(struct net_brid=
ge *br,
>  		saddr.proto =3D htons(ETH_P_IPV6);
>  		saddr.src.ip6 =3D ipv6_hdr(skb)->saddr;
> =20
> -		br_multicast_query_received(br, port, &br->ip6_other_query,
> -					    &saddr, max_delay);
> +		br_ip6_multicast_query_received(br, port, &br->ip6_other_query,
> +						&saddr, max_delay);
>  		goto out;
>  	} else if (!group) {
>  		goto out;
>=20
