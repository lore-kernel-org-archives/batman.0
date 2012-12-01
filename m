Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 18:07:19 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201170718.GP24115@ritirata.org>
References: <1353931112-17392-1-git-send-email-sven@narfation.org>
 <1353931112-17392-5-git-send-email-sven@narfation.org>
 <20121201164044.GO24115@ritirata.org>
 <5918074.YCMEhHtl7H@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4ickEXl+ukcSQ/3E"
Content-Disposition: inline
In-Reply-To: <5918074.YCMEhHtl7H@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/5] batman-adv: Allow to use different
 sized hash locks array
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


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 05:58:22PM +0100, Sven Eckelmann wrote:
> On Saturday 01 December 2012 17:40:45 Antonio Quartulli wrote:
> > On Mon, Nov 26, 2012 at 12:58:32PM +0100, Sven Eckelmann wrote:
> > > The amount of locks of a hash directly affects the parallelity when a=
ll
> > > access independent parts of the hash. But this also affects the amoun=
t of
> > > memory used for each hash. Allowing to decouple the hash size and the
> > > lock size allows to reduce this memory consumption for hashes which d=
on't
> > > allow this parallelism.
> > >=20
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > > ---
> > >=20
> > >  bridge_loop_avoidance.c |   28 ++++++++++++++--------------
> > >  distributed-arp-table.c |   16 ++++++++--------
> > >  distributed-arp-table.h |    6 +++---
> > >  hash.h                  |   19 +++++++++----------
> > >  originator.c            |    6 ++++--
> > >  originator.h            |   13 +++++--------
> > >  translation-table.c     |   22 ++++++++++++++--------
> > >  vis.c                   |    8 ++++----
> > >  8 files changed, 61 insertions(+), 57 deletions(-)
> > >=20
> > > diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> > > index 1a78bac..781119f 100644
> > > --- a/bridge_loop_avoidance.c
> > > +++ b/bridge_loop_avoidance.c
> > > @@ -38,7 +38,7 @@ static void batadv_bla_send_announce(struct batadv_=
priv
> > > *bat_priv,>=20
> > >  				     struct batadv_backbone_gw *backbone_gw);
> > > =20
> > >  /* return the index of the claim */
> > >=20
> > > -static inline uint32_t batadv_choose_claim(const void *data, uint32_t
> > > size) +static inline uint32_t batadv_choose_claim(const void *data)
> > >=20
> > >  {
> > > =20
> > >  	struct batadv_claim *claim =3D (struct batadv_claim *)data;
> > >  	uint32_t hash;
> > >=20
> > > @@ -46,12 +46,11 @@ static inline uint32_t batadv_choose_claim(const =
void
> > > *data, uint32_t size)>=20
> > >  	hash =3D jhash(&claim->addr, sizeof(claim->addr), 0);
> > >  	hash =3D jhash(&claim->vid, sizeof(claim->vid), hash);
> > >=20
> > > -	return hash % size;
> > > +	return hash;
> >=20
> > I do not fully understand how having the mod operation inside the funct=
ion
> > would prevent the decoupling. Why you need to move it out?
>=20
> Because following calculations can create different results:
>=20
> * (i % hashsize) % locksize
> * (i % locksize)
>=20
> Example:
> * (21 % 4) % 3 =3D=3D 1
> * 21 % 3 =3D=3D 0
>=20
> And of course, we could use only the first calculation. But then we would=
 end=20
> up in having more hash buckets mapped in the first part of the locks when=
=20
> hashsize > locksize.

Yeah this is what I had in mind, but I didn't think to the distribution eff=
ect.
Well, even doing your way I think the distribution is not uniform at all. B=
ut
the effect is minimized with respect of the first case.

I think it is worth leaving it as you posted.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--4ickEXl+ukcSQ/3E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQujlGAAoJEADl0hg6qKeOy3YP/0w82BapIv+LZrIZKc/8S+V8
glmmF0kHAkeBi7AZR1L0FO1lJx9YquxXRKRlcyEhUHmPJlQcGfldBzUinkHbk0NM
XzdnIbY2hKdXOFhcG95mbmTJHk2l/qDKVy+q4IIIYnrXoBzGY11bfjMIdjCtaF16
jPQVuEnq09LmgWJE6bQEVYlv+SG6G82lYQvQ0npt0FCAKjTk5xnxHjZmrvgSr/uB
HOf8CxCOucXnCxA72DvSYRgRllphx0hPgJcugC3BQRyw8RXLmw8AABZZdg9oiasx
NwSlKwBHokJiUY/cixSUlnoIoCBNIRj6KCF2MhrtBgIwxY2uUlEm5VsWKb2NHQFi
cU2QhK66JFtwTq/BlMTdNtRP/ci3s4Yn84q2bfwFqKTzQbdhGoFDfWdVUbbrkTcT
bBr36wJydjo5NbphGC10JUuAgvP0b34K7hBw9pomLCvF/oQHTbsCcwjtx6GGl+rQ
JOrQyPrjEERPp4O6e8aI5vxHBYKwpVbcFA6NPd61nwqvXHruBSomfGedJiP0878v
GhceiKOVow3Ur5FwJdfZcLwk3aSjKCjjpsYFEyrUROfvWCNRgU84l6k/vNC93CWR
9Qn+Y5gpUDiMbL+JufeD2gcSdPu0VLO6r79NkBPgf6fm8FlsDOEPQavjS0lzYJ+z
degovG1RYwatKFroCEuN
=YGuh
-----END PGP SIGNATURE-----

--4ickEXl+ukcSQ/3E--
