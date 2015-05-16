Return-Path: <ruben@freifunk-nrw.de>
Date: Sat, 16 May 2015 22:26:43 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150516222643.1c390606@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/7l7juAo_BHuRQrtxQP4bg_L"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH] gw-bandwidth: fix potential overflow on very
 large input values, limit them to 100 GBit/s
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

--Sig_/7l7juAo_BHuRQrtxQP4bg_L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
---
 net/batman-adv/gateway_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/gateway_common.c
b/net/batman-adv/gateway_common.c index 39cf44c..6b0f4d3 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -71,10 +71,16 @@ static bool batadv_parse_gw_bandwidth(struct
net_device *net_dev, char *buff,=20
 	switch (bw_unit_type) {
 	case BATADV_BW_UNIT_MBIT:
+		/* limit input to 100 GBit/s */
+		if (ldown > 100000)=20
+			ldown =3D 100000
 		*down =3D ldown * 10;
 		break;
 	case BATADV_BW_UNIT_KBIT:
 	default:
+		/* limit input to 100 GBit/s */
+		if (ldown > 100000000)
+			ldown =3D 100000000
 		*down =3D ldown / 100;
 		break;
 	}
--=20
2.4.0


--Sig_/7l7juAo_BHuRQrtxQP4bg_L
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKAEARMKAAYFAlVXqAMACgkQgB++GrevraR0tAIIkHDqpVDdlt4L/wBAGq7VxU7J
FT5MktGDXQjdS/nuyJ3pQAFRPaDTRfmOr8d6sBd2i6tP2i0IldBiADAobodgXu0C
CLHlyeOxwmKm1l38beRZIUSWiJ9Wf0qJthmES9o6gBXktqDi6HaIp8Zv5XcdKxtr
FqG4HdY/FeFRyRRNM5uhImv7
=jZ7c
-----END PGP SIGNATURE-----

--Sig_/7l7juAo_BHuRQrtxQP4bg_L--
