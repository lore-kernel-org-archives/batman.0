Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 11/11] net: bridge: mcast: export multicast router
 presence adjacent to a port
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-12-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <7279c94e-a4ff-2fbb-290e-bdaf5844148c@nvidia.com>
Date: Tue, 11 May 2021 12:23:24 +0300
In-Reply-To: <20210509194509.10849-12-linus.luessing@c0d3.blue>
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
> To properly support routable multicast addresses in batman-adv in a
> group-aware way, a batman-adv node needs to know if it serves multicast
> routers.
>=20
> This adds a function to the bridge to export this so that batman-adv
> can then make full use of the Multicast Router Discovery capability of
> the bridge.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b625fd6..e963de5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4061,6 +4061,64 @@ unlock:
>  }
>  EXPORT_SYMBOL_GPL(br_multicast_has_querier_adjacent);
> =20
> +/**
> + * br_multicast_has_router_adjacent - Checks for a router behind a bri=
dge port
> + * @dev: The bridge port adjacent to which to check for a multicast ro=
uter
> + * @proto: The protocol family to check for: IGMP -> ETH_P_IP, MLD -> =
ETH_P_IPV6
> + *
> + * Checks whether the given interface has a bridge on top and if so re=
turns
> + * true if a multicast router is behind one of the other ports of this
> + * bridge. Otherwise returns false.
> + */
> +bool br_multicast_has_router_adjacent(struct net_device *dev, int prot=
o)
> +{
> +	struct net_bridge_port *port, *p;
> +	bool ret =3D false;
> +
> +	rcu_read_lock();
> +	if (!netif_is_bridge_port(dev))
> +		goto unlock;
> +
> +	port =3D br_port_get_rcu(dev);

You can combine both of netif_is_bridge_port and br_port_get_rcu() checks=
 and use
br_port_get_check_rcu(). Then you can also drop the port->br check.


> +	if (!port || !port->br)
> +		goto unlock;
> +
> +	switch (proto) {
> +	case ETH_P_IP:
> +		hlist_for_each_entry_rcu(p, &port->br->ip4_mc_router_list,
> +					 ip4_rlist) {
> +			if (p =3D=3D port)
> +				continue;
> +
> +			ret =3D true;
> +			goto unlock;
> +		}
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:
> +		hlist_for_each_entry_rcu(p, &port->br->ip6_mc_router_list,
> +					 ip6_rlist) {
> +			if (p =3D=3D port)
> +				continue;
> +
> +			ret =3D true;
> +			goto unlock;
> +		}
> +		break;
> +#endif
> +	default:
> +		/* when compiled without IPv6 support, be conservative and
> +		 * always assume presence of an IPv6 multicast router
> +		 */
> +		ret =3D true;
> +	}
> +
> +unlock:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(br_multicast_has_router_adjacent);
> +
>  static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *sta=
ts,
>  			       const struct sk_buff *skb, u8 type, u8 dir)
>  {
>=20
