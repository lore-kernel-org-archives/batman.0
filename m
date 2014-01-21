Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52DED209.5000207@wirelesspt.net>
Date: Tue, 21 Jan 2014 15:01:13 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com>
In-Reply-To: <52D66DE4.3050300@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KgjeSnopfo7BWjj8gmgep57S3EDAM8Xva"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Antonio Quartulli <antonio@meshcoding.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KgjeSnopfo7BWjj8gmgep57S3EDAM8Xva
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 01/15/2014 06:15 AM, Antonio Quartulli wrote:
> On 15/01/14 12:13, cmsv wrote:
>> inline:
>>
>> On 01/15/2014 02:00 AM, Martin Hundeb=C3=B8ll wrote:
>>> Hi,
>>>
>>> On 2014-01-14 23:04, cmsv wrote:
>>>> batman_adv: bat0: The MTU of interface adhoc0 is too small (1528) to=

>>>> handle the transport of batman-adv packets. Packets going over this
>>>> interface will be fragmented on layer2 which could impact the
>>>> performance. Setting the MTU to 1546 would solve the problem.
>>>
>>> Did you enable network coding? That would explain the message, as NC
>>> uses a larger header to make decoding possible at the receiver side.
>> Yes it is enabled by default as it was with batavd 2013.4.0 with 1528 =
mtu
>>>
>>> As far as I can tell from a quick look in packet.h, the required MTU
>>> should be 1532 now. (10 bytes unicast + 8 bytes extra for unicast_4ad=
dr
>>> + 14 ethernet =3D 32 bytes). Or am I bad at counting bytes?
>>
>> Regardless of being properly counted or not; dmesg outputs the message=

>> complaining about the need to make mtu 1546.
>=20
> If you disable network coding the message will change.
>=20
> The overhead is dynamic depending on NC being enabled or not and now th=
e
> message in dmesg tells you exactly what MTU you need.


Yes i understand that but it keeps on increasing.
[   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is too
small (1546) to handle the transport of batman-adv packets. Packets
going over this interface will be fragmented on layer2 which could
impact the performance. Setting the MTU to 1560 would solve the problem.

>=20
> Cheers,
>=20
>=20


--KgjeSnopfo7BWjj8gmgep57S3EDAM8Xva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS3tIOAAoJENmyd4cVxLOC40MQAJuhYpH5N7Agcr1Cksn/deOb
54ZBJRH7OJb/2bpVA5k9v8n2hehqMnn95Kae7mEor11YjODtntZZEUhIA65VU+A5
ou5YrKTEKvJe1jHxl9tWk64VmWfq62g0Bap2t2TtEZwBFfUmIcmNbcfIgLtC1n0a
QRzbAhiKbneOWlcrQU7ROKbw8Anl8ABIE+XxSw8zjtYct7m7VqF/d8HjP4OXB7kn
jmvIV9V0gdSLGBnzSbQrimOurMIqHdj277IVbgxuTEo/eYQv/dJZVoGpyIi6qlNa
On9OZMcKfZcQ8sRQPONYrhfLVszWXaiPxWcn+VO9pThAL6VNamikt51RGqLNt6x3
N68Pf3vUt6s3cHxnIogMDJkfNpjFHZ2uncQXsIsLDmYJn0C4AFyIvyxY68nfArAo
yAPxgfJpBnQh5Oaz+DwhwOne43nZ6YBoJuEWX0MpvbU39epRWgVA5a46wmupLwOf
7DHoXrJD8hsldDOK89eDS5de/Umx+Uibcx8RnA7twRGPmxMWyshoQ2sqck5ndzqQ
U7s0SwFwjNWZslfYiV4OYZOo+RAk7Wj5QF4RIcak7STi8nPdrwatisQ86qwhT8FU
oS3w5p/lCRwLFuxpIQM5c1N4OuiKq78VmnUvH5PJmxaRvoAukdZf+3Xs+QN0M3wV
tEkZYp0TGvV6C3nX1RL0
=SGyH
-----END PGP SIGNATURE-----

--KgjeSnopfo7BWjj8gmgep57S3EDAM8Xva--
