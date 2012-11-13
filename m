Return-Path: <ordex@autistici.org>
Date: Tue, 13 Nov 2012 09:06:22 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121113080622.GJ16547@ritirata.org>
References: <1352541632-25336-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline
In-Reply-To: <1352541632-25336-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Initialize lockdep class
	keys for hashes
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


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 10, 2012 at 11:00:32AM +0100, Antonio Quartulli wrote:
> Different hashes have the same class key key because they get
> initialised with the same one. For this reason lockdep can create
> false warning when they are used recursively.
>=20
> Re-initialise the key for each hash after the invocation to hash_new()
> to avoid this problem.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

I was thinking...instead of creating such "a free noise" in udev, we may wa=
nt to
add a configuration facility so that the user can choose which uevents to e=
nable
and which not..

If we don't do so batman-adv will start throwing uevents even if not needed.

Please, drop this patch. We need some more code here :-)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCh/34ACgkQpGgxIkP9cweZTQCeJvpDVeRyyQS+el72Fbp/Xf5R
d0kAn0Uga7Oumq1evDdrm5pJ1UvhyNcP
=cCg/
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
