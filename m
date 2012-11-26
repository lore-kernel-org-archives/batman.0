Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 13:30:02 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126123002.GE22729@ritirata.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
 <20121126093309.GB22729@ritirata.org> <2094937.nutMCHjP7e@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <2094937.nutMCHjP7e@bentobox>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 10:40:07AM +0100, Sven Eckelmann wrote:
> On Monday 26 November 2012 10:33:09 Antonio Quartulli wrote:
> > On Sun, Nov 25, 2012 at 07:23:27PM +0100, Sven Eckelmann wrote:
> > > An unoptimized version of the Jenkins one-at-a-time hash function is
> > > copied all over the code wherever an hashtable is used. Instead the
> > > optimized version shared between the whole kernel should be used to
> > > reduce code duplication and keep bugs at a single point.
> > >=20
> > > Only the TT and DAT code must use the old implementation to guarantee=
 the
> > > same distribution of the elements in the hash. The TT code needs it
> > > because the CRC exchanged between the mesh nodes is computed over the
> > > entries in the hash.
> > Hi Sven,
> >=20
> > I don't fully get why we can't use this new implementation in TT. What's
> > wrong with the CRC computation?
>=20
> The in kernel implementation will create a different hash sum -> tt entri=
es=20
> will end up in a different bucket -> CRC will be different (please correc=
t me=20
> about the last step... just had this problem in the back of my head).

CRC computation does not rely on entries positions, because the real CRC16 =
is
computed on the client mac address only (and this is the same everywhere) t=
hen
the results are XOR'd together. Since XOR is commutative we do not need to =
keep
the same order network wide.

Instead, your reasoning is correct for DAT, but for the global DAT hash fun=
ction
only.
The local one can be whatever we need, so we can also use jhash for this.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCzYMoACgkQpGgxIkP9cwfBGQCdEWwLH+FOjTuORjrreYEWW+Tx
pFYAoJeIWcjdyJzY4l/gisSn3dM/1X61
=/cW6
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
