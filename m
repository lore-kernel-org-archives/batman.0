Return-Path: <mschiffer@universe-factory.net>
Message-ID: <53E37C90.8020802@universe-factory.net>
Date: Thu, 07 Aug 2014 15:18:08 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <53E274D5.1070008@jluehr.de>
 <201408071037.36351.sw@simonwunderlich.de> <53E3725F.7030709@jluehr.de>
In-Reply-To: <53E3725F.7030709@jluehr.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VMEqtCwxBABnXjw8fmV4pNTIcBn1bdOT5"
Subject: Re: [B.A.T.M.A.N.] alfred: IPC issues
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
--VMEqtCwxBABnXjw8fmV4pNTIcBn1bdOT5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/07/2014 02:34 PM, Jan L=FChr wrote:
> Hello,
>=20
>=20
> Am 08/07/2014 10:37 AM, schrieb Simon Wunderlich:
>> Hello Jan,
>>
>>> Hei folks,
>>>
>>> I'm using alfred 2014.0.0 on OpenWRT Barrier Breaker.
>>>
>=20
> I'm not able to reproduce this issue using 2014.3.0.
> I'm not certain, whether 2014.3.0 is the cause.
>=20
> Greetz, Jan
>=20

I think 2014.0.0 had an FD leak issue, which could easily cause alfred
to exceed the process limit (which is 1024 FDs on OpenWrt) within a few
hours. As accept() needs to open a new FD, this would explain the issue.

Matthias


--VMEqtCwxBABnXjw8fmV4pNTIcBn1bdOT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJT43yRAAoJEBbvP2TLIB2c9DMP/ArJvwODbVP7golR3zg3j39e
uXCsQ2ojXE7y8iYw1AC6jjHBmPwa7kl9stLHJJQXZ6XqXty5oyTWSgZOztBQmTwy
z4u0OITtpbkTCDpALicfeqtH7/qLJStbvMPr8VEgtYad+7LD0IQjDQ8cX5jz9XSd
hFHJDfIZXqiuI+PuYK37mZGo9VzxCJNVd481I6KCtMKV/QuGKqXhSBbFciub9pY4
ADJYVPOUz+bTz5nvSsbxoPqDSDuENdsK/KQPXWNgLEyoaFw+DsEzzVpJ+odQwvdc
K7fjKPRFroMUIV3SvRldDpsw2+HPswV3UgYSSymMLruYi48iEOn3C/Y7oz6iKDTW
t7D0Fr4fw3fa9x/h704c0smuBhO+annXlzxJEEBghlYfVAWabjxbh56wrWtlMJ4M
+dCQBfIEXrXPOTwuYIm+LU0b0qWvpgcAnhxjtiLD1KjaXoO8/2oWI7ory9UDPN1W
yPQObsDaza1Zs58a2iICwc+Lr2UjI/rrZSMIJTsv5vpb9TW5mj9FOQNXrVbxb9GN
vl5HBd7SXCFEebGO/H20qNNq+j6yeNH0SVz2ftpgcj8bxcmOe9nE0Prqw5CBfpaA
sXNcaXYS0HnI00/rBYtYjm1oHW6Yz38CHItpTymkA86GpH/MRUrFmQ3wkCw/EXnI
5B6p5mhBbpTHxhIywlct
=d0OI
-----END PGP SIGNATURE-----

--VMEqtCwxBABnXjw8fmV4pNTIcBn1bdOT5--
