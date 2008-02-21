Date: Thu, 21 Feb 2008 11:59:34 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] simple question
Message-ID: <20080221105933.GA28785@hrz.tu-chemnitz.de>
References: <47BCCAA9.7090601@toyota-ti.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <47BCCAA9.7090601@toyota-ti.ac.jp>
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Giuseppe,

Yes, multiple radio interfaces are well supported. Just add all the
interfaces as commandline parameters, e.g.

batmand wlan0 wlan1 wlan2 ... wlanX

Best regards,
	Simon

On Thu, Feb 21, 2008 at 09:49:45AM +0900, giuseppe de marco wrote:
> Does Batman run also on embedded devices with multiple interfaces?
> I mean: every link has one radio interface, but evey node can have=20
> multiple radio interface.
> That is, link are orthogonal in frequency.
> G
>=20
> --=20
> Giuseppe De Marco, PhD
> Toyota Technological Institute
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHvVmVrzg/fFk7axYRAhR6AJ9dI1JbLZ/v3Xsv+AYYcRm7AHXcgQCg3nSc
OCq1A+EVV7BygIwdQl6YCD4=
=c7NH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
