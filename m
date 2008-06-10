Date: Tue, 10 Jun 2008 11:16:30 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
Message-ID: <20080610091630.GA4497@hrz.tu-chemnitz.de>
References: <4846B27B.9020907@csp.it>
	<200806041811.38881.sven.eckelmann@gmx.de>
	<200806051038.19094.lindner_marek@yahoo.de>
	<4847F23D.6010903@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <4847F23D.6010903@csp.it>
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
To: cipollone@csp.it, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paolo,=20

please give it another try (rev1078). I fixed some bugs and it works now (a=
t least
in my enviroment ...).=20

Regards
	Simon


On Thu, Jun 05, 2008 at 04:03:41PM +0200, cipollone wrote:
> Hi,
>=20
> I've tested B.A.T.M.A.N. Advanced Kernel Land version 6 with a different=
=20
> Linux OpenWRT Kernel Version. I've used the # 2.6.24.2 and , also in=20
> this case, I can't ping the other pc with the same kernel version.
>=20
> Now, with kernel version 2.6.25.4, 2.6.22.2 and 2.6.24.2, Batman doesn't=
=20
> send packets. I think there is a problem passing in layer 3 because if I=
=20
> ping itself it answer at the request ( it is because it doesn't go in=20
> the layer 3, but stay at layer 2 with ARP).
>=20
> I'm reading the log message in order to understand what's the problem=20
> and where is.
>=20
> Now I have also putted vde switch in hub mode.
>=20
> Regards
>=20
> Paolo
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFITkZurzg/fFk7axYRApzlAJ9grP3jGw56z2kQ88f4A/wzEGU11gCgxWMN
ZJpCt+dxAGlt4+j8cuu4hOo=
=VFY4
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
