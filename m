Return-Path: <linus.luessing@web.de>
Date: Fri, 26 Mar 2010 00:08:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100325230854.GA10841@Linus-Debian>
References: <56afad541003221528w13e61637tbfdd0e0890181d88@mail.gmail.com>
	<20100323063231.GG15823@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20100323063231.GG15823@lunn.ch>
Sender: linus.luessing@web.de
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


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> So it looks like we need a field width of 3, not 2.
Ah, sorry forgot about the rest of the mail, sorry :). So that's
probably what you meant, right?
>=20
> BTW: Is a TQ =3D=3D 0 possible? batctl does not prevent the / 0 from
> happening.
Hmm, no, shouldn't be possible, as in vis packets a tq-value of
"0" is an HNA entry (and the dest-field filled with 0x000000000000)

Cheers, Linus
>=20
> 	Andrew
>=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLq+0GAAoJEBKw7u43QNpf9DUQAIwVJlJQRxegsB5btfUVbdcJ
IO559eOaY4Nm7qrwiTspcA/M2yGlHXAv2+O8W6pZL5VhE57rdjPf6rNDs/yifpEy
8XW5l+M/QCuMAOHUHpp2+4F1jE1wILNe3W7IisL7W5Z1rD/nt0Slek3TosauoIZ/
6VoUxxBX+47QhOMS2IvhCsO4TzEZTvLR3RCkqklCQdfhHM8U7Q2XPMrRwnwyOT6W
oYizbpIWbyojzW5KCMciY9r/tQtORL1OwRzPWmIB7vWf4JTJD19H47YcuxyHebER
6edmeo1Klqfp/fCAZ7Tvl/ezfqHqOcx2a9+D7PmD5IQo9+zsWQd9d9ZGEJ8OHJve
CDHiVcAFsW1orQBRe9huMunpk3g6JtmkainXC5Rqhk/TjkMBCAE9jH+XwEcd+kh7
snesiELA9FMNAxBwzX9/IRoXNx+WOy1nqccUaZqYV13sLHLBkp5nj/EBiuoudl98
Y8WvHCJ8pe4W47Sxq1hqJKstDYoH0UCXQmUPSwFisVmkNRSrcP8CX3j9DEC365JG
A5fFwvlPf4m62XnQQKFimsAkMWjAAoxf9sOOabWadSzoVZiwMHFPI9hauk5IescZ
8niHKghl15+hFtD5jzkrA8Lxc4tAfwpieCZeJppqPFM8R39HEfjc4c0z18z3Sgnx
DIkB5yIl7B41y+uwFURE
=pHmn
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
