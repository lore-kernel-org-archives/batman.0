Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 15 Jul 2009 20:50:15 +0200
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907151556.32314.sven.eckelmann@gmx.de>
	<1739bfe0907150726l70ee35b1wa92f4fb1aabfdd61@mail.gmail.com>
In-Reply-To: <1739bfe0907150726l70ee35b1wa92f4fb1aabfdd61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1960047.MCIQ2ksMnh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200907152050.18936.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1960047.MCIQ2ksMnh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Thanks, is this better?
There are different things I don't understand complete. How does the receiv=
e=20
buffer affect the output buffer in this case?
Isn't it possible to disable non-blocking sockets in vis.c:635-638 and chan=
ge=20
the read to following for json: Try to recv data until the read fails or an=
=20
empty line (please check HTTP rfc before implementing) appears. If the read=
=20
fails -> discard everything. If the empty line appeared then send the data.
You should create an extra function to read (and discard) the header stuff.

My personal opinion about the errno and delay stuff is... I don't like it. =
It=20
seems to be somewhat correct to ask again on EAGAIN corresponding to the ma=
n=20
page, but we could do it in a cleaner way if possible.

Maybe someone sees a problem in my proposal. The only thing I see is that t=
he=20
read should appear before locking the current buffer or a "bad person" (me)=
=20
could delay the new buffers for all others by connecting and then wait for =
a=20
long time. I see the same problem in your current implementation.

Regards,
	Sven

--nextPart1960047.MCIQ2ksMnh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKXiToAAoJEF2HCgfBJntGer4P/A44Rougq3x3Ue01pwmal3rG
pneYUIQNaus/SioOrhl1soad1N1/rKsBwzy2D3jogjrkIGiOV7+Gnf34W4xh4ISN
e1UK5jXkSdXAa7RuHmDPIdvjg3ax/QFEjHq1cLUFPipu4mV9w0/l25RaTwxuY5ER
qRrTdl0QGYVJ+OeSV6N1iM8WtO3IWEHqgfjYSP3+FzYr6bCmVXPp5l6D86fx4e7i
kj24AF0AXhBK9UM26Vu90gbYRzE4cTAPZSp9p5VStKXw5y0xmp2CTb8VsrKnp2m6
KPEghO0XXq1cztl7xt5Q2eUngeMrOJVLS22gIurzJ34yDKDxxEX87ijDYGyuCUm8
y1UQPf41Eti2I8AjAIb1YRgBQuNmzUgFWp5LtO3wWXUdARcQxGfSt+GjwTURxM7X
mE7/z57t2qRy+2PV7E8jxyy7aNCVHQ0o5ZGP58HOVfnwnwNIsoWlT5twsR9uz849
f2YsnLQM5vSJ3TSS7c3QuaioPPTm5ANRR4zNxvCUQrQD/CfhXuEAK4oDFc/YvOu2
x5J/T2cO8UEWJc/ROl2RkEK0QzqyP/psLSdpTWgEFByVlJbmeHdkzpT3Bc8XYdHP
8LjhMuQMag2Romb70oSIJd67DDT0Xp4JfWh3e2Ql9zH1RLc8Rwy0F4cCvn9RByDO
xO7AxQRKU+vo8zIIohAq
=0FMj
-----END PGP SIGNATURE-----

--nextPart1960047.MCIQ2ksMnh--
