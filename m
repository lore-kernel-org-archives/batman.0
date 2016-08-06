Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 20:27:16 +0200
Message-ID: <4452998.RYI5TAmmpm@sven-edge>
In-Reply-To: <1470449181-11917-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470449181-11917-1-git-send-email-linus.luessing@c0d3.blue>
 <1470449181-11917-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2261973.QoliA8VCAl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: Simple (re)broadcast
	avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2261973.QoliA8VCAl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 04:06:21 CEST Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interf=
ace.c
> index 08ce361..56529b3 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -228,6 +228,58 @@ bool batadv_is_wifi_netdev(struct net_device *net_de=
vice)
>  	return false;
>  }
> =20
> +/**
> + * batadv_hardif_no_broadcast - check whether (re)broadcast is necessary
> + * @if_outgoing:

I think you forgot to add text here

[...]
> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index 5f3bfc4..890d07d 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
> @@ -517,7 +517,8 @@ batadv_neigh_node_get(const struct batadv_orig_node *=
orig_node,
>   */
>  static struct batadv_hardif_neigh_node *
>  batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> -			   const u8 *neigh_addr)
> +			   const u8 *neigh_addr,
> +			   struct batadv_orig_node *orig_node)

orig_node seems to be missing from kernel-doc

[...]
> @@ -561,7 +563,8 @@ out:
>   */
>  static struct batadv_hardif_neigh_node *
>  batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
> -				  const u8 *neigh_addr)
> +				  const u8 *neigh_addr,
> +				  struct batadv_orig_node *orig_node)

orig_node seems to be missing from kernel-doc

[...]
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 610f2c4..c1e5aa7 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -1142,6 +1142,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>  		goto out;
> =20
>  	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
> +	skb_set_inner_mac_header(skb, sizeof(struct batadv_bcast_packet));

skb_set_inner_mac_header doesn't seem to be defined in 3.9 (first defined i=
n=20
aefbd2b3c2a9c657605e4337f9919d6c6273e8e6). Any idea how to fix build/
functionality for these kernels?

[...]
> @@ -634,6 +641,51 @@ static void batadv_send_outstanding_bcast_packet(str=
uct work_struct *work)
>  		if (forw_packet->num_packets >=3D hard_iface->num_bcasts)
>  			continue;
> =20
> +		/* hint for own origin -> no neigh_node */
> +		if (skb_mac_header(forw_packet->skb) =3D=3D
> +		    skb_inner_mac_header(forw_packet->skb)) {

skb_inner_mac_header doesn't seem to be defined in 3.9 (first defined in=20
aefbd2b3c2a9c657605e4337f9919d6c6273e8e6). Any idea how to fix build/
functionality for these kernels?


Kind regards,
	Sven
--nextPart2261973.QoliA8VCAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpiwEAAoJEF2HCgfBJntGA1UP/A3nFJC2ywC5JAIRjQf9hW0Y
jWlpYYKGK9CTr4GXTb4WKDgpJwFoEBbWQ7ASHXLzQ1ou19axMEoQ8CR1YmHndcsH
P1W/SjXNirZ9JmR3vPz103RxwokvZWa3JqA1Sf7nxIt9mFy9VdfWZko+I4qj/LIV
TQLHP0oZTBTkErW2HhAC/0snoAytpVdifSrw50oUmG/c8P1XuVY39hTG3bGrnP/+
khLLoJ9IGYowtAifFsrn+L4M+sh6SZrHznW4FNlfhRTe+Qzghnr5QEeXaCVgP4F/
6+3oqcyz8c3mklcVeMVgAJy6BK0VdmVK9YFxtLY3zsN6LBEmqxD+F7Ar41Vp/W6z
PHm3n+DPgyxyBLZOObV95KA1OkGvwCZTNT9SzksFKG4pxDNHmdl513/RKniVj09l
IUyEkYU5hWz980Jt4X4YuRD9/h1YovbQlMCIdfulUpjmip8/F4zkgBG8O2Hmy3TJ
dwhaupz7gfXggHd/7k/xSLmpuqdTaNf+JWVwglRHuKzH5Z+fGA/4sBIcDIeXidIu
C7LZ2+FHESYNkHHKMBxK3dmtTf5mKPRhgwTNO6XOCcL3m50tmN76v1keKm3k5Jv+
AzdF+/jlClnUzBrfut4Y6/gLlDpkMEj2oLij6uWfv8hka7xf6+YBcfEY9soB/y3y
ovro4CcCALHalCoEeKjl
=TyXs
-----END PGP SIGNATURE-----

--nextPart2261973.QoliA8VCAl--

