Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 25 Jun 2016 07:34:35 +0200
Message-ID: <15442021.aXYrkMLT6N@sven-edge>
In-Reply-To: <0F40DD26-09F6-4ED6-B0BC-7413FF5ED713@gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <24448293.C3avDh6gQR@sven-edge>
 <0F40DD26-09F6-4ED6-B0BC-7413FF5ED713@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1487827.zuJrLTZE4p";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sailashm@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1487827.zuJrLTZE4p
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Saturday 25 June 2016 10:04:41 sailashm@gmail.com wrote:
> Hi Sven,
>=20
> I will give it a shot on monday and let you know. However, when using=
 the=20
BATMAN-adv in my 5 tplink routers, the AP interface keeps disconnecting=
 and is=20
not stable. The version of batman-adv is 14. Is this version of batman-=
adv=20
unstable?

batman-adv with the COMPAT_VERSION 14 (used in v2011.3.0 <=3D batman-ad=
v <=20
v2014.0.0) is either really old and unsupported (it has known problems =
which=20
fill not be fixed by us anymore).... or you are using batman-adv-legacy=
 [1]=20
from=20Matthias Schiffer. If the latter is the case then please upgrade t=
o the=20
latest version from him, test again and then contact him when you need =
support=20
for this version.

But to be honest, batman-adv is not managing the AP interface and thus =
it=20
should have no influence on the AP interface authentication/deauthentic=
ation=20
behavior or the AP interface state.

Kind regards,
=09Sven

[1] https://github.com/freifunk-gluon/batman-adv-legacy
--nextPart1487827.zuJrLTZE4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXbhfrAAoJEF2HCgfBJntGpU0QAK61D7AhYD8gakquAacU+NNb
3+tGjA+2A+d6/qlvXlSL5JvhmPYZ7SNPnBmLvRg8CX559yUVe3nUhnm80HDTOsso
I7EZsTuD0DtsoXsZsRJZpyxebh0hc2n3fbZoM7noCzFbwj7d9uTCvXrr7fB5zjYS
8O2jbsHnL9IUGwD2w+1KcTcGLOXn9CWunIPImfk/2XEPQOnN/t4gD6mogFb59Hul
z4OrZf8uzbX8TF+MEuYVJH+TyBT3tbWGN7nsUAzrmg56LZTB/m/fRlUaxA3DaqH4
vea1MvSCFsgZ0T+TxmX596U9F0PStMVXpIUjQM+fzNM2BA+oxDkB/8VxRPBzJKa2
+jX/jtMa3XrdaR6uqdu+LM5BPy3r92GSVJhRAzf7dL+/cjLdPXjPIL6lXmOPKeKk
UlJlbIP+g1IBfG3++2kmQTrkDTIicsIu2MiN14StDDHSU7qv8suktyxbtiNju708
GR1AJguBhBfNy/xOLb04mPah2yfnRAqfjooR+ShkGGHOpX7DdFPh4g0eVGvrdlhR
kfWpn9op1tFqwUZaOxPb5QNg+MyMf6Meji7aiz/T9k0I0UBD2fEgh0KvuDQCI4ER
BpQZkrCP56kdFmfnFuWz767Jj9gPNSg602cRPpI7ib61PHlpDZIKcOpF5EgJrIUR
omZKyS5ckBN8XLsDTMtJ
=zaIN
-----END PGP SIGNATURE-----

--nextPart1487827.zuJrLTZE4p--

