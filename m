Return-Path: <antonio@meshcoding.com>
Message-ID: <53B39F7D.6050001@meshcoding.com>
Date: Wed, 02 Jul 2014 07:58:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>	<20140701085027.GA2341@Linus-Debian>	<53B29AFF.2070405@meshcoding.com>
 <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
In-Reply-To: <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4AAOoQuGKv9bi4nT6Um7RKODcGIfpW2D7"
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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
To: Simon Wong <locborgtus@gmail.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4AAOoQuGKv9bi4nT6Um7RKODcGIfpW2D7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Simon,

On 02/07/14 03:24, Simon Wong wrote:
>=20
> - Even more strange with 'iw station get' during the problem:
> interacting with the Telnet connection from Client 2 to Node A will
> also reset the inactive time count for Client 2, and this is while
> Client 2 is roamed to node B. On node A, only the tx {bytes, packets}
> counters will increase. rx counts do not. On node B, the tx/rx counts
> increase as expected.


very stupid question: but the two nodes have different MAC addresses for
wlan1, right ? I expect the answer to be yes, otherwise this would have
probably created more problems...but just to be sure...


However there is something strange with the AP interface (as you already
pointed out)..
Did you see any deauth sent by the client while roaming

Cheers,

--=20
Antonio Quartulli


--4AAOoQuGKv9bi4nT6Um7RKODcGIfpW2D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTs5+BAAoJEJgn97Bh2u9eYmcP/1lPhkOwyIuB9dRFKyZeZsZJ
hcAQtiNeHAxTGqfR0+AJHypW4rGzMG3xr+P3GKXjC6X/ItS3Es/StBEfX3z0E3Rt
WVmQYtEz8sWJLfh/gx53gnYQj6S3PBEcm228bR7VrpClt7fjrzStuTM/vGTtNUTq
lzI9O24bDpi46tuXdyLQa8RzypEtH8KA97hrIT3h4FkZaW8RBiQ5TAhT7eHOpG0w
1owyAJInHP5nGKXz+QjQbWOUA3Jf89wggXkxg0KsrXhNSECIavP8gSeDg4GS2txh
6uON/Ic8043SoFHnxD198/LLbrrUpVA+rKZaWSnaO8jy+EsPa/5xE+8txa67xsRF
Qy6vHbrneSiOMnDT7tusnO3GJpIlXyqswA18stIsy9q/BNWBYqt+HUAaci+63ML+
0u2VuABeLw/xR+zDSIfL9/C6o4NVSrh5nZoFxYIjLEMJXIBfrMYIDFCSQczs6QlY
0UBVR2efMW1l+KtE84V18Peh/GhTb6TxzCQym3VFGa5V2JO0I+n3GW2fY4EArYfO
tHN2S7a7QxmIwx3H4fn5yA0f7dSQm0OVVtCYOH7H4yPrqPaXTDpyo6CJtEfyTqoK
a7FUSS+U2hzWRj4O3NZWZVcndLaFuiRwQgLuWMNONZ9WvvIkey2anfHcbXWTQLIr
cP20z0IF+1CeKkHj960T
=yw/f
-----END PGP SIGNATURE-----

--4AAOoQuGKv9bi4nT6Um7RKODcGIfpW2D7--
