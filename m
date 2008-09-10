Date: Wed, 10 Sep 2008 21:38:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] BATGAT
Message-ID: <20080910193801.GA10777@pandem0nium>
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gustavo,

batman works fine without the batgat kernel module. The batgat kernel
module will only accelerate the gateway functionality, but batman can do
without it. If you don't want it, don't insmod batgat. Batman will detect it
at runtime, no need to recompile.
The gateway should still work, if it doesn't then you probably found=20
a bug.

best regards,
	Simon

On Wed, Sep 10, 2008 at 01:41:38PM -0300, Gustavo Lindberg wrote:
> Hi all !
>=20
> How to disable batgat ? It necessary recompiling batmand or is enough to
> unload batgat module ?
> I do that and batmand load but the gw never more assign ip trough the tun=
nel
> iface....
>=20
> TIA

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIyCIZrzg/fFk7axYRAmBPAJ0VqKfKf2fajACbdC5q8Vcx4OCpdwCg9Urm
XyHa09aZEEq1ghIW3LceQqM=
=Adqg
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
