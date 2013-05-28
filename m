Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 28 May 2013 17:40:54 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130528154054.GC14466@pandem0nium>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <1369382549-8787-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <1369382549-8787-4-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Only a few style suggestions here, nothing critical and you can ignore
them if you don't like them. :)

On Fri, May 24, 2013 at 10:02:28AM +0200, Linus L=C3=BCssing wrote:
> With this patch a multicast packet is not always simply flooded anymore,
> the bevahiour for the following cases is changed to reduce
> unnecessary overhead:
>=20
> If all nodes within the horizon of a certain node have signalized
> multicast listener announcement capability
> (BATADV_MCAST_LISTENER_ANNOUNCEMENT) then an IPv6 multicast packet
> with a destination of IPv6 link-local scope coming from the upstream
> of this node...
>=20
> * ...is dropped if there is no according multicast listener in the
>   translation table,
> * ...is forwarded via unicast if there is a single node with interested
>   multicast listeners
> * ...and otherwise still gets flooded.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  multicast.c         |   43 +++++++++++++++++++++++++++++++++
>  multicast.h         |    8 +++++++
>  soft-interface.c    |   10 ++++++++
>  translation-table.c |   66 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  translation-table.h |    1 +
>  5 files changed, 128 insertions(+)
>=20
> diff --git a/multicast.c b/multicast.c
> index 36e4c59..bd55c8f 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -213,6 +213,49 @@ out:
>  }
> =20
>  /**
> + * batadv_mcast_flood - check on how to forward a multicast packet
> + * @skb: The multicast packet to check
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Return 1 if the packet should be flooded, 0 if it should be forwarded
> + * via unicast or -1 if it should be drooped.
> + */
> +int batadv_mcast_flood(struct sk_buff *skb, struct batadv_priv *bat_priv)
> +{
> +	struct ethhdr *ethhdr =3D (struct ethhdr *)(skb->data);
> +	struct ipv6hdr *ip6hdr;
> +	int count, ret =3D 1;
> +
> +	if (atomic_read(&bat_priv->mcast_group_awareness) &&
> +	    !atomic_read(&bat_priv->mcast.num_non_aware) &&
> +	    ntohs(ethhdr->h_proto) =3D=3D ETH_P_IPV6) {

You can safe an indendation below if you return -1 immediately here
if the statement above is false. Also multiple statements might be better
for readability and later changes, e.g.

if (!atomic_read(&bat_priv->mcast_group_awareness))
	return 1;

if (atomic_read(&bat_priv->mcast.num_non_aware))
	return 1;

if (ntohs(ethhdr->h_proto) !=3D ETH_P_IPV6)
	return 1;

> +		if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr))) {
> +			ret =3D -1;
> +			goto out;
> +		}

You could directly return -1 here, the out label is not needed
(as we don't unlock/free anything here).

I don't quite understand why you return -1, maybe the packet could still
be forwarded even if it could not be pulled?

> +
> +		ip6hdr =3D ipv6_hdr(skb);
> +
> +		/* TODO: Implement Multicast Router Discovery, then add
> +		 * scope >=3D IPV6_ADDR_SCOPE_LINKLOCAL, too
> +		 */
> +		if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=3D
> +		    IPV6_ADDR_SCOPE_LINKLOCAL)
> +			goto out;
> +
> +		count =3D batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest);
> +
> +		if (!count)
> +			ret =3D -1;
> +		else if (count =3D=3D 1)
> +			ret =3D 0;
> +	}

You could use a switch statement here instead for readability, e.g.:

switch (count) {
case 0:=20
	return -1;
case 1:
	return 0;
default:
	return 1;
}
> +
> +out:
> +	return ret;
> +}
> +
> +/**
>   * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv co=
ntainer
>   * @bat_priv: the bat priv with all the soft interface information
>   * @orig: the orig_node of the ogm
> diff --git a/soft-interface.c b/soft-interface.c
> index 8bdd649..83e4679 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -36,6 +36,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/if_ether.h>
>  #include "unicast.h"
> +#include "multicast.h"
>  #include "bridge_loop_avoidance.h"
>  #include "network-coding.h"
> =20
> @@ -222,6 +223,15 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  		}
>  	}
> =20
> +	if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {

I'd suggest to put this inside the "is_multicast_etheraddr()" above to make=
 more clear
that this handles multicast packets. I was a little confused by the
do_bcast && !is_broadcast_ether_addr() first, but that might just be me.

Cheers,
	Simon

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGk0AYACgkQrzg/fFk7axZ2owCfUjL0qyNylNDwHv0ZAjSXECPv
rtIAn0ZGyRRveq9DjK78PqSZ+FTPDB1+
=43tC
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
