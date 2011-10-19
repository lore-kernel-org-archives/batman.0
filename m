Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 19 Oct 2011 10:28:26 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111019082826.GA31323@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add sanity check when removing
	global tts
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


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After removing the batman-adv module, the hash may be already gone
when tt_global_del_orig() tries to clean the hash. This patch adds
a sanity check to avoid this.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 translation-table.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index c2af2b1..ffa846c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -712,6 +712,9 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
=20
+	if (!hash)
+		return;
+
 	for (i =3D 0; i < hash->size; i++) {
 		head =3D &hash->table[i];
 		list_lock =3D &hash->list_locks[i];
--=20
1.7.7



--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6eiioACgkQrzg/fFk7axYZ/QCePzPAQ+Q4kHdaszPGxH1AyAgM
UY8AoOzgVm+wte10mswonj3/78Ewcdfn
=HM2g
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
