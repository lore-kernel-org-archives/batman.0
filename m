Return-Path: <a@unstable.cc>
Date: Sat, 21 May 2016 20:32:52 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160521123252.GA12056@prodigo.lan>
References: <20160521121756.27450-1-a@unstable.cc>
 <56303564.iUxXQk9lEV@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZOBTspFzEMOlPevk"
Content-Disposition: inline
In-Reply-To: <56303564.iUxXQk9lEV@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove useless forward
	declarations
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


--ZOBTspFzEMOlPevk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 21, 2016 at 02:30:01PM +0200, Sven Eckelmann wrote:
> On Saturday 21 May 2016 20:17:55 Antonio Quartulli wrote:
> > If main.h is included, the batman-adv private forward declarations are
> > not needed anymore. Remove them.
>=20
> No, these are defined in packet.h and not main.h/types.h

Right. This single patch can be dropped then.

Cheers,


--=20
Antonio Quartulli

--ZOBTspFzEMOlPevk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQFV0AAoJEJ4aZjxxc6bKzkYP/0k3sz8yzbR2yemOxvRXfLKn
EYzLkaw0LCqZCuYoVUC7ClkGZ8EK75IeskysZMz0dMS27GeEPdaC6RRHkhh2h0TH
ZbQJpmLw4KvipqEJvew7r2g1fYH/OU2+PzCkbmJ6Se/SnPREu02HIolyBdBOe+qp
FvhanPUt2EVunq0YLBjeZp+MuB8qJRkqT6oawrHjAS99lb2pSqyhnK9Va8+htsjM
5AdHx1kXiszzuZWzk1rtaGFUTAnt0IrFah91SgA/dFSxCSmlbURlUGxAcsK3yvkX
c9w3jrua6pN0kJWNRIi4TDd7sdlOTAp2ECAxp9ic2x8mkUj+1bdE/t5mKv2l4BVb
K07Mfv+2+noaMR1BIPgvH7yBpfyScCe7pIM7IfeGEJmuMuiW5A6FxfNkVNiT+Gjl
C9aoKMeyQTMTvqMmfGjBz5qvFeMi4j3mfj7NAyudWMC+UPvSSexugm8mwtHddiBW
JWg1eRO7aqQD6Es9J27Ze/7X/gS2VSw8XCln//2DxaCQH5gYp+CAPfhJknrvpLTX
UXtLI4W2j/Bm0ZOEbBKLWQmgwxYmYjGH3MzSKH9CH7GCgetC3NcW2jB5Ij3Q9zHh
LfQBsVZOdVtTYVE4vaIobJvdl5eAfbAf9njI8ucDrOCNKRI6RIFaupl4d3r1oY7J
SrNUmC3i3C/QPiqrwEHn
=p4js
-----END PGP SIGNATURE-----

--ZOBTspFzEMOlPevk--
