Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 06/11] net: bridge: mcast: prepare expiry functions
 for mcast router split
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-7-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <0998c872-f18e-19a0-d137-9144dcb7b18d@nvidia.com>
Date: Tue, 11 May 2021 12:16:59 +0300
In-Reply-To: <20210509194509.10849-7-linus.luessing@c0d3.blue>
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
> their IPv4 and IPv6 variants move the protocol specific timer access to
> an ip4 wrapper function.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 048b5b9..6c844b2 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1354,16 +1354,16 @@ static int br_ip6_multicast_add_group(struct ne=
t_bridge *br,
>  }
>  #endif
> =20
> -static void br_multicast_router_expired(struct timer_list *t)
> +static void br_multicast_router_expired(struct net_bridge_port *port,
> +					struct timer_list *t,
> +					struct hlist_node *rlist)
>  {
> -	struct net_bridge_port *port =3D
> -			from_timer(port, t, ip4_mc_router_timer);
>  	struct net_bridge *br =3D port->br;
> =20
>  	spin_lock(&br->multicast_lock);
>  	if (port->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
>  	    port->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
> -	    timer_pending(&port->ip4_mc_router_timer))
> +	    timer_pending(t))
>  		goto out;
> =20
>  	__del_port_router(port);
> @@ -1371,6 +1371,13 @@ out:
>  	spin_unlock(&br->multicast_lock);
>  }
> =20
> +static void br_ip4_multicast_router_expired(struct timer_list *t)
> +{
> +	struct net_bridge_port *port =3D from_timer(port, t, ip4_mc_router_ti=
mer);
> +
> +	br_multicast_router_expired(port, t, &port->ip4_rlist);
> +}
> +
>  static void br_mc_router_state_change(struct net_bridge *p,
>  				      bool is_mc_router)
>  {
> @@ -1384,10 +1391,9 @@ static void br_mc_router_state_change(struct net=
_bridge *p,
>  	switchdev_port_attr_set(p->dev, &attr, NULL);
>  }
> =20
> -static void br_multicast_local_router_expired(struct timer_list *t)
> +static void br_multicast_local_router_expired(struct net_bridge *br,
> +					      struct timer_list *timer)
>  {
> -	struct net_bridge *br =3D from_timer(br, t, ip4_mc_router_timer);
> -
>  	spin_lock(&br->multicast_lock);
>  	if (br->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
>  	    br->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
> @@ -1400,6 +1406,13 @@ out:
>  	spin_unlock(&br->multicast_lock);
>  }
> =20
> +static inline void br_ip4_multicast_local_router_expired(struct timer_=
list *t)
> +{
> +	struct net_bridge *br =3D from_timer(br, t, ip4_mc_router_timer);
> +
> +	br_multicast_local_router_expired(br, t);
> +}
> +

Same comment about inlines in .c files, please move them to br_private.h =
or drop the inline

>  static void br_multicast_querier_expired(struct net_bridge *br,
>  					 struct bridge_mcast_own_query *query)
>  {
> @@ -1615,7 +1628,7 @@ int br_multicast_add_port(struct net_bridge_port =
*port)
>  	port->multicast_eht_hosts_limit =3D BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT;
> =20
>  	timer_setup(&port->ip4_mc_router_timer,
> -		    br_multicast_router_expired, 0);
> +		    br_ip4_multicast_router_expired, 0);
>  	timer_setup(&port->ip4_own_query.timer,
>  		    br_ip4_multicast_port_query_expired, 0);
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -3319,7 +3332,7 @@ void br_multicast_init(struct net_bridge *br)
> =20
>  	spin_lock_init(&br->multicast_lock);
>  	timer_setup(&br->ip4_mc_router_timer,
> -		    br_multicast_local_router_expired, 0);
> +		    br_ip4_multicast_local_router_expired, 0);
>  	timer_setup(&br->ip4_other_query.timer,
>  		    br_ip4_multicast_querier_expired, 0);
>  	timer_setup(&br->ip4_own_query.timer,
>=20
