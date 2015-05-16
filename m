Return-Path: <ruben@freifunk-nrw.de>
Date: Sat, 16 May 2015 22:15:37 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150516221537.2a6fad9a@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/JOYnlc0qfCuMfqJGho._sPY"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Patch which fixes a uint32overflow ;
 fix algorithm which was unintented changed on 2014 update
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

--Sig_/JOYnlc0qfCuMfqJGho._sPY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Changelog

* fix overflow of uint32-value while multiplying
* restore algorithm to origin calculation which expect kbit/s values

Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
---
 net/batman-adv/gateway_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c
b/net/batman-adv/gateway_client.c index bb01586..6f00584 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -153,7 +153,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv
*bat_priv) struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
-	uint32_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
+	uint64_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
 	uint32_t gw_divisor;
 	uint8_t max_tq =3D 0;
 	uint8_t tq_avg;
@@ -185,7 +185,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv
*bat_priv) switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
 			tmp_gw_factor =3D tq_avg * tq_avg;
-			tmp_gw_factor *=3D gw_node->bandwidth_down;
+			tmp_gw_factor *=3D gw_node->bandwidth_down * 100;
 			tmp_gw_factor *=3D 100 * 100;
 			tmp_gw_factor /=3D gw_divisor;
=20
--=20
2.4.0


--Sig_/JOYnlc0qfCuMfqJGho._sPY
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKIEARMKAAYFAlVXpWkACgkQgB++GrevraTXugIJAcDnN283iRmDVbFs+lAfayZ2
prHjXlcxyn0cfo+B3GNfzyN//iKT3WPvazfAipEiX4f/kjbhp0XOQmXtbKg+fwol
AgkB4JelfcgPK62OPXDBeRN4gWceWH6Nsjh3v4wGsJYzNwowTAE1YqAqKyO0zJdO
g/xGUtFSyHm5OolhdAfLVKf04rk=
=4OjV
-----END PGP SIGNATURE-----

--Sig_/JOYnlc0qfCuMfqJGho._sPY--
