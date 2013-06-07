Return-Path: <ordex@autistici.org>
Date: Fri, 7 Jun 2013 18:46:49 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130607164648.GN1789@ritirata.org>
References: <1370616725-1598-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xdWF/UuCWMRSqXrg"
Content-Disposition: inline
In-Reply-To: <1370616725-1598-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't handle address updates
 when bla is disabled
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--xdWF/UuCWMRSqXrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 04:52:05PM +0200, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> The bridge loop avoidance has a hook to handle address updates of the
> originator. These should not be handled when bridge loop avoidance is
> disabled - it might send some bridge loop avoidance packets which should
> not appear if bla is disabled.
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

Since this is a fix and not a new feature, it should target maint.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--xdWF/UuCWMRSqXrg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsg54AAoJEADl0hg6qKeO9RoQAIdmx+lVTOMGoTgjyQLmE/GE
yBHP7abt28bRHE7jQ63WU3BjmKr35XJS1mzTIkqKg5kMcM2C9brkeo5+3ZpKZvrh
HsVw0dRrS7H4kjg3Crpf2ifg5ofyRlFkreLOzl/QUu29N+LwHQnZO3E0mHyVY6dG
n4SY3h1I7MET1oT5DA8ReTRVIKGlVAbt3nzFCwJAH34qyn1Actp8WrHZCcOWRP9D
fhCUh8tsNdvfj/vUTextVba7w8jZvpdDgvcslNN65YN5pLPFLvO8csa+S7kHZh2P
ZsHQXUmGS30GxnpPnuXNlw7T1HGqWTqMNovIRVV6kWtCFlEcoO3CstHSnoGidt8a
Pl2rpRcOPm+eZx9uTeLitmXhh0qqDra5TIHGdObGIb655rv184GcKBsHb7o1KG5E
yyKfRfBkxvor2zYCcxRLVEZmm2sqTVJipexPNZBZ2UKw/swveNeJTCrV62A9UrzO
E7yAPKh6ZVfp81tovbozIHJg6gKib4KdyJbuMKGbYvo/gGry/pY2brNYXhjOQDnI
sB3sjT272hF6iZOH9toAbe6nhFB01+PisgsbJYGuNMW+fCoY33/szgDkfNrEOGb9
FftCIHGM3tp1mLWNuHy4Oifcjqd0zFDmZhG03UUPzdFEVLLGoIxH4+nlHAHdLrht
g5btKySNSAYXkNP0fTto
=golq
-----END PGP SIGNATURE-----

--xdWF/UuCWMRSqXrg--
