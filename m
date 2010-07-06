Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Jul 2010 16:03:43 +0200
References: <20100705234246.58a9209b@rechenknecht>
	<201007061157.12304.sven.eckelmann@gmx.de>
In-Reply-To: <201007061157.12304.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4100270.pzNqaQzic1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007061603.44856.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman adv unicast fragmentation (version 3)
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

--nextPart4100270.pzNqaQzic1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
[...]
> Now we would have to fragment the fragmented packet again... which is ugl=
y.
> But to be honest, bat0 in a mesh which supports fragmented unicast packets
> is hardcoded to 1500.

This was expressed wrong. The min_mtu of all participating interfaces (whic=
h=20
is used as maximum mtu allowed by bat0) is hardcoded to 1500.

Best regards,
	Sven

--nextPart4100270.pzNqaQzic1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMMzfAAAoJEF2HCgfBJntGcacP/1dhbURvIgomTG1+621B8Fkw
5SOoH3ggA6dgAF49b7p6oUIuq5Bje+CUj1VqgKQJLYUZlWTwvg2wcLcZrg/i7Ao8
LWMEgOMkVzQbP+zz3r+skqgV3fEFhb2lu6Q9XJ9knrtGxNagyFSvGsfcVQb8ejY8
1NQ6BxwiWjvfEmDBtBnXnAvoC+w6M+Ll5dY752aOYmdENesAfym0ENKx6O/xYTVb
q6UZMB5H6qV0tu45qwi3+5PZwebRdb42f7FUVH8LmruTecJ0jQJ2rpJBSAeR7eox
JP0SlzBcBGhkEZWrYPdwjR4Hr1wRXay5ByWCE9JooNhZSsoylM9gOWJOtfN/i+Cd
3mcFxtKrGFzwPxac/hr85e3pHzRIhsdmBAvWcuTRYSMUjjEO3nrRlnAbUDO0rKv+
KFdPIAQoacWitNf5AFR0Jwh8codCyb/oIyMr2ELjTBIqQLwbsoh8tG7P3I+nrmgk
IxuG1PGSNXbWwvXEHARHNEapHhLwVPWqC7yDQXa+cMS1VEb680dRbwGKZ2yNrUFY
ipt2Jtyk9xDGx5hb/lO/EzYUtUcL3IHkF54fdLpi4TiVbUOkyvzA75K45us4WnL6
9VmqZkaHd2O6Vdn27yvvlOA6fzcC1R58wXY9L3moyctdreSre87xsGHZFADhq+xu
u7Fu6Jsm4zemYS5tFpBh
=GW7W
-----END PGP SIGNATURE-----

--nextPart4100270.pzNqaQzic1--
