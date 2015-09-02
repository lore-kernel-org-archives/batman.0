Return-Path: <antonio@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-4-git-send-email-sw@simonwunderlich.de>
 <55E578E8.5010107@meshcoding.com> <1775592.Epjag6J6MN@prime>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E7388D.5090302@meshcoding.com>
Date: Wed, 2 Sep 2015 19:57:33 +0200
MIME-Version: 1.0
In-Reply-To: <1775592.Epjag6J6MN@prime>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XhLQwFjGVWJIVI3Rs1KBwl1mpNJ3gi8Bu"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 3/3] batman-adv: detect local
 excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XhLQwFjGVWJIVI3Rs1KBwl1mpNJ3gi8Bu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/09/15 19:39, Simon Wunderlich wrote:
> On Tuesday 01 September 2015 12:07:36 Antonio Quartulli wrote:
>> On 26/08/15 16:41, Simon Wunderlich wrote:
>>> If the local representation of the global TT table of one originator =
has
>>> more VLAN entries than the respective TT update, there is some
>>> inconsistency present. By detecting and reporting this inconsistency,=

>>> the global table gets updated and the excess VLAN will get removed in=

>>> the process.
>>
>> This a nice catch, but I am not sure this is the right way of
>> implementing the fix.
>>
>> Imagine this sequence of events:
>> 1) originator O1 sends an OGM
>> 2) client C1 connects to O1 on a newly created VLAN and starts sending=

>> traffic
>> 3) originator O2 detects (speedy join) C1 before receiving the O1's OG=
M
>> 4) O2 receives O1's OGM and the check will kill C1 because its VLAN is=

>> not advertised in the OGM. O2 needs to wait for O1's next OGM before
>> getting to know C1 again
>>
>> Maybe this scenario is rather unlikely? What do you think?
>=20
> Mhm, I'd argue its rather unlikely. This would imply that the data fram=
e is=20
> reaching O2 faster the OGM. I don't think its very likely that it overt=
akes=20
> it, and even if it happens, its probably a very tight race.
>=20
> Also, I'd think that nodes typically just use or don't use a VLAN, and =
don't=20
> create VLANs all the time ...
>=20
> Even if that happens, the race is resolved with one originator interval=
=2E
>=20

Yeah, I think we can live with this "limitation".


Cheers,

--=20
Antonio Quartulli


--XhLQwFjGVWJIVI3Rs1KBwl1mpNJ3gi8Bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5ziRAAoJEOb/4TMchkvfYdsQALiE6vI9k1XSBi71Fq0P7dvn
5Ze/PNQ/dVxbR8A9my8YZQ4FBs8PGDH54VV/PR3RzD5IkoU68daGBomTn+yjqKai
YA7ibXlT5yvS+BQi3FVP+9hz5+eCKMVBrrXAzxt+N1l7NCbid5rJy2JnDud/evL2
8MZ+UvMFEGMsKZa0W2WT1SvVzWe/54U/X0aUpQRqfIkV1/LymKAdI6AvO6nyld+S
vY2FfD+q4GYfd4cWjpnpxCStdCZpnrBLK16GqLfOxNmyynEjREGy6XRrsExhN7oB
d7HosRvmsdCfTMF2QlHGwL2WxhXsGEnuv61wiDg7G+MuOydG3XTInC5dQDKvlyov
lHRjtq2GAJ6B9Wxu81M9pfH0cjQNcqLbl5jgTVGJ26af5c75nbYC3DyN3OgenjnW
AI3NWhA3zSh5V0lHeMfd3UuC7g41T/uzk5gaMoUxqipkcnnsdiSUbAW1Z8gYJhdt
95H4HucIvg8NL3PJx8tCwAo0DwVKQH5/6GepXeEP6IAO+VvOPQ8CcMMZAeKkIbZF
7uBLG3zUsPKzCT6iTDeYFNp1bt+iCXmqCLcLar/f9FZau2qZYCHInloXMrQpA5hp
iYdQOCsO2Lea1KjtVD7nKNsslSM6yDw48ltWgpg6OTA8pFZq9E/tkha45kLPEODK
Tb3XOFGvwJ8vhMC/ky69
=q9Iv
-----END PGP SIGNATURE-----

--XhLQwFjGVWJIVI3Rs1KBwl1mpNJ3gi8Bu--
