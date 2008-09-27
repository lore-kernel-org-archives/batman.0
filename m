From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 27 Sep 2008 18:31:14 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2022190.g2CYmJusCB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809271831.18672.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Possible null pointer dereference in batman's
	update_routes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--nextPart2022190.g2CYmJusCB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I am not sure but I think it could be possible that there is a null pointer=
=20
dereference at batman.c:420
I assume that it is possible that neigh_node is NULL and orig_node->router =
is=20
also NULL in batman.c:412. Now we dereference neigh_node in batman.c:420 as=
=20
third parameter of add_del_route.
I don't know if the third parameter should be set to 0 if neigh_node is NUL=
L=20
or if the "if"-statement is wrong - so i will not send a patch this time.

Best regards,
	Sven

--nextPart2022190.g2CYmJusCB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjeX9MACgkQqQGwKVlMoDvVbACg+3zl7sECZqcDVFYAdzy9zfj3
9/QAnjT+YZ8dDq6AFYD5LGPH/1jwnnio
=OzJW
-----END PGP SIGNATURE-----

--nextPart2022190.g2CYmJusCB--
