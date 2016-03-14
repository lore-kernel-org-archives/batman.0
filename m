Return-Path: <germano.massullo@gmail.com>
References: <CAGa=++Q48GRsxuqchoWqsgjxz020eyRub0+vertAN2brzRy3HA@mail.gmail.com>
 <1817507.YIectHPgqy@sven-edge>
From: Germano Massullo <germano.massullo@gmail.com>
Message-ID: <56E73211.5070808@gmail.com>
Date: Mon, 14 Mar 2016 22:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <1817507.YIectHPgqy@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aU2ucaUdEsAGXu22nTwSLqESf5XpI02wP"
Subject: Re: [B.A.T.M.A.N.] Creating alfred code documentation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aU2ucaUdEsAGXu22nTwSLqESf5XpI02wP
Content-Type: multipart/mixed; boundary="5f8cbbOxP2DRkektoUkVLqw8GPQCwUqIR"
From: Germano Massullo <germano.massullo@gmail.com>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56E73211.5070808@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Creating alfred code documentation
References: <CAGa=++Q48GRsxuqchoWqsgjxz020eyRub0+vertAN2brzRy3HA@mail.gmail.com>
 <1817507.YIectHPgqy@sven-edge>
In-Reply-To: <1817507.YIectHPgqy@sven-edge>

--5f8cbbOxP2DRkektoUkVLqw8GPQCwUqIR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Il 12/03/2016 18:55, Sven Eckelmann ha scritto:
> I am currently not sure about the "explaining also most important
> local variables"=20

For example in the function

=3D=3D=3D=3D=3D=3D=3D=3D=3D

static int vis_read_answer(struct globals *globals)
{
	const struct vis_print_ops *ops;
	struct vis_v1 *vis_data;
	uint16_t len;
	struct vis_iface *ifaces;
	struct vis_entry *vis_entries;
// CUT


=3D=3D=3D=3D=3D=3D=3D=3D=3D
I would stress the purposes description of
struct vis_v1 *vis_data
struct vis_iface *ifaces
struct vis_entry *vis_entries


--5f8cbbOxP2DRkektoUkVLqw8GPQCwUqIR--

--aU2ucaUdEsAGXu22nTwSLqESf5XpI02wP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW5zJPAAoJEIq8nrxQ7aiETqYP/AwkNT9YVk1iryS0zr3EIbPs
do3vpjlnHo2CKejdVPbupafWAUohHq/QMtimcOxP56KRd4ExxujYZdW4+VTS1jFt
dXGBWv0vd6SEEQFhhB4ZI1zZOHmw91F/1qW9yyjgVOcN/R6mfUa+iSoubZqPBpok
QchCjgbd9fEGUbBg5q6bJJ+DJq3FMACPPIpkTtyxoEzmeFup8yu/HLNa9YAIGPc9
X2wnOIrQUvkHdeWJgN/VBCy+B+t9ixusDF6vySGWu5L+VxEcUmoAYLvcQ4r5IHEj
RcO+XHYnkarZYX/FcCPVFXESxwH81IoFF7reyYWL8CaL9VfHCblPUN1JORYor+05
VKSaCmO/bxyCZqX1EEM5BYaniSmoONYPUPgX6wXSBanG+7AUOKY+Ojvr076hW/sH
mINJDOAzZwWgBCVmbDv6jI1K5WwxE5pefvqJnQ4CFI2tJ/tz2NY2EGzSYKEayDE4
mqOT3BMl9FUDL/0fZfyJo5LWM6ZvC57bdg2kDaezxi0I/Co0qT0yaera6CLLjBhy
WBktI5LiElEcilYw99rzJqVqzlURk2pFO5pJ2LDd9XE1iwvoTBJ4Hpz1r2RMNr0P
oL4tgEqm2uUML/HzJFKTFpWjwBhqF+VGzNuo1IEexG2FbwLS9DErhT/2x6jskPC+
C6/5VjbXbokbFAtiYXxL
=JAZo
-----END PGP SIGNATURE-----

--aU2ucaUdEsAGXu22nTwSLqESf5XpI02wP--
