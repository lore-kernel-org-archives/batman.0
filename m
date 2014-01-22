Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF0ECE.7000707@meshcoding.com>
Date: Wed, 22 Jan 2014 01:20:30 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com> <52DF0B77.3070106@meshcoding.com>
 <52DF0D4E.5070207@wirelesspt.net>
In-Reply-To: <52DF0D4E.5070207@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3JOU4POfScm1lJSr9ktD7vBGcPX5U6CFH"
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3JOU4POfScm1lJSr9ktD7vBGcPX5U6CFH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/01/14 01:14, cmsv wrote:
>=20
>=20
> On 01/21/2014 07:06 PM, Antonio Quartulli wrote:
>> On 22/01/14 01:00, Antonio Quartulli wrote:
>>> On 21/01/14 21:01, cmsv wrote:
>>>> Yes i understand that but it keeps on increasing.
>>>> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is too
>>>> small (1546) to handle the transport of batman-adv packets. Packets
>>>> going over this interface will be fragmented on layer2 which could
>>>> impact the performance. Setting the MTU to 1560 would solve the prob=
lem.
>>>
>>> Have you tried applying this patch before testing it once again?
>>>
>>> http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c1cb3=
b27af0614510368bb7
>>>
>>
>> Actually this patch is already part of the batman-adv package in openw=
rt.
>> Therefore the question turns in: did you update the batman-adv package=

>> before performing your second test?
>=20
> the second test was done today and  yesterday's i updated bataman-adv.

Yes but we are creating confusion.

In the second test you *enabled* network coding, therefore it is normal
that the overhead grew up. This happens because NC uses more bytes for
its header.

If you disable NC the suggested value should go back to 1532.


Cheers,

--=20
Antonio Quartulli


--3JOU4POfScm1lJSr9ktD7vBGcPX5U6CFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3w7SAAoJEEKTMo6mOh1VB+sP/RAurAPxklzV3uvary46SRAQ
9I+faXAHOSbrCJ6w1C8/t18u23Ma0w+AJNLn5hBSDcIF/XzptMQfV0qwdu3BygDG
/Y2+nVwsDr/x477GSseLmoNmId8uymZArZvMTT8GBlq7vGRYUGqyHK2SJiXlL/Bq
8f5HN5khmHo7zLcL1Y5mgal2jzDvG5HDkT2R78xtl9y6yt85iqb57DHkQiYCpBPX
sxmRNFqAvb6CFxi1AlSNWKstUBY/mkMYzb4bAxo4CH1ASdNeFvfHjfXBECw3BcOG
EjSqnrw02+rQ3klEdw+cKpH+OjEsgEFUK6hyhX6j00g7f4qvIkz4NKBVYrnq0ZRC
mhVAfxUgqEFs6cUiBfP1tVBcGHmSWA5d+m1cuNvlX86XBk8fRWnDXCwcNB0Uj8OA
U3B1ifPowkOyJpFr/5nmmQF1a8jgvEGprBVtc/+YsuX9o2LorSWCxtwVGXGqyb3b
i/ykMyqn3Zct5RAnLqLK+UZRA9G1CwhSjpBRcWYHFW/tCzIBsB/7+noShq8feYCz
vJWDwF4gaEy2XQPvHRPXzMuW8uKx1S6JV8ng+zQM8zTOiXvcYoil7ggS4q2EGYxW
LqWVml5BtgMwOE/0L8uG77YbIXB9Ynh7/jZmwJK93zL3XYAzYiF9dXUjS5v2Id43
ZBj0zR7SdWyze0WSzi8B
=NR4D
-----END PGP SIGNATURE-----

--3JOU4POfScm1lJSr9ktD7vBGcPX5U6CFH--
