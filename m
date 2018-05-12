Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 May 2018 06:26:05 +0800
Message-ID: <8297905.x1mjbtJKAa@lafayette>
In-Reply-To: <20180507013823.739-2-linus.luessing@c0d3.blue>
References: <20180507013823.739-1-linus.luessing@c0d3.blue>
 <20180507013823.739-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1671474.3FgFobYie0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart1671474.3FgFobYie0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, May 7, 2018 9:38:22 AM HKT Linus L=FCssing wrote:
>  include/uapi/linux/batadv_packet.h     |  48 ++++++
>  net/batman-adv/distributed-arp-table.c | 296
> +++++++++++++++++++++++++++++++++ net/batman-adv/distributed-arp-table.h =
|=20
> 11 ++
>  net/batman-adv/soft-interface.c        |  11 +-
>  4 files changed, 364 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/batadv_packet.h
> b/include/uapi/linux/batadv_packet.h index 894d8d2f..7ef7b519 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -630,6 +630,54 @@ struct batadv_tvlv_mcast_data {
>         __u8 reserved[3];
>  };
>=20
> +enum batadv_bootpop {
> +       BATADV_BOOTREQUEST      =3D 1,
> +       BATADV_BOOTREPLY        =3D 2,
> +};
> +
> +enum batadv_boothtype {
> +       BATADV_HTYPE_ETHERNET   =3D 1,
> +};
> +
> +enum batadv_dhcpoptioncode {
> +       BATADV_DHCP_OPT_PAD             =3D 0,
> +       BATADV_DHCP_OPT_MSG_TYPE        =3D 53,
> +       BATADV_DHCP_OPT_END             =3D 255,
> +};
> +
> +enum batadv_dhcptype {
> +       BATADV_DHCPDISCOVER     =3D 1,
> +       BATADV_DHCPOFFER        =3D 2,
> +       BATADV_DHCPREQUEST      =3D 3,
> +       BATADV_DHCPDECLINE      =3D 4,
> +       BATADV_DHCPACK          =3D 5,
> +       BATADV_DHCPNAK          =3D 6,
> +       BATADV_DHCPRELEASE      =3D 7,
> +       BATADV_DHCPINFORM       =3D 8,
> +};

Can we shorten these definitions by only listing those that are used by the=
=20
code below ?


> @@ -1130,6 +1133,7 @@ batadv_dat_arp_create_reply(struct batadv_priv
> *bat_priv, __be32 ip_src, return NULL;
>=20
>         skb_reset_mac_header(skb);
> +       skb_set_network_header(skb, ETH_HLEN);
>=20
>         if (vid & BATADV_VLAN_HAS_TAG)
>                 skb =3D vlan_insert_tag(skb, htons(ETH_P_8021Q),

Might be better to move the skb_set_network_header() call into=20
batadv_dat_put_pairs() where it is needed by skb_network_offset() ?

Cheers,
Marek
--nextPart1671474.3FgFobYie0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlr3af0ACgkQU1VOj+62
HMBaVAgAkWfwkpRBuvQzpCgKQMjiQGg1g/Rg7PdeZn1jjdE1xBrf+RJftsaoGEcy
BCkTcLeOvPsiPkJhEwQKMw4u6UrGlbe3pOX6R/ZSXAxNPoVIFQQ0DGVYqlZMZMwc
o17qFh0yp8uV8Do7XQEjEcOaDk2gs2IznGcCaHkbDvEJuHP4QNnppt5Eg9sDcE58
uNnvzEb7Q2PnMEbFMn2mVWIdi9Qmrh/xK1nQ6gUT7a2Bz+eOnt1qeThptUd/n3ec
NM0D07Me17zvqCwrNOGYd5uIieQkhr4dU29c06AdnLjQuqPfXAfb/O6IP6Z/Qs0B
GZ2T8cIR2J7LV6P7t1dSS+m4ZAqevw==
=zCQA
-----END PGP SIGNATURE-----

--nextPart1671474.3FgFobYie0--



