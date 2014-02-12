Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB68B2.80507@meshcoding.com>
Date: Wed, 12 Feb 2014 13:27:30 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-15-git-send-email-antonio@meshcoding.com>
 <20140212085812.GH30814@lunn.ch>
In-Reply-To: <20140212085812.GH30814@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rvaOnqtxrNrfGXmIid2kO5q9aw4fg8iCa"
Subject: Re: [B.A.T.M.A.N.] [RFC 14/23] batman-adv: ELP - compute the metric
 based on the estimated throughput
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvaOnqtxrNrfGXmIid2kO5q9aw4fg8iCa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 09:58, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:14PM +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@open-mesh.com>
>>
>> Implement a stub get_throughput() function which returns the
>> estimated throughput towards a given neighbour.
>> Its result is then used to compute the metric value.
>>
>> The metric is updated each time a new ELP packet is sent,
>> this way it is possible to timely react to a metric
>> variation which can imply (for example) a neighbour
>> disconnection.
>=20
> It is very much a style issue, but i would probably split this into
> two patches. Updating the metric at send time rather than receive
> should have nothing to do with estimated bandwidth.

Yes, to make it easier I will first move the reading at sending time and
then I'll introduce the throughput estimation.


Thanks!

--=20
Antonio Quartulli


--rvaOnqtxrNrfGXmIid2kO5q9aw4fg8iCa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+2i2AAoJEEKTMo6mOh1VFSQP/09zAVhxJGaGiN4DHTq1h+7A
0HtzGGens2U1qV/7oXi776ge+5oPmfaxhrD28yJUsRaxkhS9voYdqcZRjerQaub2
/GBHDFBtA5YLH1qtCH6c6e3zh+bXDI2Fjmdwx3TlIQ/o1UMdZEJxqjTAoqzMNJ6O
L/Zqz1OvXIdWeFpgbWHkPmahhsmerR9XTPWceYRfxloKYh/6Q2oLRnSNxUAhRZ/x
9CGjJdWCJftQ/RkoPaXjw/+/BYsE9LQ41gaVhxwapiJhPICxp/KC7afakI8pCK3L
9MvoF0fBPXwCWlZuhM9+QhzJganIzkX/2+W2HfMoioLUxUbkJx4MY7x9+FH7T8gz
qtRYMs8+mRBOTKNkjcJeCCBtECO003vbyELXc+TItFpVhiXu9WzF+HwcPAaHng6F
PkSc9inkL/MhnJvAuWFXDgaZTHc1T/OblpeU3VN/MnhSsg2xrUKCi9UqH7qSU3Mc
Gd2KQ1b9COt0lGYxseT+FlgK1M3xY9g2h4DHof06hC+1uVk7kAMUjcq9T+yoAW0R
9riI9SUhg10nSJjAyGR9L5c6Dpl/XiOSeAUuxtr1KrkUs2V1wm2Grjhm/gQC5QAJ
9nHz/eqcGzl9+NGiqloOt1UyFYkSbPz1CY9mn2VOoSjwUbrbixUR8lxT2k9AnNUe
UAT+yWuCCy/3EAGo9iXw
=cLP/
-----END PGP SIGNATURE-----

--rvaOnqtxrNrfGXmIid2kO5q9aw4fg8iCa--
