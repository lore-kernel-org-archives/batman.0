Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: battle for yocto
Date: Sun, 28 Feb 2021 16:02:48 +0100
Message-ID: <5849548.csWtZluKKt@sven-edge>
In-Reply-To: <CAK=yUG+9mOttJULTHVbGptFJc12ACO_V-ih15xXpNfWw7N0iuA@mail.gmail.com>
References: <CAK=yUG+9mOttJULTHVbGptFJc12ACO_V-ih15xXpNfWw7N0iuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2325533.5jg2AtdYid"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: kamalp@acm.org, jhaws@sdl.usu.edu

 
--nextPart2325533.5jg2AtdYid
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: kamalp@acm.org, jhaws@sdl.usu.edu
Subject: Re: battle for yocto
Date: Sun, 28 Feb 2021 16:02:48 +0100
Message-ID: <5849548.csWtZluKKt@sven-edge>
In-Reply-To: <CAK=yUG+9mOttJULTHVbGptFJc12ACO_V-ih15xXpNfWw7N0iuA@mail.gmail.com>
References: <CAK=yUG+9mOttJULTHVbGptFJc12ACO_V-ih15xXpNfWw7N0iuA@mail.gmail.com>

On Sunday, 28 February 2021 14:16:20 CET Kamal R. Prasad wrote:
>  can someone point me to some info on  how to plug in batctl into a
> yocto build? the kernel provided by raspberry pi os already contains
> batman-adv kernel module but not batctl.

You have to write an recipe. Something like 
https://github.com/jhaws1982/meta-batman - just with a more recent version. 
But I am guessing that Jonathan Haws will accept pull requests in case you 
spend the time integrating the newest version.

Kind regards,
	Sven
--nextPart2325533.5jg2AtdYid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmA7sJgACgkQXYcKB8Em
e0YpaA/9EyqYcXwGRVC1CJ05+gVQ8w0nToakneoP5JHw+A0XQfVVgNgysf6B7k4+
oqik3DtLIPjUyl/nJQ5RGSYBajVnnY4c079ZFcTJCItL79RRZaMFT4iYoj58Q23/
ri3mKlXgVxDZ0qtuO1xspSBcqtcYyIK0DmnriDYMympMpJTzPlRS1dET+18rtWKh
xxRacfWOvji4yua1AnmUJqwOvH0WMmUWYknhP9JJbV7YAC33m3+9Q/Sooh0jLer7
NOAzoaTsCC370plTAHekpPY7azVNI2UHf1wxR30LCQmgzL7mL1QgWBjEA8zZS6pw
Vcqp+MfiHqQyVWegVy6BXY34J/6XeHzbBWClW3+Ay/qGnTDU5LOway+csiGV1pR/
HiS0/ATGwTinrit2p2xjZArn3YlOxl/XDDon9VG4bm+7zFUCq6bEqec88mHCQ2Cz
ohCs7kUbliSyfoMhdVx3A/58EZYFLg/ZwnK5ngB9o5oTXVyK12O4D3ZkaCgK4son
VlNoS24WomOM9khTrEwNjflViMoFU9P4MfoDOmbi4wo8gPDTy0YSOXPo6+MjcO7m
IYoVd+FH2Q20SS0M+uL19yPSToDhuEYXilwc6cXQwTmTjGyZ4iENVk0NiCsXb8Mh
cwfN/2Nf9rogeaTgXEId6loady3t1UbiGFoJ3P8ZWDsO1rb7+9U=
=a+QY
-----END PGP SIGNATURE-----

--nextPart2325533.5jg2AtdYid--


