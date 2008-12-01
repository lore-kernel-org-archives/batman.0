From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Intel CC warning smashing
Date: Mon, 1 Dec 2008 22:12:04 +0100
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2563214.8QE8v7A2OM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812012212.08570.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart2563214.8QE8v7A2OM
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

There are some remaining remarks, but most of them are wrong (seems to be a=
=20
icc bug or missing feature for #810er remarks).
Thing which should be checked are get_rp_filter, get_send_redirects,=20
get_forwarding, set_rp_filter, set_send_redirects and set_forwarding. These=
=20
functions use int32_t to represent the state during set or get, but batmand=
=20
stores the result of all get functions as int8_t in batman.c:batman and str=
uct=20
batman_if....

Best regards,
	Sven

--nextPart2563214.8QE8v7A2OM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk0UyUACgkQqQGwKVlMoDvkkACg9noIskhxmV+06fLNl7oVvbpI
ncwAoLp6aQXO7TRC+xJEK1juBsD+F3Jk
=8qhA
-----END PGP SIGNATURE-----

--nextPart2563214.8QE8v7A2OM--
