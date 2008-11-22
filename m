Date: Sat, 22 Nov 2008 16:23:50 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] gateX interfaces
Message-ID: <20081122152350.GA17369@pandem0nium>
References: <60530.149.5.32.200.1227364065.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <60530.149.5.32.200.1227364065.squirrel@www.rivertowermail.com>
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


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sat, Nov 22, 2008 at 02:27:45PM -0000, Derek C wrote:
> Hi,
>=20
> Currently I'm constantly killing batmand and starting it up again
> (different debugging levels, etc).
>=20
> Sometimes I end up with a 2nd gate tunnel (so I'd have a gate0 and a gate=
1).
>=20
> I understand (guess?) that it's because I do kill -9 and don't give
> batmand a chance to clean up.

Yep, you're probably too fast for the kernel to clean up. With kill -9
you don't give batman the chance to clean it up. Shouldn't a normal
"terminate" (without -9) be enough? We catch this signal, clean up and
exit properly in this case.
>=20
> Normally is it true that there would only ever be one tunnel (gate0) ?
Yup, only one.
>=20
> when multiple nodes are deployed is this still always the case?
Multiple nodes is no problem (multiple gateways).

The only way to have multiple gateX is to start multiple different
batman (which is not possible under normal conditions), or killing/restarti=
ng
it too fast. :)

regards,
	Simon

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJKCQGrzg/fFk7axYRAsg0AKDoz6VeiwGwKUnZNUA4kPCI5hMXVgCgm0UW
wxEv8VnHpYWiImV0NJDMTvA=
=GN3T
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
