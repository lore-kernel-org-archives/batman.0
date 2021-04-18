Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sun, 18 Apr 2021 22:16:07 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [RFC PATCH] batman-adv: convert ifmcaddr6 to RCU
Message-ID: <20210418201607.GA8165@otheros>
References: <20210418201422.8415-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210418201422.8415-1-linus.luessing@c0d3.blue>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Apr 18, 2021 at 10:14:22PM +0200, Linus L=C3=BCssing wrote:
> [...]
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 28166402..1d63c8cb 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -454,8 +454,9 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device =
*dev,
>  		return 0;
>  	}
> =20
> -	read_lock_bh(&in6_dev->lock);
> -	for (pmc6 =3D in6_dev->mc_list; pmc6; pmc6 =3D pmc6->next) {
> +	for (pmc6 =3D rcu_dereference(in6_dev->mc_list);
> +	     pmc6;
> +	     pmc6 =3D rcu_dereference(pmc6->next)) {
>  		if (IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) <
>  		    IPV6_ADDR_SCOPE_LINKLOCAL)
>  			continue;
> @@ -484,7 +485,6 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device =
*dev,
>  		hlist_add_head(&new->list, mcast_list);
>  		ret++;
>  	}
> -	read_unlock_bh(&in6_dev->lock);
>  	rcu_read_unlock();
> =20
>  	return ret;
> --=20

Ups, accidentally added this. Will remove that in the next
version.
