Return-Path: <antonio@meshcoding.com>
Message-ID: <52D66DE4.3050300@meshcoding.com>
Date: Wed, 15 Jan 2014 12:15:48 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
In-Reply-To: <52D66D45.4060301@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fGC89aTKoLUEAwvQGpEkaljCsgEhMfdNM"
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fGC89aTKoLUEAwvQGpEkaljCsgEhMfdNM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/01/14 12:13, cmsv wrote:
> inline:
>=20
> On 01/15/2014 02:00 AM, Martin Hundeb=C3=B8ll wrote:
>> Hi,
>>
>> On 2014-01-14 23:04, cmsv wrote:
>>> batman_adv: bat0: The MTU of interface adhoc0 is too small (1528) to
>>> handle the transport of batman-adv packets. Packets going over this
>>> interface will be fragmented on layer2 which could impact the
>>> performance. Setting the MTU to 1546 would solve the problem.
>>
>> Did you enable network coding? That would explain the message, as NC
>> uses a larger header to make decoding possible at the receiver side.
> Yes it is enabled by default as it was with batavd 2013.4.0 with 1528 m=
tu
>>
>> As far as I can tell from a quick look in packet.h, the required MTU
>> should be 1532 now. (10 bytes unicast + 8 bytes extra for unicast_4add=
r
>> + 14 ethernet =3D 32 bytes). Or am I bad at counting bytes?
>=20
> Regardless of being properly counted or not; dmesg outputs the message
> complaining about the need to make mtu 1546.

If you disable network coding the message will change.

The overhead is dynamic depending on NC being enabled or not and now the
message in dmesg tells you exactly what MTU you need.

Cheers,


--=20
Antonio Quartulli


--fGC89aTKoLUEAwvQGpEkaljCsgEhMfdNM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS1m3nAAoJEEKTMo6mOh1V7AEP/0fMyJ3anwKFS+K7dT44ddLJ
QiPqzpuRPN3GMNigvlOfrfzMX3XDsL8kCKSSVO8aKIWVCOfY4mP1ygqlS0x8Zo9V
TXJgnO9QZj4ba0yJC4yg30yGate21sT4Sn0tgrEnG2HKTZzIqin2E/UfoUKl8hGi
fxMz37z4JHBkEQE84FUbgagHXeewKTS4/9ZHP+xYhlhYCCVmCWgBp6yU45Oas40D
SBiFTyef9tN5zIlmxH4Syl+Zfxp/MXFA01S3bZ30DBJvssJH9t+0Zrc1VP+4FZPV
Q8b3VVvGO04trTXMXYdCfXbT/9U3Zi/jdZBSALGhlVUr8e4Qhg5xMJuhnRCx7pB8
wOaAQzboTDtKSFWZ4EiZF77ubZZftCBOupn1+4jj2VdFmeH+30wqRs+jDIqHYWNS
Gk7V+OiMxWTiAWH+pcMS/inzd/xLj/jbw3dtUbTqRU6IN4rCx0qS4UsFxJvSyo29
eQMDafltD74pjtOYd9oZ4QwCb75t1BVYkRqSicJMwQtgOvwqQ4XWnOtAM5yb4yYk
aNnCpVdkdWW1t71PLJ5DU1SFFSOtKFjI2s74hJmdCo0P9lR/R0cHGAaU8EmDYVZ1
VXEOZgSGfDMsNDEpt9HvSqe22othBi7wOhEAMMHcOhkytUJM/AcmOf48015zdrDG
s3WBJx23pMIRcE7Nw9SW
=U6Qe
-----END PGP SIGNATURE-----

--fGC89aTKoLUEAwvQGpEkaljCsgEhMfdNM--
