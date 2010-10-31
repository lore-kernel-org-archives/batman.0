Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 31 Oct 2010 16:55:40 +0100
References: <201010240313.35215.lindner_marek@yahoo.de>
	<201010301414.06280.sven.eckelmann@gmx.de>
	<201010311610.42160.lindner_marek@yahoo.de>
In-Reply-To: <201010311610.42160.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3366755.zNLYd13i92";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010311655.42310.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway handling
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

--nextPart3366755.zNLYd13i92
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> > > -                             char *buff, size_t count)
> > > +                            char *buff, size_t count)
> >=20
> > Why was the space removed?
>=20
> Should I move this into a separate patch ?

Sry, my fault. just forget it :)

> > > +               if ((strnicmp(tmp_ptr, "kbit", 4) =3D=3D 0) ||
> > > +                       (multi > 1))
> >=20
> > Why this indentation? And This should be on a single line (or I count
> > wrong).
>=20
> No, you are right. Will be fixed.
>=20
> > > +       if ((gw_mode_tmp =3D=3D GW_MODE_CLIENT) &&
> > > +           (atomic_read(&bat_priv->gw_sel_class) =3D=3D 0))
> > > +               atomic_set(&bat_priv->gw_sel_class, 20);
> > > +
> > > +       if ((gw_mode_tmp =3D=3D GW_MODE_SERVER) &&
> > > +           (atomic_read(&bat_priv->gw_bandwidth) =3D=3D 0))
> > > +               atomic_set(&bat_priv->gw_bandwidth, 41);
> >=20
> > Why setting that here? And why do you set gw_sel_class here to 20 (if it
> > is 0 before) and in softif_create to 0? Shouldn't it be set to 20 in
> > softif_create instead?
>=20
> The general idea was that if somebody activated client or gateway mode
> without setting gw_sel_class or gw_bandwidth to any value, it would use
> some default values.
> Moving these checks into softif_create() would only solve half of the
> problem because a user could set these variables to 0 and then start the
> client or server. At least the client mode requires the gw_sel_class
> variable value to be greater than 0.

Isn't it limited to 1 by BAT_ATTR_UINT? And if not (which I doubt) wouldn't=
 be=20
the user still be able to set it to 0 after he changed it to client mode?

Best regards,
	Sven

--nextPart3366755.zNLYd13i92
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzZF9AAoJEF2HCgfBJntGYw4QANO+Gj4rLWojtCM/hb7Su0Uu
X1qwbl77fedYDK7wr4RxgVwCsbCbxEQoB46BHYLr+uANqlKKSl9fE9QZHVNN07q1
XimITAUQGHoEbbQujosIDgZpDtcX04o7F2IdGTSqqwAV3OfTu85v1VrHwsmlc4wq
sqGG7v3y9fbQVZ4j2TUPMkC1CgSJ7iASfyr4vMqCGMjznyFCDq5yqRAUmmTxTKkw
L1uZ4qWcj7VvkRuDGfUYSFtxXsE9bn38CR+H9QdbwenbhhjgwQmpm5DFhQMLvLWF
uv1AtYzjYWet0aFE+X/KxHV+LU0RpW5EOkqSCr5uySBOO7osQp222AS5hEV31Cz1
5W6rF2aKam4/uZ1b3J1cvOBWA8zPu6xvEuACGuNBT07V48ZcDiE3ROvw++5U4K8t
ml/aw4R15y68B+vhEGQi2Obo9KiOxGPfwT3yLyCpPnKCCp9Ona/hWnzvPaCEtgyE
GGG/HxFDifXwuBRGA1IhMmpkdbCnVh88fySziOW4NctPGknnygxmTkH1YPmE3xf3
VNmI3zbBdClZnlaGjsvrq1CF9SHpqh41IjsIWD5/bMo333Dggg9expSApzqE8i+w
Y2fvhRmPB6qb8lmNRJpzLktPm/43zxg43CJ8JFqusXiePwZNFZQVOdANUAjXWdI2
wETYjKbBjThmBePzy958
=NuK2
-----END PGP SIGNATURE-----

--nextPart3366755.zNLYd13i92--
