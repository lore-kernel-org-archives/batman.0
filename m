Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 9 May 2010 16:58:39 +0200
References: <201005091117.05627.lindner_marek@yahoo.de>
In-Reply-To: <201005091117.05627.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28303716.FRVRpzsZ2E";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005091658.45998.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] sysfs abi documentation
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart28303716.FRVRpzsZ2E
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Hi,
>=20
> Greg asked us to provide an ABI documentation for the files creates in the
> sysfs tree. Since I am respsonsible for the sysfs stuff, I felt it was my
> turn to draft something. Please check the attachments and let me know
> whether you think we can send it or not.

I've read a little bit through the different descriptions and it sound good=
=2E..=20
for the reading situation. The problem is that it is nearly never clear tha=
t=20
you control the behavior of batman-adv through that specific file. For exam=
ple=20
/sys/class/net/<iface>/batman-adv/mesh_iface - I think it is especially=20
important for GregKH to see that it needed is now associated to the iface a=
nd=20
we attach it to the mesh_iface through that file when he should give us som=
e=20
advice what virtual fs should be used for what kind of information.

Best regards,
	Sven

--nextPart28303716.FRVRpzsZ2E
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL5s2gAAoJEF2HCgfBJntGxREP/1F3ufviGbgj2PyXIu5kql4V
7JVCqXjFEw5l6Pp0szthVTnua5FGg7PEHkLFqyZSMZEpN7zPbYKdmMJkcQUSzzm7
yd/wHsIKV0c803ApDmznATnX23dGaHZJdjF+RqrTUoYlwFSiDDLdzUxperSsVgKV
5Y0IKAV/ZDqyLktocBXS96ohhH6asWf4Z3Cb/zt6Vo2dW0L2yqMZOb5aRgcc7HLp
EhZfo8TfZHIjLber/F0kMRlDQZHv3uR01AgkXVGOrGkxgQX+ggpDkyJ7EmiYW05R
Hnl2w+1yIN/BWOyZXmOTh7A5milOWkE2B6GDg5KOF18M0/XqlzgTZqgbTLm83Npp
+NRzW1pzw1KY1OV118l/cDkLjNYjTh5eGZEDEQwAy9oCqM2XzvvQcXoLZWOufIdS
Nfl11wnnpiB9oaxTPNDUCAzqxB2RdKmMHKxXHiz735SueHVEABB0IrwD6zTmnQ4l
KpMDxTd+Z3q8ze5ZDKuxSpJRsIKqcYBDfOvT19vUR5Ug6FVo+kOlOhhDQ816Hqh3
mfGolqtIiAAKpZgScrLgC37BX8T7wJBOhNOFSq9QITQSpoELjvx0XEzhf8uXtTTZ
Bu+nGurVP8zdrn2nOexKTvuvrLjj2R3hQAm7wSPqIoL/892gz8x06Ukx5O2a9HcN
hPY0/NPDhwoKJd6gvZoY
=FyS3
-----END PGP SIGNATURE-----

--nextPart28303716.FRVRpzsZ2E--
