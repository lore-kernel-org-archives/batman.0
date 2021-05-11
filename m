Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 02/11] net: bridge: mcast: add wrappers for router
 node retrieval
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-3-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <971325eb-b0e9-d1a8-b7a1-b8a2b30fc267@nvidia.com>
Date: Tue, 11 May 2021 12:12:35 +0300
In-Reply-To: <20210509194509.10849-3-linus.luessing@c0d3.blue>
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
> their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
> two wrapper functions for router node retrieval in the payload
> forwarding code.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_forward.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 3b67184..b5ec4f9 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -264,6 +264,16 @@ static void maybe_deliver_addr(struct net_bridge_p=
ort *p, struct sk_buff *skb,
>  	__br_forward(p, skb, local_orig);
>  }
> =20
> +static inline struct hlist_node *
> +br_multicast_get_first_rport_node(struct net_bridge *b, struct sk_buff=
 *skb) {
> +	return rcu_dereference(hlist_first_rcu(&b->ip4_mc_router_list));
> +}
> +
> +static inline struct net_bridge_port *
> +br_multicast_rport_from_node(struct hlist_node *rp, struct sk_buff *sk=
b) {
> +	return hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
> +}
> +

Inline functions in .c files are not allowed, please move these to br_pri=
vate.h

>  /* called with rcu_read_lock */
>  void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  			struct sk_buff *skb,
> @@ -276,7 +286,8 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
>  	bool allow_mode_include =3D true;
>  	struct hlist_node *rp;
> =20
> -	rp =3D rcu_dereference(hlist_first_rcu(&br->router_list));
> +	rp =3D br_multicast_get_first_rport_node(br, skb);
> +
>  	if (mdst) {
>  		p =3D rcu_dereference(mdst->ports);
>  		if (br_multicast_should_handle_mode(br, mdst->addr.proto) &&
> @@ -290,7 +301,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
>  		struct net_bridge_port *port, *lport, *rport;
> =20
>  		lport =3D p ? p->key.port : NULL;
> -		rport =3D hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
> +		rport =3D br_multicast_rport_from_node(rp, skb);
> =20
>  		if ((unsigned long)lport > (unsigned long)rport) {
>  			port =3D lport;
>=20
