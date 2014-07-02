Return-Path: <antonio@meshcoding.com>
Message-ID: <53B3A519.6000400@meshcoding.com>
Date: Wed, 02 Jul 2014 08:22:17 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>	<20140701085027.GA2341@Linus-Debian>	<53B29AFF.2070405@meshcoding.com>
 <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
 <53B39F7D.6050001@meshcoding.com>
In-Reply-To: <53B39F7D.6050001@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e31AELOlEG8K8hE2vf0FT8WmTagHQMjSL"
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
--e31AELOlEG8K8hE2vf0FT8WmTagHQMjSL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 02/07/14 07:58, Antonio Quartulli wrote:
> Simon,
>=20
> On 02/07/14 03:24, Simon Wong wrote:
>>
>> - Even more strange with 'iw station get' during the problem:
>> interacting with the Telnet connection from Client 2 to Node A will
>> also reset the inactive time count for Client 2, and this is while
>> Client 2 is roamed to node B. On node A, only the tx {bytes, packets}
>> counters will increase. rx counts do not. On node B, the tx/rx counts
>> increase as expected.
>=20
>=20
> very stupid question: but the two nodes have different MAC addresses fo=
r
> wlan1, right ?=20

ehm, here I meant wlan0 (the AP interface where client connect to).

--=20
Antonio Quartulli


--e31AELOlEG8K8hE2vf0FT8WmTagHQMjSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTs6UdAAoJEJgn97Bh2u9eZkMP/25XFnWwzHGsEzPRtSCjhWBz
a8wQa48p2QoL5zxbKgf6W5b9x2WdHadTPzFe75l7w+IX6LXO2o3+AmHl2syIBqFg
YkMf+w5zf06IWOgILt14wOm1SD0SVdDmUeTPoUZ6syTwRolEM+aYa8DmPkWCkwoe
UoKvA7i7CYmsVFvuwfRihM5JUR9tImxvA4yOaVy9mdoUw7FIPcI9DNkBWk3LOmBO
FNeCP7iaLNsC5YBzvK+kwJTVELL2OzZ9PWv5PogN2CysF+t/QQiubhPOxtpPETRU
AlyC8AumcAC9S5vwYT8dYaIwBKeCL1ZIKIxlxyDhKEJQL9d3f+9XGDOICSeJNK2T
7PWQQwYiyIX4/b6qYqsUzhF5QDD8a1Pr1g12KwQKlp/BLY6RXRPVQwFmGTHugxNK
+C2hAP6jU8c1UPxtU9rswAJFFuoN2cjOq1jdO5PvLyhnviuRs8VYpsDBITWw/Wy3
wvG8Yf7aDvqjplWCHlwbN5S1FgoUs1fem2STZCdK79Us3Y7rSPEXz4u5Z+hoDtUX
XNuDn0w5F+R7b1r2zlm0RTFubj282IeKWejvP7Xh2DJOw2x796Hir0Xj95VUQOHo
rM4rF4GzQqJHT4+UIgb0saaCqr3idkBLXrrGh+BmKIMZSLJ1kc741iDMNltTuGsu
Stt73VbEZvDI/eaUgVHG
=C7ay
-----END PGP SIGNATURE-----

--e31AELOlEG8K8hE2vf0FT8WmTagHQMjSL--
