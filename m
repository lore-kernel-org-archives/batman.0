Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:05:46 +0800
Message-ID: <2242244.thOU8IM75j@voltaire>
In-Reply-To: <3504520.4WTWZUr9vM@bentobox>
References: <1467274165-2866-1-git-send-email-linus.luessing@c0d3.blue>
 <3504520.4WTWZUr9vM@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3406822.WcvEEnMNP4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix Kconfig dependencies
	regarding multicast optimizations
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3406822.WcvEEnMNP4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, June 30, 2016 16:00:10 Sven Eckelmann wrote:
> On Thursday 30 June 2016 10:09:25 Linus L=FCssing wrote:
> > Since recently the multicast optimizations are using functions from=
 the
> > bridge module. If batman-adv is a kernel built-in, then these bridg=
e
> > functions need to be accessible immediately. Thus adding a Kconfig
> > dependency for the multicast optimizations to depend on batman-adv =
being
> > built as a module if the bridge is built as a module, too.
>=20
> [...]
>=20
> >  config BATMAN_ADV_MCAST
> >       bool "Multicast optimisation"
> >
> > -     depends on BATMAN_ADV && INET
> > +     depends on BATMAN_ADV && INET && !(BRIDGE=3Dm && BATMAN_ADV=3D=
y)
> >
> >       default n
> >       help
> >         This option enables the multicast optimisation which aims t=
o
>=20
> The used functions are provided via stubs in include/linux/if_bridge.=
h when
> bridge is disabled. So the symbols are only missing when the batman-a=
dv code
> is compiled as part of the kernel but the bridge code is compiled as
> modules. So this change seems to make sense.
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision e917bb4.

Thanks,
Marek

--nextPart3406822.WcvEEnMNP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2paAAoJEFNVTo/uthzA8EgIAITzDR+8HyUnX/4eD4bvG2oV
39D3+AyILZu1HDBRp+AEoP92CQFAXTKDhce+MDBPnFO0LDcZ1jHpwcDJKN5kV7Zj
YQNECKbvVwJyvG2rDK8672C4MLW1Wz3FTJzx0WmV7+o1ge8uARxCHUUxk1b7APKj
t/UVZr+38EC4C4KqguXbBlo72IM0DBalH11Uz9D19tOtzXNyKjLAD8dJ0shg9rbL
X3esGUOW76IbG4FtnON0Pq/ZoSOLl4CA6AD/Ru66J1++s1pfTc4CjWleMhwP+AAo
ZhFAoVuLyuNBZnk3oSf4FmX5AmpvZR+AJxWv2snQR04omTdRtDgfSntHtlSVz9k=
=edwp
-----END PGP SIGNATURE-----

--nextPart3406822.WcvEEnMNP4--

