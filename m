Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 11 Sep 2010 11:26:37 +0200
References: <20100910184706.151a6728@rechenknecht>
	<1284137300-26277-1-git-send-email-an.langer@gmx.de>
In-Reply-To: <1284137300-26277-1-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1454510.ETycRFQ2Bp";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009111126.38504.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: layer2 unicast packet
	fragmentation enhancements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1454510.ETycRFQ2Bp
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andreas Langer wrote:
> things that changed since the last patch:
> - add support to fragment packets on every node,
>   if outgoing iface mtu is smaller as the packet
> - add support to defragment packets on every node,
>   if outgoing iface mtu is >=3D original size
> - rename some functions

Is it possible to split the patch in those parts? It would make it easier t=
o=20
read it and understand the patches later.

I haven't checked the patch in detail, but scrolled over it a little bit.

Andreas Langer wrote:
> This patch improves the fragmentation by also fragmenting
> packets that came in via an interface which does not need
> fragmentation. In addition it reassembles fragmented packets
> as soon as the interface MTU allows it.
>=20
> Signed-off-by: Andreas Langer <an.langer at gmx.de>
> ---
>  batman-adv/routing.c |   64 +++++++++---------------
>  batman-adv/unicast.c |  130
> +++++++++++++++++++++++++++++++++----------------- batman-adv/unicast.h |=
=20
>  13 ++----
>  3 files changed, 114 insertions(+), 93 deletions(-)
>=20
> diff --git a/batman-adv/routing.c b/batman-adv/routing.c
> index a2c64a4..e975452 100644
> --- a/batman-adv/routing.c
> +++ b/batman-adv/routing.c
> @@ -1142,15 +1142,11 @@ static int route_unicast_packet(struct sk_buff
> *skb, unsigned long flags;
>  	struct unicast_packet *unicast_packet;
>  	struct ethhdr *ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> +	int hdr_lenght =3D sizeof(struct unicast_packet),
> +	    uni_diff =3D sizeof(struct unicast_frag_packet) - hdr_lenght;
>=20

Could you change lenght to length?

>  	unicast_packet =3D (struct unicast_packet *)skb->data;
>=20
> -	/* packet for me */
> -	if (is_my_mac(unicast_packet->dest)) {
> -		interface_rx(recv_if->soft_iface, skb, hdr_size);
> -		return NET_RX_SUCCESS;
> -	}
> -

There are different parts of the patch which makes ma a little bit curious =
=2D=20
for example: why it is possible to drop that check entirely? Could that be =
an=20
extra patch with an explanation why that can be dropped? Is it only valid i=
n=20
context of the new fragmentation handling? ...

[...]
> -static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv
> *bat_priv, -			  struct batman_if *batman_if, uint8_t dstaddr[],
> -			  struct orig_node *orig_node)
> +/* if matching fragment found return reassembled skb
> +   otherwise buffer the fragment */

Could you change the first three spaces to a " * ". Otherwise checkpatch.pl=
 is=20
unhappy again.

thanks,
	Sven

--nextPart1454510.ETycRFQ2Bp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMi0tNAAoJEF2HCgfBJntGP8IQAMitQNoBJpXmI/PiPFYpbX3P
UIEm/a9uTpBBUJkJ0WzUZ1NS8M5OPr6HDHss1BVCI+/+0oFl6OBfXyoo/rN/4JIW
wwUtwTBpWTNML7Q0S3qVvtnRW0f/CzOYr7mdigTNFm2qtPwkIZUgqqUtMShTBvVS
rBxE9nSAXDen9s+m/ICAIV1fkFjsgeSMwXeI/Nshn9bTWRsmbbpUv/NpdhrLmQbM
NDLhrseXvFm0xatIO0aZUZbRFgIYGsuQe1Ocf2SjQFEq0JbGaIegbtZaIZqMsMJQ
c3d3NzW0vPE8VJuC8Nkn+yDjKSd7GQhiprVpF+fsOSB1ut9w1t3o1qZ1LX3EMlP1
KQYeCIsudELMwFWO7QqTv2ZZvfj1567EcRBp548w3sO6lRJtP0k2TyhKfpUA8hNN
kzkbR36E0lcZ3OiB6bTu1Grbvx+XqPSfPTjwUHQe5Z9mFV25kmIfLLlRFFfG2+BP
OIu4n84VUeeW8shjrSVGrNmo3huXqgdqq5Pgo/nljrcOtEMqh4auU/AUSLnwROWJ
BRstLqW+MC0JA3j2acHISylIGgFAs4RJaEXGXtz1gi6KWGgkU+V5c94knLhGFkGI
EEw+RUxTqSy++FMfkajbq4l8fZL+4F0fSzMQL5qA/R4JCD1So8CgbI/Snq7EXxb4
hXCAY9GjRmvfIuFoFmgv
=YjKY
-----END PGP SIGNATURE-----

--nextPart1454510.ETycRFQ2Bp--
