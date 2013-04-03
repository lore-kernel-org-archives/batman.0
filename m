Return-Path: <ordex@autistici.org>
Date: Wed, 3 Apr 2013 11:23:59 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130403092359.GD14372@ritirata.org>
References: <1364980634-8376-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <1364980634-8376-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: change VID semantic in the
 BLA code
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2013 at 11:17:14AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> In order to make batman-adv fully vlan aware later, the
> semantic used for variables storing the VLAN ID values has
> to be changed in order to be adapted to the new one which
> will be used batman-adv wide.
>=20
> In particular, the VID has to be an "_unsigned_ short int"
> and its 4 MSB will be used as a flag bitfield, while the
> remaining 12 bits are used to store the real VID value
>=20
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

[cut..]

> diff --git a/packet.h b/packet.h
> index a51ccfc..d5464f6 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -105,6 +105,14 @@ enum batadv_tt_client_flags {
>  	BATADV_TT_CLIENT_PENDING =3D BIT(10),
>  };
> =20
> +/**
> + * batadv_vlan_flags - flags for the four MSB of any vlan ID field
> + * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or =
not
> + */
> +enum batadv_vlan_flags {
> +	BATADV_VLAN_HAS_TAG	=3D BIT(15),
> +};
> +
>  /* claim frame types for the bridge loop avoidance */
>  enum batadv_bla_claimframe {
>  	BATADV_CLAIM_TYPE_CLAIM		=3D 0x00,
> diff --git a/soft-interface.c b/soft-interface.c
> index 403b8c4..34597a2 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -154,7 +154,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  						    0x00, 0x00};
>  	unsigned int header_len =3D 0;
>  	int data_len =3D skb->len, ret;
> -	short vid __maybe_unused =3D -1;
> +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
>  	bool do_bcast =3D false;
>  	uint32_t seqno;
>  	unsigned long brd_delay =3D 1;
> @@ -303,7 +303,7 @@ void batadv_interface_rx(struct net_device *soft_ifac=
e,
>  	struct ethhdr *ethhdr;
>  	struct vlan_ethhdr *vhdr;
>  	struct batadv_header *batadv_header =3D (struct batadv_header *)skb->da=
ta;
> -	short vid __maybe_unused =3D -1;
> +	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
>  	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
>  	bool is_bcast;

I just realised that this change is going to break compatibility because we
change the menaing of the value that BLA sends over the wire.

We must postpone this change to the next (BIG) compat bump.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRW/UvAAoJEADl0hg6qKeObIMQALA76pUL+JmS8V4LI794VPHt
wSFU/Qxe/F+2Sb4l0hneNYUnR9544Q0KjxUIriooklsmgU9x2FAaZf/jAF2fUkZ4
SZYqcaAFKR53fo19qqSIQiMqlksekWL9gUAcIzd34KKcN2H7dznBorMzEBwyDK/a
Gn+XSEN4qMoHPJTApLAVELZGY1YUWQF1wGIa/4K3ARZgfhCPHhWvJvmcUryO/eah
3L5uaKuqB1GP1TpcScoUPlSn1zQyQZzywPiARRtKCwV+ugYxTFlQDb3qQe4eV0YG
4xA4BfbivwpOI5Ukq5WqmmY6LSg4LD7XqfpvaCMiCEylcbR7jFiJn3qfcEeQ5Mz6
1J28KF1dyf7plfpWs5Y0bnWfQvdZyxwsvo3txieLUjgKsnrhO4XoFuPprdZSgG38
d8TluPo6jT7vEytlAs9TsYy2zRy0JAtDQqlWpdrPxCaoxXmVsTAZvkF5zxxq7wcW
JVsQ3nPqzKTtsvEvPiLtlZXnt75rOv5Ov87PoUAQWcuwZZzafmWXtwJZiWalWPTk
WX19NkeBnP373bFVQ0+N+aKvoBQfR4Uvu1G2icJMDcyZI6XL35aHg40PiJld5Z43
9B7+QYqusziyZMsady4C2Oda90e/qK/Hp4b9TXxq5P1Ux6ihF61jR9jEL+QV+AQL
WoJphj1KBmv0sDn96z9I
=kXs1
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
