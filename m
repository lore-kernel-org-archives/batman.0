Return-Path: <jj.sarton@t-online.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <c87c6dac-72e5-c8ea-a2e1-50a173e53f16@t-online.de>
Date: Tue, 1 Nov 2016 15:38:48 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JM4EV91b3h6hsM2MPuPe7J0o6pTxnSeNk"
Subject: [B.A.T.M.A.N.] PATCH alfred
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
--JM4EV91b3h6hsM2MPuPe7J0o6pTxnSeNk
Content-Type: multipart/mixed; boundary="xSHVj3v6IkLjJ2tE6DUA2c8ddx0eSQE6s";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <c87c6dac-72e5-c8ea-a2e1-50a173e53f16@t-online.de>
Subject: PATCH alfred

--xSHVj3v6IkLjJ2tE6DUA2c8ddx0eSQE6s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Copy & paste is not allways the right way.
The previous patch for  netlink.c what not OK. The right patch is:



diff --git a/netlink.c b/netlink.c
index 1b5695c..445161d 100644
--- a/netlink.c
+++ b/netlink.c
@@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const
struct ether_addr *mac,

        return 0;
 }
+
+int batadv_interface_check_netlink(const char *mesh_iface)
+{
+       struct get_tq_netlink_opts opts =3D {
+               .tq =3D 0,
+               .found =3D false,
+               .query_opts =3D {
+                       .err =3D 0,
+               },
+       };
+       int ret =3D 0;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+
+       ret =3D netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINAT=
ORS,
+                                  get_tq_netlink_cb, &opts.query_opts);
+       if (ret < 0)
+               return ret;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+       ret =3D netlink_query_common(mesh_iface,
BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+                                  get_tq_netlink_cb, &opts.query_opts);
+
+       if (ret < 0)
+               return ret;
+       return 0;
+}


--xSHVj3v6IkLjJ2tE6DUA2c8ddx0eSQE6s--

--JM4EV91b3h6hsM2MPuPe7J0o6pTxnSeNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgYqPgWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C1CTAJsFg7Giv5VuNKotEjUzYmwd/N3dUgCdFEW1um/1KMpXXof9IWr5PkOC6vs=
=3tLY
-----END PGP SIGNATURE-----

--JM4EV91b3h6hsM2MPuPe7J0o6pTxnSeNk--
