Return-Path: <antonio@meshcoding.com>
Message-ID: <52F92F2C.3040305@meshcoding.com>
Date: Mon, 10 Feb 2014 20:57:32 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52F92C47.30400@wirelesspt.net>
In-Reply-To: <52F92C47.30400@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1J7HmaPudOVksFFsS4pMAmOeL3mo5cBRM"
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1J7HmaPudOVksFFsS4pMAmOeL3mo5cBRM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/02/14 20:45, cmsv wrote:
> In regards to incompatibility with pre-2014.0.0 versions; will 2013.4.0=

> branch have any continued support with patches or even updated version
> or any support pre-2014.0.0 is not expected or planed ?
>=20

The core group (read: the most active developers) are not going to
maintain any pre-2014.0.0 branch. The code base in 2014.0.0 is rather
different wrt older versions therefore any "backport" will be really
expensive in terms of time and effort.

Only crucial bugfixes are going to be ported to older versions (by means
of our maint branch - for a limited time - and the stable kernel releases=
).

However nobody prevents anyone from the community to take over this task.=



Cheers,

--=20
Antonio Quartulli


--1J7HmaPudOVksFFsS4pMAmOeL3mo5cBRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+S81AAoJEEKTMo6mOh1Vqk0P/R6otbKZ3nalOSWGVYDh++J5
FnbgutD6yI2CDnUuZ4XEWpXt5Rt7poc/E9cwitUuLnfZIoin+4Mwqaemy/41MojK
Lof1P3ZeLsemH2TJqmsqXWrgdmSglflplrRT0BrlRFv+HUX4ooasMtZd0845AUQV
3xBuMxVOReZAtxlsPcxdxWJMGSsvVQB4kSIlCT6x7s88MN9/Gvg8MOQ167u8ow3s
Dqz2SDp9/PM+3WZKJORvz+vBA+5OG8TbZCA8uLcl05Te6fc+OakEt2J4SatIMKXD
ikYuoKqjcoe9mJOit7m9xdDabQ1MbLSHhvzSI96zymcrBgKHM3aiwoJqoqa3ERK3
X3/6SXv1HX0S7gEspLXxl0sshU6KBsYz8CyoH3Yq21hC5JeOj2sB9nt/mBY2bTUT
+IJ9TVQd35uAJsHbvDVmqj3Yixf8tu4EsRmqyBSGpfHUp/74hR45bmPw6S2Fou2m
AQ2ClXxHih5KQ8tcsM0zcxfSH/X2uMgbplGmFQqaI6PzJKztCPIsaA02riUxtjES
4K4wc6bz38/ilTCky6OJ0JHV2Yq3SFmd8ooBZdrCuSiJ6Z4Gdzz+BYmn6wRoMo3r
krrNIamhMamcwKbsbDWAN5vIF6QQxI4Rc0E29A4D4KdvnDn8v6X0U9jdpKrQTgkJ
BfgQLi3xk/0m53VAu4kJ
=soC9
-----END PGP SIGNATURE-----

--1J7HmaPudOVksFFsS4pMAmOeL3mo5cBRM--
