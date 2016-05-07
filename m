Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 09:03:13 +0200
Message-ID: <1656407.PytZZyZNAi@sven-edge>
In-Reply-To: <1462566429-26709-1-git-send-email-sven@narfation.org>
References: <1462566429-26709-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart38491471.nfb4GZaIQD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix double
	neigh_node_put in batadv_v_ogm_route_update
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

--nextPart38491471.nfb4GZaIQD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 22:27:09 Sven Eckelmann wrote:
> The router is put down twice when it was non-NULL and either orig_ifi=
nfo is
> NULL afterwards or batman-adv receives a packet with the same sequenc=
e
> number. This will end up in a use-after-free when the batadv_neigh_no=
de is
> removed because the reference counter ended up too early at 0.
>=20
> Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic=
")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
[...]

There is a conflict with master. I hope that Antonio can share how it c=
an be
resolved when he submits following remaining fixes to David:

 * batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq
 * batman-adv: Avoid duplicate neigh_node additions
 * batman-adv: make sure ELP/OGM orig MAC is updated on address change
 * batman-adv: Fix unexpected free of bcast_own on add_if error
 * batman-adv: Avoid nullptr derefence in batadv_v_neigh_is_sob
 * batman-adv: Fix refcnt leak in batadv_v_neigh_*
 * batman-adv: Fix double neigh_node_put in batadv_v_ogm_route_update

The solution for the merge conflict with master is:

=2D-- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -510,17 +510,10 @@
                goto out;
        }
=20
=2D<<<<<<<
        /* Mark the OGM to be considered for forwarding, and update rou=
tes
         * if needed.
         */
        forward =3D true;
=2D=3D=3D=3D=3D=3D=3D=3D
=2D       if (router) {
=2D               batadv_neigh_node_put(router);
=2D               router =3D NULL;
=2D       }
=2D>>>>>>>
=20
        batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
                   "Searching and updating originator entry of received=
 packet\n");
--nextPart38491471.nfb4GZaIQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLZMxAAoJEF2HCgfBJntGOFYP/j2a0i1AC7TQqnE7ffkcRb4j
yudiO/GpEnezqPDKjBDE5phTMBMWEljmnwIh7NQpcgzQCQdEzaDa3HOVlKY2jACs
4WOY0vwGSgtHfuhYsfFwlhQChPbeeK7ROj/XRSrt6EAnh1KiiT1dKOrqNm16UxVl
1MADq3cxzHc0gmgGzmUORjP4fduWS7E1SZqsJzbEH2UgUx+SnZqmzoxSBHqf6tXI
Pqu6B4khh6w5gjWV9fQqMi2EYQ4OmHFBrEJYAGhA1JqFmZcZG3DWSg+ZUvuo6kdv
55Nw1T8fme/+2YDEOyFJnhpoZZZaXexFWCbGzFEz42ImndLqSwc4rmDJ0kuStDBb
tDbKnroWy8sTx5MfJM0oMqsdSkhSFOMVbmLgCcp6FJVpjMJ3q3DqeVWwwo4v3oTc
LsO1elrhprpToVr6+NLxKji+R89H8WVGtKbI0gIVR+qvlfBdo+HUwGMkAmhiTiXz
4lw8fx0u55tZPldA8RG8f3qWtC1Ye9pjGJj0RII9/fntG/Iag6Fhwp97BekdyKZ+
vulAlJdJpEu7NtkmlcbKv9RHWcwaQWlN826xqhX3Gk+HcbvHtKa3if+JtQwXR9kB
vWRn+EibRFkKX+/ORQIaMzzh6fyAYvonDyOS2TrMcLVGgO2G/B30nh8uSCg+UYEW
O4PrnxgMUiC+eVgnRdxK
=jEPK
-----END PGP SIGNATURE-----

--nextPart38491471.nfb4GZaIQD--

