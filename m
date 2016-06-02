Return-Path: <ben@decadent.org.uk>
Date: Fri, 3 Jun 2016 00:00:44 +0100
From: Ben Hutchings <ben@decadent.org.uk>
Message-ID: <20160602230044.GM7555@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JWJEtCrVvH5hpatL"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix double-put of vlan object
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


--JWJEtCrVvH5hpatL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit a33d970d0b54 "batman-adv: Fix reference counting of vlan object
for tt_local_entry") makes each batadv_tt_local_entry hold a single
reference to a batadv_softif_vlan.  In case a new entry cannot be
added to the hash table, the error path puts the reference, but the
reference will also now be dropped by batadv_tt_local_entry_release().

Fixes: a33d970d0b54 ("batman-adv: Fix reference counting of vlan object ...=
")
Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is untested; I just spotted this apparent oversight while trying
to backport the previous fix.

Ben.

 net/batman-adv/translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translatio=
n-table.c
index feaf492b01ca..2068cf6648cb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -691,7 +691,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface,=
 const u8 *addr,
 	if (unlikely(hash_added !=3D 0)) {
 		/* remove the reference for the hash */
 		batadv_tt_local_entry_put(tt_local);
-		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
=20

--JWJEtCrVvH5hpatL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV1C6m+e/yOyVhhEJAQoIYg//Qb5o8EekiczD26JuzWd6gWfAP7OT9RKV
1JE3dltLGj2/7EScDbw9aoM5p1Mj5KPDPKQnhl7ptJMEkPhfGd0kvyN7fDT8oamN
CNvFXo+uvdjmMvd43u/V3+4wbBWFRoLhawZJJzhS7XDS3Mzpv5kuLBS+T6QC0wKg
t4ihmDVaq8DcNfz7eTJFKO6BgXDubsZXcM0dk7HlYAIEy4ZRxvqyzbSmbtEy+n3o
YQsEWrI6EaIHLU4UG+deVtgSiKCbWMcX6U3t4FAdJaccJDOhdFAHgm3CFU53LZ+5
fAMBdPNPZqn2/fZBMtTR7mZNslsFuSKGK6RNmbMQgOTlyb5iNop+aMyaBdYuwfej
QD/bfyzOJpS66aRKryFGo+DRsaq0WxS2t5ktztG8voOrAxFEjLgXqTS1rcwSAdqE
nysQoHirIyleWpr2950V9Kpv0rojZ2Ek4lTDoRfPgtJ45OmUP/AUpVOUWtNvNWOz
INGqx9tBjfSpEmlU6pP1sB1ilLwqf9gdLTs0QbGDFC0GwTNLXeqb/8XsxYx/DZku
VsSFFPBVQg0LSzdV28XAjncU1fgf+GzDgCchOg/P/EZ6cQ1RZuusThs+4GIhmwkX
lsiwTjWWrneIn9sr3ZTv7KW+bUYuvXHvBI0A7HvsFNP/BDTwMUJ0HyFng3Wky15Y
q9T/9nRWFo4=
=HV4g
-----END PGP SIGNATURE-----

--JWJEtCrVvH5hpatL--
