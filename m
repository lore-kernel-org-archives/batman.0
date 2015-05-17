Return-Path: <ruben@freifunk-nrw.de>
Date: Sun, 17 May 2015 11:27:32 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150517112732.48476eac@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/uH/KYHHd+2cfDyeajIK.9nA"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH] fixes a uint32 overflow
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

--Sig_/uH/KYHHd+2cfDyeajIK.9nA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_clien=
t.c
index bb01586..1f50661 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -153,7 +153,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
-	uint32_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
+	uint64_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
 	uint32_t gw_divisor;
 	uint8_t max_tq =3D 0;
 	uint8_t tq_avg;
--=20
2.4.0


--Sig_/uH/KYHHd+2cfDyeajIK.9nA
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKEEARMKAAYFAlVYXwUACgkQgB++GrevraTsVAIJAfHqF6VineNRi5/FgSpEFrfY
zp7TnrNOArAa3oG64aVG8xFXkHFqXcfY/wtt2Ylryfm7p9ehOa9zsYuRCamuM8sp
AgdayurvvjKPW4L26Eh2FKr1qvIEmCxryGijVaRhMoN/NmR8xtxLEV6K7SBwOP1d
i+z5WnWqbs0ha1TrV0jSHoUMGA==
=OlgJ
-----END PGP SIGNATURE-----

--Sig_/uH/KYHHd+2cfDyeajIK.9nA--
