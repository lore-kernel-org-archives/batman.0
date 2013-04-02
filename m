Return-Path: <ordex@autistici.org>
Date: Tue, 2 Apr 2013 12:22:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130402102250.GJ4024@ritirata.org>
References: <1364897813-19421-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <1364897813-19421-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't initialise batman_iv
 private members in hard-interface.c
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


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2013 at 12:16:53PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> hard-interface.c has to do not contain any routing algorithm
> specific code.
>=20
> Allocate the hard-interface with kzalloc() and remove any
> useless and algorithm specific member initialisation
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---

For whoever is concerned about this missing initialisations, I have to say =
that
those are done in the routing specific API function upon hard-interface
activation. Meaning that the seqno and the ogm_buff are initialised somewhe=
re
else before being used.

However, using kzalloc, ensure that all the members are initialised to 0 af=
ter
allocation.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRWrF6AAoJEADl0hg6qKeO03EP/iTCbe1jn7b2sNEsFwYROotN
g5jOrEUcpncqizvBrmiXT8v2ciZfnfzuH3wnfd3GMF/XV40PwgpqQ+1Vqq88igku
xh6tA0H0B5apSfm99dAHUGjU6XoXS9Lt1ib9WFqKSmb8vyeKPXcyeL1xSGw5A3Dc
ndEQtLjbVMtRnx0FY7LV4encmjbmWW1sGiIymYg5PeDb2zQlLrBg8mzGQkSJ2u6B
l6tyC/7GzqcglwdvQCrHpZnLKfpoqknF3/vcz8WiF7cU7cUbkkmwzE8Lzlhudz8R
RlKYeMy7YMP1WU7yGjCOxCGvy9AJRJd1GAvSxs4Z56dT0NRiITG9vGUBb/OjyoBZ
+kS6CpLjvu6ph1E41dzW1cSUuIiR9/6jgm+vNDP2I7bzlEbc3dJJXmrH8a83jJ/M
2hZgn5PNQ4LuD4oge5W7Mg3vFwEtOXRilpGOlAGyIyFCwjQaAUHbltIA11RfdshL
0lDYP6tDI3idaORIxcmBh2kwPQhPad8nEOBawkODVF69BsVnX3yinpWmiIjsasZI
gfrPj56qzdwp5GO/73JFJkhfWxMiKNsvISptZWvPIulTlbv+Jlt0oH5gXCrPEH8K
TAKLEc9IHFIupAj4We+udL3SZJr7l11pJid0MCTZoNopJjxyRh+jTVhsnSXZzvEC
SqrQ9og0FCQT+3XzEZ0u
=NSKj
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
