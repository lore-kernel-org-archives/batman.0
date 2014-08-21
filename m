Return-Path: <antonio@meshcoding.com>
Message-ID: <53F59FA7.2040205@meshcoding.com>
Date: Thu, 21 Aug 2014 09:28:39 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <53F59DD3.7060703@aliyun.com>
In-Reply-To: <53F59DD3.7060703@aliyun.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wdk5RP2qgTCEC9c391v0AVnpEV3ug50JO"
Subject: Re: [B.A.T.M.A.N.] How to test the non-mesh client roaming feature?
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
To: liudows@aliyun.com
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wdk5RP2qgTCEC9c391v0AVnpEV3ug50JO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Liu,

On 21/08/14 09:20, liu wrote:
> Hello, everyone. I want to test the non-mesh client roaming feature. An=
d
> I have connected my notebook to the mesh node A via the access point on=

> node A. What should I do next? When the notebook move to the mesh node
> B, should I connect it to the access point on node B manually?How to
> make the non-mesh client move to another mesh node automatically? Thank=
s.
>=20

this behaviour depends on the client OS (each OS implements a different
logic), but in general, if all the APs have the same ESSID, the client
should just switch from one to the other without any user intervention.

The client should switch when the signal from the new AP gets much
better than the old one (at least in principle...then each OS may apply
more robust/smart rules).

Keep in mind that this has nothing to do with batman-adv but is more
about the lower layers (wifi stack/driver) and their implementations.


Cheers,

--=20
Antonio Quartulli


--Wdk5RP2qgTCEC9c391v0AVnpEV3ug50JO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJT9Z+sAAoJEJgn97Bh2u9eLhgQAJqHZysAOu7EK/AZ7SlZf4Hw
q4vv6Vk53EPD+o65iKft0XNuWYP6vgEdw9BT8r8CvtQKHS44HeuWKaNeiQ5l0V9b
W26lNLJQBnNgeh5lD2Rgh1jjiVNuBoFCPEeRJ9bZJ2u4kaXSQbTwOFd069Zrqe2K
k7GtQ25ch+HycvIyXKI4ht2e77RJEkKSxNowZ6AwjimgvW41Oh7Av8OUyisaMvUx
K4AoKjrNi2u/yCl+vaySEnl2yEJhWtYH05MPM7HL+l1NnK/UVf/qHa3aSOOaVfgG
UjBiF85qIpHsJVVixcyBjzycHZJ/Fv8FoiliSsXQa3puvEY0YCaXvYYI6YL1z6wd
587uzSuzkMapeSCmulZ/0w6f0UzA55xg0PeTiCw4fbyTw0NZl6Mwi99nU7P3kwSV
0foGHa+DuAYPE4pTtRE+1dm0t0cHLBRxqjKY7OQpobYwh+TRsrhaa2tvkag7XLcd
9shKssiC9G5GBl9qqtQmMkVRrKvwE0Xdw74rSM6aZSa/35CH8hKu4XmKfg7dz8cS
u0+d8oG3M+Ogyl6nov4AY7sjuxNWOAzoKOG4W4T8ubvsMr7AMTQ/BtSblJlO2FdN
XmqMz/R9HbppqnQtfufuLh2mhoVUDCZqkuv17GBlEBilWG1jErLOohznwRn6G8sx
QeZliiu5Lf2Nse58C1dM
=eIe+
-----END PGP SIGNATURE-----

--Wdk5RP2qgTCEC9c391v0AVnpEV3ug50JO--
