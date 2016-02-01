Return-Path: <a@unstable.cc>
Date: Mon, 1 Feb 2016 08:46:23 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160201004623.GK22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <1454257280-19649-2-git-send-email-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/3] batman-adv: convert wifi driver
 throughput to multiples of 100kbps
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 12:21:19AM +0800, Marek Lindner wrote:
> Fixes: 5c324517 ("ELP - compute the metric based on the estimated through=
put")
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Maybe before merging this patch you add a one line commit message here sayi=
ng
that expected_throughput is supposed to be expressed in kbps, therefore this
fix is required ?

Other than that:
Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrqrfAAoJENpFlCjNi1MRIeUP/RBxLAQ16dIP10JBxwgVymak
EH9sWEXKueQaNos6Ie3hl/GzAhV/E77MfYybieUSTI+PIQGP6UQg1N+rt7Is4fvQ
mQ19uIy8DMa6ssvhOQoFd5y2tLCruHrJzWRt76gdWkYpfy/k7U0SQPQ3P5+1TLJ8
FdT2sfu/poQCQSzLibjUOu15JKj37mKHCAJieK7ca1S3JkqExLlgBtL9ullGRiRo
8N9kx0K56Lk8r9fd9H1zB/dMD+CAYP9puXJkt78Nd4UT+dBalpLZFRVv+wFtRGAp
tIlTGeeC4UISxN3bd6uKkR7m6pHP/ZEy8hml6NZ9ZJ7nICqF6zRfYpmxJVwzKlft
f1lcxzXFBncj6WiWGS22gwL83DM7kwNHfKZb3MyqNBxLBodAd5Rdb5aE37pE7HT0
oK+svLGEZ2Ity0THMQJX+SD0SKT1wnQJ+9V8D0ooX8EfZ7zVmOQXoQ7yWpNeET+E
MwCxJIRW9zGGMOFBY5UGEFThcynLBHbqlL+/Brw5un5cpLw1gYNslIf+x+QS2bo4
HigYQNQChBrXSndNt1H3BKtAqdKabtyHe6XhRzFLhl6XF1zjXVeNllZFS6/NI+Hb
JgascIjbTzYh4xJDq8ZKAZmaE4T8PbBhpqVgrmzu/RUYfsuzAmYMAI0+Dti4pfF+
QnrHvTMwdkRC4C4krmBT
=EDeI
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
