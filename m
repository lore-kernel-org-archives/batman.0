Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 11 Sep 2013 23:28:02 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130911212801.GA25911@pandem0nium>
References: <1378919684-374-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1378919684-374-1-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: set the TAG flag for
 the vid passed to BLA
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
Cc: Antonio Quartulli <antonio@open-mesh.org>, Antonio Quartulli <antonio@open-mesh.com>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks good - thanks for fixing that.

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wed, Sep 11, 2013 at 07:14:44PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> When receiving or sending a packet a packet on a VLAN, the
> vid has to be marked with the TAG flag in order to make any
> component in batman-adv understand that the packet is coming
> from a really tagged network.
>=20
> This fix the Bridge Loop Avoidance behaviour which was not
> able to send announces over VLAN interfaces.
>=20
> Introduced by 0b1da1765fdb00ca5d53bc95c9abc70dfc9aae5b
> ("batman-adv: change VID semantic in the BLA code")
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.org>
> ---
>  soft-interface.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index 0f04e1c..33b6144 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -168,6 +168,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  	case ETH_P_8021Q:
>  		vhdr =3D (struct vlan_ethhdr *)skb->data;
>  		vid =3D ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> +		vid |=3D BATADV_VLAN_HAS_TAG;
> =20
>  		if (vhdr->h_vlan_encapsulated_proto !=3D ethertype)
>  			break;
> @@ -329,6 +330,7 @@ void batadv_interface_rx(struct net_device *soft_ifac=
e,
>  	case ETH_P_8021Q:
>  		vhdr =3D (struct vlan_ethhdr *)skb->data;
>  		vid =3D ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> +		vid |=3D BATADV_VLAN_HAS_TAG;
> =20
>  		if (vhdr->h_vlan_encapsulated_proto !=3D ethertype)
>  			break;
> --=20
> 1.8.1.5
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIw4GEACgkQrzg/fFk7axZqAQCgpwK2tVX0o3HgAKuIPPzbQOwl
LaQAn2HtF3JbfWp7VKh/7dSMwGjSMAOs
=yhGu
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
