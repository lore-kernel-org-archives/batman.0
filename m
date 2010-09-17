Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 03:17:27 +0200
References: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
	<1284672174-27464-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284672174-27464-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1859554.8JmXAiPlyK";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009170317.28338.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Adding of basic gw_node/batman_if refcnt
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

--nextPart1859554.8JmXAiPlyK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Hi,
>=20
> if anyone wants to start to track all usage cases of the batman_if and
> gw_node then he can use the functions defined in following two patches.
> The patches are not fixes, but they provide a starting point for the
> actual bugfix.


Please ignore

[PATCH 1/2] batman-adv: Use refcnt to track usage count of gw_node
[PATCH 2/2] batman-adv: Use refcnt to track usage count of batman_if
[PATCH 2/2] batman-adv: Use refcnt to track usage count of batman_if

The problem is that the refcnt check must be done after the grace period an=
d=20
not before. Otherwise we may think that nobody uses it anymore, but instead=
 it=20
is still referenced inside a rcu_read_lock...rcu_read_unlock and the refcnt=
=20
will be updated a little bit later than the refcnt check is made.

rcu_read_lock       | xyz_write_lock
xyz_list_rcu {      | xyz_list_del_rcu(x->list)
  ....              | xyz_put(x)
  xyz_hold(x)       |   -> call_rcu(free_xyz)
  ....              |
rcu_read_unlock     |
                    |   -> free_xyz(x)

I will repost the whole patch set later. The solution is to use=20
synchronize_rcu instead of call_rcu and calling free_xyz directly. This=20
solution is not possible if sleeping is not allowed in that situation or it=
 is=20
relative time critical.

Another way is to add a deleted flag and an extra spinlock. This spinlock m=
ust=20
be used before "put"ting/holding an element in rcu_read_lock. So the reader=
=20
side would need following code:

	spin_lock(&x->lock);
	if (x->deleted) {
		be confused and dont use it as valid candidate
	} else {
		mark it as valid candidate and hold it
	}
	spin_unlock(&x->lock);

on the updater/writer site we must use something like that:

	spin_lock(&x->lock);
	list_del_rcu(&x->list);
	x->deleted =3D 1;
	spin_unlock(&x->lock);
	put element


Best regards,
	Sven

--nextPart1859554.8JmXAiPlyK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMksGnAAoJEF2HCgfBJntG554P/3rUR3GOdBdjlhxtqSuJa6xB
9q3pAGX83V6wpjnmCyJVPVL3+iYqUdmojURacKisMoHRc/uWGzCGnWlT/ljE3cGt
mHRhvE9WFg777iDcnQOIZ+LdF4LEWnaXn2LbKlTzVA8ayApQwguT9Qkzu+SUj3+B
nyHlQnqCebYPnybGdbaZZSyk878kxYuW2bwesjX4jK1avzZMJS7O667z5hJMSG4S
eM9ypqweVu/UpnEoHeQZFdN6+TAJG1V9w/ZlcUF8spHlXgpjGySsgpEZIHSL6+/O
8EmW709J9wM4ZYIeCe/zHetoD/MIpFuOKLl+f/gYn1bkfhm1anKfhwYmZDUMK9JD
hW+ILxNJZAaGWqiFKjD+GllwS9cnR+tc2XEkVefZ+kLZqAllz7M5Xe4n80i/ntXs
ux9E3a3fspllvSXSffkTbX/A0nuubDY4Gh/XgZydLoyg4wwPlaLTJaYhuZ43aPl/
yv9H/gO9v/nzcQHmKN5pqVs3uQXI19JND8enmtbkqIJESpoSjJMBlGuZFK/z+7+v
OzYoGUVNSIj3x+DkRSoU+VFdAoHNsVGWWcZm3zIclC3cTc2IcGEh2l/V+wal/10q
4FiIbPEy0uCflSDfDMzp3xYGMNF1mMsuTz1CMEoSuFAsatisl7ABT/a+0ScJbwNh
pl92A2WlSGQX/D6JaRxh
=V79H
-----END PGP SIGNATURE-----

--nextPart1859554.8JmXAiPlyK--
