Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 5 Apr 2010 00:21:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100404222125.GA9216@pandem0nium>
References: <56afad541003221528w13e61637tbfdd0e0890181d88@mail.gmail.com>
	<20100323063231.GG15823@lunn.ch>
	<20100325230854.GA10841@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20100325230854.GA10841@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] Minor change in vis.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

thank you very much for reporting and discussing, just committed a fix
(r1617 and r1618).

best regards,
	Simon

On Fri, Mar 26, 2010 at 12:08:54AM +0100, Linus L=C3=BCssing wrote:
> > So it looks like we need a field width of 3, not 2.
> Ah, sorry forgot about the rest of the mail, sorry :). So that's
> probably what you meant, right?
> >=20
> > BTW: Is a TQ =3D=3D 0 possible? batctl does not prevent the / 0 from
> > happening.
> Hmm, no, shouldn't be possible, as in vis packets a tq-value of
> "0" is an HNA entry (and the dest-field filled with 0x000000000000)
>=20
> Cheers, Linus
> >=20
> > 	Andrew
> >=20



--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku5EOUACgkQrzg/fFk7axbHrwCdHCR6/5gEZ10mPXOQU8Ht6YqA
4iIAoMlgLmDBXRiRxm1FXKfxpEeCOTZ8
=9IJ8
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
