Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 08/11] net: bridge: mcast: split router port
 del+notify for mcast router split
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-9-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <640d2ba9-9e56-a36c-3734-44d72d8a6512@nvidia.com>
Date: Tue, 11 May 2021 12:19:59 +0300
In-Reply-To: <20210509194509.10849-9-linus.luessing@c0d3.blue>
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
> their IPv4 and IPv6 variants split router port deletion and notificatio=
n
> into two functions. When we disable a port for instance later we want t=
o
> only send one notification to switchdev and netlink for compatibility
> and want to avoid sending one for IPv4 and one for IPv6. For that the
> split is needed.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 40 ++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 839d21b..39854d5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -60,7 +60,8 @@ static void br_ip4_multicast_leave_group(struct net_b=
ridge *br,
>  					 const unsigned char *src);
>  static void br_multicast_port_group_rexmit(struct timer_list *t);
> =20
> -static void __del_port_router(struct net_bridge_port *p);
> +static void
> +br_multicast_rport_del_notify(struct net_bridge_port *p, bool deleted)=
;
>  #if IS_ENABLED(CONFIG_IPV6)
>  static void br_ip6_multicast_leave_group(struct net_bridge *br,
>  					 struct net_bridge_port *port,
> @@ -1354,11 +1355,26 @@ static int br_ip6_multicast_add_group(struct ne=
t_bridge *br,
>  }
>  #endif
> =20
> +static bool br_multicast_rport_del(struct hlist_node *rlist)
> +{
> +	if (hlist_unhashed(rlist))
> +		return false;
> +
> +	hlist_del_init_rcu(rlist);
> +	return true;
> +}
> +
> +static inline bool br_ip4_multicast_rport_del(struct net_bridge_port *=
p)
> +{
> +	return br_multicast_rport_del(&p->ip4_rlist);
> +}
> +

Same comment about inline in .c files, either drop the inline or move it =
to br_private.h
For functions that are not critical for performance(fast-path) I'd just d=
rop the inline
in the .c files and leave them there.

>  static void br_multicast_router_expired(struct net_bridge_port *port,
>  					struct timer_list *t,
>  					struct hlist_node *rlist)
>  {
>  	struct net_bridge *br =3D port->br;
> +	bool del;
> =20
>  	spin_lock(&br->multicast_lock);
>  	if (port->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
> @@ -1366,7 +1382,8 @@ static void br_multicast_router_expired(struct ne=
t_bridge_port *port,
>  	    timer_pending(t))
>  		goto out;
> =20
> -	__del_port_router(port);
> +	del =3D br_multicast_rport_del(rlist);
> +	br_multicast_rport_del_notify(port, del);
>  out:
>  	spin_unlock(&br->multicast_lock);
>  }
> @@ -1706,19 +1723,20 @@ void br_multicast_disable_port(struct net_bridg=
e_port *port)
>  	struct net_bridge *br =3D port->br;
>  	struct net_bridge_port_group *pg;
>  	struct hlist_node *n;
> +	bool del =3D false;
> =20
>  	spin_lock(&br->multicast_lock);
>  	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
>  		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT))
>  			br_multicast_find_del_pg(br, pg);
> =20
> -	__del_port_router(port);
> -
> +	del |=3D br_ip4_multicast_rport_del(port);
>  	del_timer(&port->ip4_mc_router_timer);
>  	del_timer(&port->ip4_own_query.timer);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	del_timer(&port->ip6_own_query.timer);
>  #endif
> +	br_multicast_rport_del_notify(port, del);
>  	spin_unlock(&br->multicast_lock);
>  }
> =20
> @@ -3508,11 +3526,12 @@ int br_multicast_set_router(struct net_bridge *=
br, unsigned long val)
>  	return err;
>  }
> =20
> -static void __del_port_router(struct net_bridge_port *p)
> +static void
> +br_multicast_rport_del_notify(struct net_bridge_port *p, bool deleted)
>  {
> -	if (hlist_unhashed(&p->ip4_rlist))
> +	if (!deleted)
>  		return;
> -	hlist_del_init_rcu(&p->ip4_rlist);
> +
>  	br_rtr_notify(p->br->dev, p, RTM_DELMDB);
>  	br_port_mc_router_state_change(p, false);
> =20
> @@ -3526,6 +3545,7 @@ int br_multicast_set_port_router(struct net_bridg=
e_port *p, unsigned long val)
>  	struct net_bridge *br =3D p->br;
>  	unsigned long now =3D jiffies;
>  	int err =3D -EINVAL;
> +	bool del =3D false;
> =20
>  	spin_lock(&br->multicast_lock);
>  	if (p->multicast_router =3D=3D val) {
> @@ -3539,12 +3559,14 @@ int br_multicast_set_port_router(struct net_bri=
dge_port *p, unsigned long val)
>  	switch (val) {
>  	case MDB_RTR_TYPE_DISABLED:
>  		p->multicast_router =3D MDB_RTR_TYPE_DISABLED;
> -		__del_port_router(p);
> +		del |=3D br_ip4_multicast_rport_del(p);
>  		del_timer(&p->ip4_mc_router_timer);
> +		br_multicast_rport_del_notify(p, del);
>  		break;
>  	case MDB_RTR_TYPE_TEMP_QUERY:
>  		p->multicast_router =3D MDB_RTR_TYPE_TEMP_QUERY;
> -		__del_port_router(p);
> +		del |=3D br_ip4_multicast_rport_del(p);
> +		br_multicast_rport_del_notify(p, del);
>  		break;
>  	case MDB_RTR_TYPE_PERM:
>  		p->multicast_router =3D MDB_RTR_TYPE_PERM;
>=20
