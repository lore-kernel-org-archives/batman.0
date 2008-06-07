Date: Sat, 7 Jun 2008 22:39:49 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
Message-ID: <20080607203948.GA21781@hrz.tu-chemnitz.de>
References: <4846B27B.9020907@csp.it>
	<200806041811.38881.sven.eckelmann@gmx.de>
	<200806051038.19094.lindner_marek@yahoo.de>
	<4847F23D.6010903@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Paolo,

thanks again for your testing. I've tried a few old revisions=20
and could reproduce the "ping of death" problem in Svens 2.6.22=20
enviroment. Even Revision 1024, which worked flawlessly before in my UML,=
=20
on Accton routers and other devices in various setups, showed this problem.=
=20
:(

So there seems to be some hard to catch issue and i haven't found the bug
yet (two others instead ;), but i'm working on it.=20

For the time being you may try your luck with revision 1024, maybe it
works for you. It also has some bugs, but worked out in some scenarios
i set up.

Thanks again
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

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFISvIUrzg/fFk7axYRAifXAJ9qUvnhD/EQ3G1UIf+AnpTLyTyHcgCg6eha
+1X3La0wH4e18Wrp56IPKj4=
=c+E9
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
