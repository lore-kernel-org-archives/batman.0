Return-Path: <sven.eckelmann@gmx.de>
Date: Fri, 12 Mar 2010 22:06:12 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100312210611.GA12732@sven-atom.lazhur.ath.cx>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<1268342346-13713-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
	<20100312205740.GA20427@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20100312205740.GA20427@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in	vis
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


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2010 at 09:57:40PM +0100, Simon Wunderlich wrote:
> #define seq_before(x,y) ((int8_t) (x - y) < 0)
> #define seq_after(x,y) seq_before(y,x)
>=20
> Not so much bitshifting and may a little bit easier to=20
> understand, but also not general and does not pass Svens regression test =
=2E.. :(
>=20
> Wrong seq_before(0, 128) =3D=3D true
> Wrong seq_after(0, 128) =3D=3D true
> Wrong seq_before(1, 129) =3D=3D true
> Wrong seq_after(1, 129) =3D=3D true
> Wrong seq_before(2, 130) =3D=3D true
> Wrong seq_after(2, 130) =3D=3D true
> Wrong seq_before(3, 131) =3D=3D true
> Wrong seq_after(3, 131) =3D=3D true
> Wrong seq_before(4, 132) =3D=3D true
> Wrong seq_after(4, 132) =3D=3D true
> Wrong seq_before(5, 133) =3D=3D true
> Wrong seq_after(5, 133) =3D=3D true
>=20
> What do you think?  ;)

This is the version which also was mentioned by andrew - which has the
advantage that it doesn't have "complicated" code, but isn't general purpose
for unsigned ints. The only reason I started with the more complicated stuff
was that Linus tried to make it easier to change the packet definition
without ruining the code at different places.

That it doesn't pass the test is only the due to my symmetric definition of=
 the
operation. I am not really intrested in changing that code, but to support
Linus.

Best regards,
	Sven

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJLmqzDAAoJEF2HCgfBJntGfo0QAIU1ZtK67JE8LZpHR/yyUGLv
tui60MY+PrmEyoOeYqXrg7WwXoNJYqhqVeeg5ApGzeZkPDPWNCfdpm86p5SFVhfM
iLAnS/I8jnopBkpoHil6CJRpCHUxy4Hu3Nb4qal64cgbpA34U0QumW15t+BS3OTt
2XYiLM1dtDkHWnVl8L/9/VCYGRTrWxWOCQi7xYooU06gS8P+wzWhgpSOoNAPqlAE
lSKsItVmh9wxO6g9tb6J6bzLPQBNDuREcyKZOhNHtbJ+mROICqOdvdLDzlsbFM7z
bLr6SxLQutyGdaNguX9bvnTtsdOtS/PbKnyFn8mOuw8ningXdMid+7E2HD7KfYyZ
xZbKgH1MoGKUW25IJ4bi3xPqX8j5fTR3CJLAOe3K9+V3mKPXr++0aQ7TfYa0CKj9
y1hFR0VXahr82bEikFpGzv5BoJGy8W7ZnaWrWdu2K1R8MtKWTQweygXVEGj73FPy
91In/FffKvHhLZSgXYxUPvTxWVWAED/+ORAeCKL3mBlnx3WSzaL1bqJ8hR/uo/8L
SEZthZiMUtLTXBaRhsTlLyI7oCDP0FcWT7EIFl3ca7Vgj0A+hrjEHzfxSLDtLHqj
nET8vyIaZYQXu+GWaRgQpM4NuSgkOHSGu72L30H4sVYHwDnLjveFU+AksHG7VLRI
HxXpnZLPTiIuBn4uSGLQ
=e0RX
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
