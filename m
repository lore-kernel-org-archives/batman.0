Date: Thu, 17 Jul 2008 10:00:54 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland linux-2.6.21
	compatibility
Message-ID: <20080717080054.GA15826@hrz.tu-chemnitz.de>
References: <A2A8A9D0-44EF-4330-8AEE-4A17F741C109@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <A2A8A9D0-44EF-4330-8AEE-4A17F741C109@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Scott,

thank you for the patch, it looks good to me so i applied it. Having a
compat.h is a good idea, maybe we should use it even more to get rid of
some ugly #ifdef's. :)=20
I've tested your patch against various kernels, it seems to work until=20
2.6.20, but breaks for 2.6.19.

We welcome any kind of patches, so don't hesitate to submit. We can=20
integrate them directly (like your patch) or offer them on our homepage
(like the quagga patches [1]).

Thanks again,
	Simon


[1] http://downloads.open-mesh.net/batman/patches/quagga/



On Thu, Jul 17, 2008 at 01:34:53PM +1200, Scott Raynel wrote:
> Hi there,
>=20
> Not sure how you guys want patches submitted, so point me in the right =
=20
> direction if this is not it. Here's a simple patch that enables =20
> compilation on linux-2.6.21 (and possibly earlier, though I've tested =20
> 2.6.16 and it doesn't work).
>=20
> Cheers,
>=20
> --
> Scott Raynel
> WAND Network Research Group
> Department of Computer Science
> University of Waikato
> New Zealand
>=20
>=20


> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIfvw2rzg/fFk7axYRAoCiAJoDjaBWPu2eXPGtBQoRQAEJPXhspACgyS4c
EMnWeOwpvxZvM9mwd0f0ixQ=
=VXKu
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
