Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 13:46:06 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126124605.GF22729@ritirata.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
 <2094937.nutMCHjP7e@bentobox> <20121126123002.GE22729@ritirata.org>
 <2262644.KoOtvs7upt@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline
In-Reply-To: <2262644.KoOtvs7upt@bentobox>
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


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 01:39:00PM +0100, Sven Eckelmann wrote:
> On Monday 26 November 2012 13:30:02 Antonio Quartulli wrote:
> [...]
> > > The in kernel implementation will create a different hash sum -> tt
> > > entries
> > > will end up in a different bucket -> CRC will be different (please co=
rrect
> > > me about the last step... just had this problem in the back of my hea=
d).
> > CRC computation does not rely on entries positions, because the real CR=
C16
> > is computed on the client mac address only (and this is the same
> > everywhere) then the results are XOR'd together. Since XOR is commutati=
ve
> > we do not need to keep the same order network wide.
>=20
> I've already wrote this two 2 1/2 hours ago.
>=20
> > Instead, your reasoning is correct for DAT, but for the global DAT hash
> > function only.
> > The local one can be whatever we need, so we can also use jhash for thi=
s.
>=20
> Please define global and local DAT hash function. Because you use the sam=
e=20
> function in both places.

Yes, sorry, it's my fault. At the very beginning DAT had two distinct hash
functions (before it got merged) but then I decided to use the same everywh=
ere.

At this point I would rather suggest to leave DAT as it is (so v2 it's fine=
 with
me).


Thank you.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCzZI0ACgkQpGgxIkP9cwdcXQCghOkDWUjkUBHbII7UurrwqlQ0
YRUAnRnWrCfG/+e+zpVe7nXtLY8Mhlcb
=N4s8
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
