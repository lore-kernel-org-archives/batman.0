Date: Mon, 16 Jun 2008 01:09:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Error " LibG3D-WARNING **: no handler for file "
	with meshs3d
Message-ID: <20080615230900.GB9736@hrz.tu-chemnitz.de>
References: <c1004cd20806150724t747078ag6dc16415b00a22f3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <c1004cd20806150724t747078ag6dc16415b00a22f3@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

you're probably missing the plugins for 3ds. Libg3d has a main library
and is "outsourcing" file-specific handlers into plugins (e.g. for .3ds
models), and maybe you have not installed them.=20

best regards,
	Simon



On Sun, Jun 15, 2008 at 04:24:09PM +0200, thomas anderson wrote:
> When i start meshs3d i can see the ip of the access point but not the ima=
ge
> and on shell i got this errors:
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> 'objs/accesspoint.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> './objs/accesspoint.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../objs/accesspoint.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../../objs/accesspoint.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> 'objs/accesspoint_inet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> './objs/accesspoint_inet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../objs/accesspoint_inet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../../objs/accesspoint_inet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file 'objs/internet.3d=
s'
> found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> './objs/internet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../objs/internet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../../objs/internet.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file 'objs/btn_close.3=
ds'
> found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> './objs/btn_close.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../objs/btn_close.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../../objs/btn_close.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> 'objs/s3d_berlios_de.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> './objs/s3d_berlios_de.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../objs/s3d_berlios_de.3ds' found
>=20
> (process:29085): LibG3D-WARNING **: no handler for file
> '../../objs/s3d_berlios_de.3ds' found
>=20
> The file are present in that folder but seem that meshs3d can't find it
> right?
> Any help is welcome :)
> Eidos

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIVaEMrzg/fFk7axYRAhX0AKDewj9sHveye9UqqB2YlkZgyDHKowCffMKR
24qhCkk1aI2CVmeBcWIMrFk=
=X2ri
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
