Return-Path: <martin@hundeboll.net>
Message-ID: <52DF6A30.2040100@hundeboll.net>
Date: Wed, 22 Jan 2014 07:50:24 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com> <52DF0B77.3070106@meshcoding.com>
 <52DF0D4E.5070207@wirelesspt.net> <52DF0ECE.7000707@meshcoding.com>
 <52DF10D1.4080207@wirelesspt.net> <52DF1156.6000606@meshcoding.com>
 <52DF166A.7080309@wirelesspt.net>
In-Reply-To: <52DF166A.7080309@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5iMkiVSOwXAPPS9LLhMTfcwVXhc72eBTA"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Antonio Quartulli <antonio@meshcoding.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5iMkiVSOwXAPPS9LLhMTfcwVXhc72eBTA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi cmsv,

On 2014-01-22 01:52, cmsv wrote:
>  uci show batman-adv | grep network_coding
> batman-adv.bat0.network_coding=3D0
>=20
> after reboot:
>=20
> # dmesg | grep MTU
> [   28.030000] batman_adv: bat0: The MTU of interface adhoc0 is too
> small (1546) to handle the transport of batman-adv packets. Packets
> going over this interface will be fragmented on layer2 which could
> impact the performance. Setting the MTU to 1560 would solve the problem=
=2E
>=20
>  uci show network | grep mtu
> network.mesh0.mtu=3D1546
>=20
> changing the mtu to 1560 when NC is disabled:
>=20
> # uci show batman-adv | grep network_coding
> batman-adv.bat0.network_coding=3D0
>=20
> # dmesg | grep MTU
> no output/result

It might not have been clear, but when we tell to disable NC, we are
referring to the compile time options. batman-adv is not considering if
NC is enabled/disabled at runtime when checking for MTU, but only
checking if NC is compiled in or not.

It might make sense to check for runtime options when complaining about
MTU in batman-adv, but I don't think so, as it complicates the checks
whenever MTU is changed or NC is toggled.

// Martin

--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--5iMkiVSOwXAPPS9LLhMTfcwVXhc72eBTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJS32o0AAoJEI7EM4tTnYEZWuIQAI5CdFbvN7MeVj9eWfY8Aoef
TSkEelFAOr/HAVV3/Kc0S6DwL7XUe1gLsADA3jeDu9S4DCOBbsUwTuIqNi242YZn
K/XatnYDmBTeqIwVoLeV2N3cb5rqNN3rOctS2Y6n80pNnT9kp+L9SKPW+9DvKXTE
nCJZeL8O1HOXpSBRNCrnk8c3E5Q4WQYTpXyTv9xKRassAZRlSOk2JJv1U9/U3nJ3
ERrQjv2olgfujR5+ZJMpSlJ7QjKLzRsxPOf9TtIiTRvYvkXuFg9JFLzuzS2l7r1i
Uz2conf2QWxx8qwBqyyY96eSVEvBqgCkP2DOxYwgA8PCe9tEyktrFwfgpRDkEuYu
/j1s19fwN7WQiUkDRdCImm/cesFpvGVNcUQZ4A429tfahcUvCnMXPUZe9a8RsxXr
Yw2XkmrrDTH2WTU39Y2d7gEBG2v0vdx0KTpiTbz1euKajgSo91lL6tFUr/71dGIM
zU1E+9se1UyLx4pvS0qxLaj4AgSQM07Im2ucx5LyRikZRxAxMhB8fY6RDROMLw+R
n0rHGmll+RIArnK02OgiQ5Hp4m/1sVCpsNBv1kDfkoOdApzdTDHiOiSFv7WZkBhG
9LejBgAK22YyApC6M1jrYEV8B1kPgHlMzFQoCqXTgR0jXSjw8db4do39jdfAV/N7
xO1L86NZOhihcMFqzD/h
=TrZP
-----END PGP SIGNATURE-----

--5iMkiVSOwXAPPS9LLhMTfcwVXhc72eBTA--
