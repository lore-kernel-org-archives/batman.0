Return-Path: <edwecowley@gmail.com>
MIME-Version: 1.0
Date: Wed, 15 Jul 2009 15:59:32 +0200
Message-ID: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
From: Edwe Cowley <edwecowley@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [vis] Remove duplicate routes from vis output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Revision 1271 introduced a bug on the call to hash->compare() that
caused duplicate routes to appear in the output.=A0 Inverted the
conditional and now it works.

Signed-off-by: Edwe Cowley <edwecowley@gmail.com>
Index: batman/hash.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- batman/hash.c (revision 1343)
+++ batman/hash.c (working copy)
@@ -179,7 +179,7 @@
bucket =3D hash->table[index];

while (bucket !=3D NULL) {
- if (hash->compare(bucket->data, data))
+ if (!(hash->compare(bucket->data, data)))
return -1;

prev_bucket =3D bucket;
@@ -217,7 +217,7 @@
bucket =3D hash->table[index];

while (bucket !=3D NULL) {
- if (hash->compare(bucket->data, keydata))
+ if (!(hash->compare(bucket->data, keydata)))
return bucket->data;

bucket =3D bucket->next;
@@ -260,7 +260,7 @@
hash_it_t.prev_bucket =3D NULL;

while (hash_it_t.bucket !=3D NULL) {
- if (hash->compare(hash_it_t.bucket->data, data)) {
+ if (!(hash->compare(hash_it_t.bucket->data, data))) {
hash_it_t.first_bucket =3D (hash_it_t.bucket =3D=3D
hash->table[hash_it_t.index] ? &hash->table[ hash_it_t.index ] :
NULL);
return hash_remove_bucket(hash, &hash_it_t);
}
