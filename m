Return-Path: <linus.luessing@web.de>
Date: Fri, 26 Mar 2010 07:34:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100326063406.GA3835@Linus-Debian>
References: <56afad541003221528w13e61637tbfdd0e0890181d88@mail.gmail.com>
	<20100323063231.GG15823@lunn.ch>
	<20100325225807.GA10755@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20100325225807.GA10755@Linus-Debian>
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2010 at 11:58:07PM +0100, Linus L=C3=BCssing wrote:
> Hmm, in the frac_part, wouldn't that thing be rounded to 3 digits
> max anyway because of "(_1000_ * TQ_MAX_VALUE / tq) ..."? So, is
> it really necessary to limit this value with %02d again? Or should
> we change this as it is not such an obvious part maybe?
Argh, sorry, wrong again.... Are you talking about the issue with
missing leading 0s here? TQ-values like
> > 42	6	95
> > 255	1	3
would of course wrongly become 6.95 instead of 6.095 and 1.3
instead of 1.003... So yes, %03 seems to be what we're looking for.
> >=20
> > So it looks like we need a field width of 3, not 2.
> >=20
> > BTW: Is a TQ =3D=3D 0 possible? batctl does not prevent the / 0 from
> > happening.
> >=20
> > 	Andrew
> >=20



--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLrFVdAAoJEBKw7u43QNpfp/cQAJ0LZaFEBbQheIUX8ZtBb1il
C8spJkyZKgtOwjOoaG4XRljfEEgjo3QEu5Kr7T4aE8PxGZUHZBa7iRgrqXW8wtUL
9AaoQSiIn9VZk84I3PmGk15kIBJ+D0RJNQHW3gxV+av+/TdOVorz3MiKIPVnsHJk
fPi4Ch/9cFIwWbx9ZzB2lvT8byzcmwatf1VxydrJGwoEf66YVIGLVLDLWdADfQZC
t6G/ycT+FW5b7kFP3EKrDXl5UFQO2TF5qrjwI9mWO922HQrcTA7rNjDgzWSJMosz
jBaGcX8XQzrgYmBruRNWyBS5M1RLQXtxoX1bUl7RYWFbNbCNX7LBmTXZGLRdgzMZ
/f4Plna9WtFIvmKYUCdfiOmXk6eTXybBlXbcoeuJ77IcC5Fnzx4/mRCjPxhJuO1R
FK2CYjVaYz4jL28XlH+OdtCIFM5Yloj4hPlgbEjiMqUnHAvQKi5gXTHCAQlGP+AJ
raSflzoePafElzHgAGQbCjK6v83eUVo1ZatqAjrrjU8b+YxMq8esKmCDYVkeql6F
krsvg05VhPiz9YJ1XWsNUA0s5v5/ObEo1OfljxNsqxWBj2mYbeRdA/ltbJ9HYq6z
kHpQZV2Y6+PxHa2Z2RLO4JSgNsRPN2rJjEKM5MlJfmDrTOmZ1+EWxjnpHNJwugrg
X6YFgo01oXhSBONvKQ9l
=P3rM
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
