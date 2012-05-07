Return-Path: <ordex@autistici.org>
Date: Mon, 7 May 2012 09:15:00 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120507071500.GA4330@ritirata.org>
References: <1336335725-22016-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1336335725-22016-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: turn tt commit code into
 routing protocol agnostic API
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2012 at 04:22:05AM +0800, Marek Lindner wrote:
> Prior to this patch the translation table code made assumptions about how
> the routing protocol works and where its buffers are stored (to directly
> modify them).
> Each protocol now calls the tt code with the relevant pointers, thereby
> abstracting the code.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPp3Z0AAoJEFMQTLzJFOZFZ9QH/0pE/ZNS8+9IW0Levi4eQVoI
gG7KkP0DpKx8jp2/uJ+5kXvzkB62GJWhVdjMcPbWD2/fZZuHI6zNB00Lwb6iQ6LY
A9DLtMmZsR3bWdCWlix0W+2+DdDhDKq9lpwelthevbbivBgCOMTvhJQ+sFGI8Nh+
zOTrYGZ52ArHyvT34bXfFfJch1ckSk8sYnP2xlIL5pfoe8wBx3kMAU++ba4CgHwC
1XMRTYqPZUiKImKyqarSgkr/hrh/avH5F62iG/jPPK5H0Y9xV3CK2B1WgxwVoEKc
+iLi1vC57l6i1eJReYfVJl9Hfwo5tboohyeXvJDmaxrWtTw/Oc0JkWVfYY4tIgU=
=Shr5
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
