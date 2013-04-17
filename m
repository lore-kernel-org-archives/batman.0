Return-Path: <ordex@autistici.org>
Date: Wed, 17 Apr 2013 14:05:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130417120550.GD20819@ritirata.org>
References: <1366194530-9367-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <1366194530-9367-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid double freeing of
 bat_counters
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2013 at 12:28:50PM +0200, Martin Hundeb=C3=B8ll wrote:
> On errors in batadv_mesh_init(), bat_counters will be freed in both
> batadv_mesh_free() and batadv_softif_init_late(). This patch fixes this
> by returning earlier from batadv_softif_init_late() in case of errors in
> batadv_mesh_init().
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  soft-interface.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index c2a9c20..4de4d0f 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -503,6 +503,9 @@ static int batadv_softif_init_late(struct net_device =
*dev)
> =20
>  unreg_debugfs:
>  	batadv_debugfs_del_meshif(dev);
> +
> +	return ret;
> +

Hi Martin, good catch!
But using 1 goto to execute 1 operation is not very good.
What about this:


ret =3D batadv_mesh_init(dev);
if (ret < 0)
	batadv_debugfs_del_meshif(dev);

return ret;


and remove the unreg_debugfs label at all (and its content)


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRbpAeAAoJEADl0hg6qKeOzEkQALT85F/Nh0I/d90bGp+mbYIg
uZcB6pNUslGGnFkdib9vH3O+v9prfP0OyPAcYfLQPjqWdQFxi4owzXkJEcaYIfRx
HS4DjG/ZUFdXI99Qcdt7u7tpe5tPtT5B26QtV6b/e05+/dhcZ/OEhtqWWiDoSWE2
ThQOhYLZdkiquRgKkjn47GWWfHJkREo49mudWu11BN2O23hjhwXdg8SCCVq1AHR2
thhmOGP2/zFvj+tbkRMrqWEKjRkdMoYauiCsiWBeO8fYaZOc/C8etrVgRKQY8O38
dZfw3gZn4fRmqNyG21FyIu3sF2eOW8gzPajNVLAL0mqO9nMMJv7W1wnltL02HUqe
w0n/tOZ/RVJMbICtYJOZ6stL0QpydatveA1Qrtj1pR7Sdh0QiH2I/LTDBkt/f1GQ
IToUn5GkE9CYRrWW/tToh8/kvAtJ9ceHjnRQQgC9E8pvKyZKHSBFTugD8GBbiGeV
N6rZg6Jsag39254Cr0aDM79ppTaVJEok6fcy+pDy2VpAw+A0mklnxs1AGOPADULL
UxD6EMlRQOCQjrS+Wz2a4hSlxmoeBnGS4tfCKde0N4xUEtdjFVZqNr47yYgHT0XU
2/teHzhm7C1VkWlWDYa1INssoAwDwBfdyuPtnFldn9hFMDtL6E0rXP73/rRtiHbE
y+e7xqn4R/nT9JzdDL1j
=wGn/
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
