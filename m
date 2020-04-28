Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: configuration issue
Date: Tue, 28 Apr 2020 13:17:18 +0200
Message-ID: <6242566.y7phzM5aPs@bentobox>
In-Reply-To: <CANKYHpf+GVA8zWuc-eZXh_6aW5FkpM3Oj3QbTKiTkfDZvUgGHA@mail.gmail.com>
References: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com> <9817716.HyuBmzvnZK@bentobox> <CANKYHpf+GVA8zWuc-eZXh_6aW5FkpM3Oj3QbTKiTkfDZvUgGHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5874877.ucWHjBDv3O"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Oguzhan Kayhan <oguzhan@kayhan.name.tr>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart5874877.ucWHjBDv3O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 28 April 2020 12:36:53 CEST Oguzhan Kayhan wrote:
[...]
> It failed when I add
>  option encryption 'psk2'
>  option key 'thisisaverysecretkey'

Just in case you didn't read in in my previous mail: Make sure that you have 
wpad-mesh(-openssl) installed and check if there is any relevant patch missing 
which prevents wpad-mesh to start up correctly. And no, wpad-full is not good 
enough - it is missing SAE and mesh support.

Kind regards,
	Sven

--nextPart5874877.ucWHjBDv3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6oEL4ACgkQXYcKB8Em
e0aqpRAAuYjslDJvZ+Wfk5HlNrFq/pR8+qVdJ910h9ILpiN2WGfx8VlY0Qq5s2bk
0jp8AMqt640b+EkOfpWMj7MSYePBSSqkoOqLED02g0G9lFBDmdKsgweJ5wvMPrr8
4qc6GHbB69HsEWOzHySQCIZEXi5u7msjPM7S3kt4YoLkHtnIw5j59GCQCJCZVDQW
zqlCR5uF4XbWkOdhoOQzhNSar4fjUDswyWr2hkRwkpP75a+1GO0abj2gBwQGNK3S
PKg6yTKlJ1IEfGekWfdVxFx7WqLuoPEPL3jY2EoZo2Tl8B0Y0UGCFp5UEgw0EZHt
RI1s+kC7tjr/a6hfq5gWmijNKb/kfAUs8Aoqzm1M0z96PJvdN3LjgIu+Q/Rkckvx
/xWryfX6G5SWBqznFLN4/YtdlGi0v7y1aaEUuxsLS5mWqcd/bzBRjG++bus1p31D
c5uU4JzQB0GCXP6GK4vkvNkz2PN5REowikiJsY08LHskDrAQN05HD/3IfTWDWOlt
EJaKqP9z4p5DT6pFJyygFWN/canBH7erIU7vPbc5jHYHSAftNLYlS4+Q896v/YIu
IsjpxPnYsNmTi/sv3h/phTW5100OcKgfrGkW/9HUOyzBjfAb4rzXX9AoFFWMoWJL
/GvtXaREtKii7or1Zzhyy4BKmxWXnh0X4jDDs7BSbJAlOE+3LZk=
=9YR9
-----END PGP SIGNATURE-----

--nextPart5874877.ucWHjBDv3O--


