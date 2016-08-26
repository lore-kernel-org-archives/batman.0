Return-Path: <a@unstable.cc>
Date: Fri, 26 Aug 2016 09:45:36 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160826014536.GS16157@flavoursapulia.lan>
References: <1472140362.4465.4.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U0B5otXy6WXfork9"
Content-Disposition: inline
In-Reply-To: <1472140362.4465.4.camel@sdl.usu.edu>
Subject: Re: [B.A.T.M.A.N.] Consistent bat0 hardware address?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--U0B5otXy6WXfork9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 03:52:42PM +0000, Jonathan Haws wrote:
> Is there a way to ensure that the assigned hardware address for bat0 is
> consistent? =A0What I would like to have is keep the hardware address the
> same across reboots. =A0Can this be done? =A0Would it be done through
> /etc/udev/rules.d? =A0Or some other mechanism?

Yes, I'd suggest using udev for this. batman-adv generates a random address
every time it creates a new batX interface, therefore you need to use some
userspace tool to make it static.

Cheers,

--=20
Antonio Quartulli

--U0B5otXy6WXfork9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXv59AAAoJEJ4aZjxxc6bKhvcP/3hD4ktZhPK1d5tNr8HKC58h
0ty6NOMcHQECQhUojCgswMnK3SNETmDWTSSqlxrlC2P3+kTaGbk4KEqPsoGbBwXc
7Z1fsT1nO91XUX2y4mVV45IvMDdanCbihW129FVf0fVusRgnxo2LlB3PCH8c0bVm
fa3OMVInssYJRD79HGq15WoY+FKSZesSpeH0EUu8NqVDbW6SDn/KYzJHy0CTzk8K
hRgWnU846RCcQrtSQZWa/82J/w2TIXDqmZuwRhBYrxUHz1qTWzMPcgYEx1wc4XRn
EABSyNzpjjmoD+s7RUnWJgxYSGOzFYIoSqGOLYdZlA0INn76Ejp+l/2Q/blhPiXl
huXS7YIzEWQTC4c50y7bKOi1BC8XLSVRP+mh9s28gbmjV9oWkrtrJmNxoJkjKTpS
Wi8EzHKd1Uoj9lgRybVhKTqZsf8588PRSLibUvWhLyFixBTtMeKsXl+mm2eXVsar
YQ9IogMztPlczhxrPGzrEhpwIAdWopCIqZT2LyV9DEThmQ27RA5atZxUeZkJA9Ai
f6pnONx0JhnN64IibYE8aMIL7bl5PuvNOaz2CEmCdigeEU9astEJk+EdZHWhFc+J
H3ryo1BVZRfWWmdwiSew0lpj6SQv5U9Px7VQhKgvlXghopbcGtFrn3Xwc66uoebj
8VtLbFbPoscR7ZUcLkIC
=uAVK
-----END PGP SIGNATURE-----

--U0B5otXy6WXfork9--
