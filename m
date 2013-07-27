Return-Path: <jh@sotun.de>
Message-ID: <51F3B994.8030804@sotun.de>
Date: Sat, 27 Jul 2013 14:14:12 +0200
From: Jan Huwald <jh@sotun.de>
MIME-Version: 1.0
References: <51F194D6.3000701@sotun.de> <20130726121608.GA16248@pandem0nium>
In-Reply-To: <20130726121608.GA16248@pandem0nium>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NUABWQFGOLSPOCPPQLLS"
Subject: Re: [B.A.T.M.A.N.] Mangling broadcast packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NUABWQFGOLSPOCPPQLLS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

thanks for your advice.


On 07/26/2013 02:16 PM, Simon Wunderlich wrote:
> * send unicast to each neighbor instead of sending broadcast (find=20
> out who is a neighbor by reading originator tables) --> using unicast
> might be faster than using broadcast too, which is usually fixed to a
> lower mcast rate.

I had not considered the mcast rate issue. Given the typical low degree
topology that is probably the most efficient way to go. Even more so
given that bcast-packets are send several times. (I just discovered this
in the batman srcs.)


> alfred, which servers a similar purpose (at least i think so) does
> the same.

We had a look at alfred, but unfortunately it is no replacement for us.
But hopefully I can copy your neighbourhood discovery code :-)


Nitpicking part:

>> * using NFQUEUE on all enslaved interfaces to mangle packets
>> before they are seen by batman; requires out-of-kernel parsing of=20
>> batman-adv packets and watching enslaved interfaces
>=20
> out-of-kernel parsing of batman-adv packets will kill you
> performance completely.

By filtering with U32 and friends only packets that are scheduled for
local delievery anyway would be processed in userspace. That _should_
have only a minor performance impact. (And only be ugly^10.)

With best regards,
Jan


------enig2NUABWQFGOLSPOCPPQLLS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR87mUAAoJEApFouY8nhT61cIP/jsRub/os4iefQMoJUHe2zeX
V0P1P0ItcePTVdoY5QZXm1eO4LZSjAWfDvu6/ZyNeuMQiP0c5Dolw3UrMOPYCfCO
07GCVlvb9jQnvAcNWeichK/a6NBRLL5Ev8O+n7CdY0RTMrqsb0WUjz7RD5krRIfb
xhHtAAOp6LIWgZbYBc9nv/QIlhVOeKpYr6okOSyb+YZqRzwHyQ11bIJAH998MEwK
gQM8C1ZXn8WvMyG7gGglOaF7JIS/ogjEkDsYwdx19eIhrTjP+TLItvoD4/pqAN66
DnxxMrLVqs1jzDY22cuM0xn7YPdE7LsblQ+Yb/F3pEMWUfkHRhG7cOdPlju9kY2c
eOz/9epQ0CeHe4voR/wJrfoTzj9Wg+us1bWtUM/097Jbsl7fM3GjfjqJ/b1ZyD2K
VlTPCyA2FEUOfGMogqan3RF6yBFk2qffp9JUk8SlG1wRT7o5y2iec4jt2AcPLVfQ
rTZo1Z0RxBcIHSQwRmb2M0MDk4TCgnZ4iGI81f43S0MNeEfEWjClaZi8JPDu5Akn
V7or+E89uelkv+tO2/SkCiqMyLFAWH8sCR+v3AEFJMlcEY4b7ZSQP5JH12BSCjR/
A1/VH5WUNvbIT/LncNjtePvmEA4lQ5Ut1R0T+ZNvuED3wqtxOmJcE1KzMSB+55hL
2jZv+VqZZPuHKzUCBP63
=EL5x
-----END PGP SIGNATURE-----

------enig2NUABWQFGOLSPOCPPQLLS--
