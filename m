Return-Path: <ruben@freifunk-nrw.de>
Date: Sun, 17 May 2015 11:37:26 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150517113726.47de614d@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/QK4qzqg6WlM=8WOuQ_Q7_cI"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH] fix algorithm,
 which was unintentional changed on update from  2013 to 2014
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

--Sig_/QK4qzqg6WlM=8WOuQ_Q7_cI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch restores the unintentional change on commit=20

http://www.open-mesh.org/projects/batman-adv/repository/revisions/0853ec7fa=
fe0a195754454832993c6b35e22b842/diff/gateway_client.c

Original the algorithm uses kbit for calculation, now the values are
stored as "mbit*10" so we have to multiply it with 100 to restore the old
behavior.


Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_clien=
t.c
index 1f50661..6f00584 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -185,7 +185,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
 			tmp_gw_factor =3D tq_avg * tq_avg;
-			tmp_gw_factor *=3D gw_node->bandwidth_down;
+			tmp_gw_factor *=3D gw_node->bandwidth_down * 100;
 			tmp_gw_factor *=3D 100 * 100;
 			tmp_gw_factor /=3D gw_divisor;
=20
--=20
2.4.0


--Sig_/QK4qzqg6WlM=8WOuQ_Q7_cI
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKEEARMKAAYFAlVYYVYACgkQgB++GrevraQHVgIJAQHQELk6BIt8ng7OZmRkDrMc
8PSS7PuUXjFRAa+T6H9p4uN+pN6csPnAEOGCXDuY1NdWp1xECUxmFhQ4jma+oywu
AgiiIxyjbHmHrvUtBPkFS5pmo8OjoZVE/8kXDGyABNTuRjfr6M8GZzDNGlsuQAJY
pv3JVXgfzF1h5noHOTjsXSvJkA==
=cIsS
-----END PGP SIGNATURE-----

--Sig_/QK4qzqg6WlM=8WOuQ_Q7_cI--
