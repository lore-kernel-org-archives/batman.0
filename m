Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 3 Oct 2013 16:21:16 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131003142116.GC3588@pandem0nium>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
 <20131002131915.GB24077@pandem0nium>
 <2038458.nCDZnQrXiI@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <2038458.nCDZnQrXiI@sven-desktop>
Subject: Re: [B.A.T.M.A.N.] [PATCHv1] alfred: Add support for passing
 location information over alfred.
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
To: Sven Eckelmann <sven@narfation.org>
Cc: "Janne.Paatero@ruag.com" <Janne.Paatero@ruag.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2013 at 06:34:15PM +0200, Sven Eckelmann wrote:
> On Wednesday 02 October 2013 06:19:15 Simon Wunderlich wrote:
> > > +# alfred build
> > > +BINARY_NAME =3D alfred-gpsd
> > > +OBJ =3D alfred-gpsd.o
> > > +
> > > +# alfred flags and options
> > > +CFLAGS +=3D -pedantic -Wall -W -std=3Dgnu99 -fno-strict-aliasing -MD=
 -MP
> > > +LDLIBS +=3D -lgps
> >=20
> > I have no idea if we need some special handling for this to let it work
> > for crosscompiling, OpenWRT etc?
>=20
> Please use pkg-config for things like this. An example Makefile is attach=
ed.
>=20
> @Simon: Please fix your e-mail adress inside the README file.

Done, applied in 9021511.

Thanks for pointing that out.
	Simon

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJNfVwACgkQrzg/fFk7axaPugCfTNm5rb1q8SaYbgw+oILG0FBx
0BkAmwZoCYz2f+5GmP4RrZgeZdt0qCMQ
=46WK
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
