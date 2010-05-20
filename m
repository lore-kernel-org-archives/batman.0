Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 20 May 2010 19:00:01 +0200
References: <4BF56357.3000208@tiwoc.de>
	<201005201851.54709.sven.eckelmann@gmx.de>
In-Reply-To: <201005201851.54709.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2251512.esiSU4xTcy";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005201900.01910.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Correct mdev calculation in
	ping subcommand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2251512.esiSU4xTcy
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Daniel Seither wrote:
> > Fixes the calculation of the mean absolute deviation (mdev)
> > of the roundtrip times. mdev was previously calculated by
> > computing the difference of maximum and minimum round trip times.
> >=20
> > The calculation is now done using the same formula as in the iputils
> > ping program.
> >=20
> > Signed-off-by: Daniel Seither <post@tiwoc.de>
>=20
> Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Ok, have a small suggestion. Please check that mdev - ... is positive.=20
Otherwise we would have something like (mdev - avg * avg =3D=3D -0.000.....=
,=20
sqrt(...) =3D=3D NaN):

PING 02:00:00:00:00:02 (02:00:00:00:00:02) 19(47) bytes of data
19 bytes from 02:00:00:00:00:02 icmp_seq=3D1 ttl=3D50 time=3D0.10 ms
=2D-- 02:00:00:00:00:02 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss
rtt min/avg/max/mdev =3D 0.101/0.101/0.101/nan ms

Best regards,
	Sven

--nextPart2251512.esiSU4xTcy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9WqRAAoJEF2HCgfBJntGAGAQAKqFdBSXFFkihHkR65+cAuMQ
wuYzG+HprZxZS8Vumyq6CEbil/6hmCcIHi5cD5+xN2fflSFcWHsvvoUSXLvZETYf
kXAgs2hM2wy1FCVF14241NJ789NeRd8o+NRlcIFdNGZT8R6EchJh01zJRj8wZOGA
+eZ+9PcjW+BhVWJj+kq+egOyCWynyDVs+Pqtvb588OMb9/Y5aVmnp8haDeYO4WfX
mSbvkFVX3fq745TMw7Lll2AdhPaRQtYraXd+y/VKcH0P9sbyRgceeO9EEO/ClpSN
uV5VpGh0G1kLaUJGXTPyKy0fwZ/loYgbdZ++Taf8ctEtKIC18Uo6rJAn7C+uWan/
MDusMdIid22NmrC691TCDlwW2j7ij5+YLoqrKlvbR7XfdE92A07t9zLca9qZ9xeI
pvl0vVHKU3ZbfWfmmFjDrtulH94XnQPayXeNOwz1e7MgBtKQ884Mf7fM1IEw+tyi
GEraGOJRD2J9+lYRvzex570b2FhP8cD0Rq4c/o7mExjiNG015FRDuCLEs7nPna2u
jgQVS2SWxI5OVDYkDnfufnPXt6k+Js/26A8H6uu0WiORwuNNdrJV6sAMgkwuvdF4
NCqQ8o4epPElbyXaDbvxhKQQhCPVrSD2EkJPvL9I1HKd2IFBX5ErsBjqnMALHJCo
xI1ShPPdapYu5FqyyYDX
=e+Lh
-----END PGP SIGNATURE-----

--nextPart2251512.esiSU4xTcy--
