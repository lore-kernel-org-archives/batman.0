Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: [net-next v2 05/11] net: bridge: mcast: prepare is-router
 function for mcast router split
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-6-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <6a7f2310-3b15-2a60-803b-6a9abafe5612@nvidia.com>
Date: Tue, 11 May 2021 12:16:16 +0300
In-Reply-To: <20210509194509.10849-6-linus.luessing@c0d3.blue>
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
> their IPv4 and IPv6 variants make br_multicast_is_router() protocol
> family aware.
>=20
> Note that for now br_ip6_multicast_is_router() uses the currently still
> common ip4_mc_router_timer for now. It will be renamed to
> ip6_mc_router_timer later when the split is performed.
>=20
> While at it also renames the "1" and "2" constants in
> br_multicast_is_router() to the MDB_RTR_TYPE_TEMP_QUERY and
> MDB_RTR_TYPE_PERM enums.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_input.c     |  2 +-
>  net/bridge/br_multicast.c |  5 +++--
>  net/bridge/br_private.h   | 36 ++++++++++++++++++++++++++++++++----
>  3 files changed, 36 insertions(+), 7 deletions(-)
>=20

Minor comment below, but either way:
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 8875e95..1f50630 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -132,7 +132,7 @@ int br_handle_frame_finish(struct net *net, struct =
sock *sk, struct sk_buff *skb
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>  		    br_multicast_querier_exists(br, eth_hdr(skb), mdst)) {
>  			if ((mdst && mdst->host_joined) ||
> -			    br_multicast_is_router(br)) {
> +			    br_multicast_is_router(br, skb)) {
>  				local_rcv =3D true;
>  				br->dev->stats.multicast++;
>  			}
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 7edbbc9..048b5b9 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1391,7 +1391,8 @@ static void br_multicast_local_router_expired(str=
uct timer_list *t)
>  	spin_lock(&br->multicast_lock);
>  	if (br->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
>  	    br->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
> -	    timer_pending(&br->ip4_mc_router_timer))
> +	    br_ip4_multicast_is_router(br) ||
> +	    br_ip6_multicast_is_router(br))
>  		goto out;
> =20
>  	br_mc_router_state_change(br, false);
> @@ -3622,7 +3623,7 @@ bool br_multicast_router(const struct net_device =
*dev)
>  	bool is_router;
> =20
>  	spin_lock_bh(&br->multicast_lock);
> -	is_router =3D br_multicast_is_router(br);
> +	is_router =3D br_multicast_is_router(br, NULL);
>  	spin_unlock_bh(&br->multicast_lock);
>  	return is_router;
>  }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 26e91d2..ac5ca5b 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -864,11 +864,39 @@ static inline bool br_group_is_l2(const struct br=
_ip *group)
>  #define mlock_dereference(X, br) \
>  	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
> =20
> -static inline bool br_multicast_is_router(struct net_bridge *br)
> +static inline bool br_ip4_multicast_is_router(struct net_bridge *br)
>  {
> -	return br->multicast_router =3D=3D 2 ||
> -	       (br->multicast_router =3D=3D 1 &&
> -		timer_pending(&br->ip4_mc_router_timer));
> +	return timer_pending(&br->ip4_mc_router_timer);
> +}
> +
> +static inline bool br_ip6_multicast_is_router(struct net_bridge *br)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	return timer_pending(&br->ip4_mc_router_timer);
> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline bool
> +br_multicast_is_router(struct net_bridge *br, struct sk_buff *skb)
> +{
> +	if (br->multicast_router =3D=3D MDB_RTR_TYPE_PERM)
> +		return true;
> +
> +	if (br->multicast_router =3D=3D MDB_RTR_TYPE_TEMP_QUERY) {
> +		if (skb) {
> +			if (skb->protocol =3D=3D htons(ETH_P_IP))
> +				return br_ip4_multicast_is_router(br);
> +			else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
> +				return br_ip6_multicast_is_router(br);
> +		} else {
> +			return br_ip4_multicast_is_router(br) ||
> +			       br_ip6_multicast_is_router(br);
> +		}
> +	}

Personally I'd prefer using a switch statement for br->multicast_router.

> +
> +	return false;
>  }
> =20
>  static inline bool
>=20
