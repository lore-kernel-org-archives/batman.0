Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-11-git-send-email-sven@narfation.org>
 <5693D141.5080900@unstable.cc> <4025424.ueLjcNil9i@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693D29F.8010601@unstable.cc>
Date: Tue, 12 Jan 2016 00:04:47 +0800
MIME-Version: 1.0
In-Reply-To: <4025424.ueLjcNil9i@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K7Wo0Thv6GNuKpviei7RuptIvOVGsDd95"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 11/31] batman-adv: Drop reference to
 netdevice on last reference
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K7Wo0Thv6GNuKpviei7RuptIvOVGsDd95
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/01/16 00:05, Sven Eckelmann wrote:
> On Monday 11 January 2016 23:58:57 Antonio Quartulli wrote:
>> what is wrong in releasing the releasing the reference to net_dev insi=
de
>> the RCU callback (except for introducing some delay) ?
>=20
> To quote my may to Linus about the same patch:
>=20
> On Tuesday 05 January 2016 10:18:13 Sven Eckelmann wrote:
>> On Tuesday 05 January 2016 06:02:08 Linus L=FCssing wrote:
>>> PS: Just to clarify, patch 10 is only a style patch, right?
>>
>> Yes, it is more a style patch to make everything more consistent.

oh I missed that. Thanks for pointing that out again!

Cheers,

--=20
Antonio Quartulli


--K7Wo0Thv6GNuKpviei7RuptIvOVGsDd95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk9KjAAoJENpFlCjNi1MR/lIP+gMg8ZzwB0y4+o7h+QO874Cu
7igxEGmFhUM0mSROEbJcPnDmkksqhKU57icSWmcrxlCwDyR10ZhBAQgZk8B09RSu
kwpadcqBviB0/RIHS/32O/aOGKbZRI5KAmrWCx3LFCFcNPUdqtFrZhVecCm8624E
7cf/dmajayAUQoYQkj0PPJK1J4rWlfxQMFOadab/SFNSHvW9C4hDJ8KkdkCf7eql
JtUWdi+XvJgQiRZYZbIz06f1WjnWf5CGa2tvqQk1zbdfVbx99LW2qAH7WkfDbzNi
AHY6mbt8o5oM964DVy1XFaRdNsE3FEsCZY2PZWkXGv4d2owBVOU7tWID+6cpekjE
esSs0QlO3SUHplPjm36R+5EZtcg7LvZV96X9JnXT9BNPjHoX8Rc+Wq+LV13Wg9I1
M6qXptWpZtLXvQeiQ/5ospDoGOAXSf1G6dJNrOmxUCuHJ6UsF4/+BW/TOs0fXYcD
LU4fRep/n/6J1QsEzVNZ+ltE2mZsRaGpCbT6PVHxQHdUkIGU+asqdNBVF3hyHWjT
9iyfwi06SfkjOwuEbVTGdEq6upeP+3kqGprYrE68gHe4MBqjP6DeFpXJewtjIOS8
TyTF2Rz8vBhOjSCfwMu+1TKBWLzj+OqlylkzdtjSEPf1epdicGGaZVXzR3Ion8nj
+4RPkwxMGLn3xYLUWKkE
=VBJx
-----END PGP SIGNATURE-----

--K7Wo0Thv6GNuKpviei7RuptIvOVGsDd95--
