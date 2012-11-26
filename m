Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 10:33:09 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126093309.GB22729@ritirata.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <1353867811-8452-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Use common Jenkins Hash
 implementation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2012 at 07:23:27PM +0100, Sven Eckelmann wrote:
> An unoptimized version of the Jenkins one-at-a-time hash function is copi=
ed all
> over the code wherever an hashtable is used. Instead the optimized version
> shared between the whole kernel should be used to reduce code duplication=
 and
> keep bugs at a single point.
>=20
> Only the TT and DAT code must use the old implementation to guarantee the=
 same
> distribution of the elements in the hash. The TT code needs it because th=
e CRC
> exchanged between the mesh nodes is computed over the entries in the hash.

Hi Sven,

I don't fully get why we can't use this new implementation in TT. What's wr=
ong
with the CRC computation?

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCzN1UACgkQpGgxIkP9cwemzwCghDdvcST5dmVwFoW79OBrakwH
1YAAn0NaWTwZWH2airxLZwVIuxhLLbzM
=jwhB
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
