Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 16:57:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529145754.GT3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-7-git-send-email-ordex@autistici.org>
 <20130529141657.GB23657@pandem0nium>
 <20130529142851.GQ3333@ritirata.org>
 <20130529145519.GA24352@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MI2pJyvBeFc4alSb"
Content-Disposition: inline
In-Reply-To: <20130529145519.GA24352@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [RFC 05/10] batman-adv: add
 bat_metric_is_similar API function
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


--MI2pJyvBeFc4alSb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:55:19PM +0200, Simon Wunderlich wrote:
> On Wed, May 29, 2013 at 04:28:51PM +0200, Antonio Quartulli wrote:
> > On Wed, May 29, 2013 at 04:16:57PM +0200, Simon Wunderlich wrote:
> > > On Wed, May 29, 2013 at 12:20:45AM +0200, Antonio Quartulli wrote:
> > > > From: Antonio Quartulli <antonio@open-mesh.com>
> > > >=20
> > > > Each routing protocol has its own metric semantic and
> > > > therefore is the protocol itself the only component able to
> > > > compare two metrics to check similarity similarity.
> > > >=20
> > > > This new API allows each routing protocol to implement its
> > > > own logic and make the external code protocol agnostic.
> > > >=20
> > > > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > > > ---
> > > >  bat_iv_ogm.c | 7 +++++++
> > > >  main.c       | 3 ++-
> > > >  main.h       | 6 ++++++
> > > >  types.h      | 3 +++
> > > >  4 files changed, 18 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> > > > index abf4cd3..18c9ae8 100644
> > > > --- a/bat_iv_ogm.c
> > > > +++ b/bat_iv_ogm.c
> > > > @@ -1441,6 +1441,12 @@ static uint32_t batadv_iv_ogm_metric_get(str=
uct batadv_neigh_node *neigh_node)
> > > >  	return neigh_node->bat_iv.tq_avg;
> > > >  }
> > > > =20
> > > > +static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
> > > > +					    uint32_t new_metric)
> > > > +{
> > > > +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> > >=20
> > > You might want to use abs(metric - new_metric) here, otherwise is_sim=
ilar(a, b) output
> > > might differ from is_similar(b, a).
> >=20
> > Mh..imho the name of the function is bad because this has been done on =
purpose.
>=20
> agreed, the function name is not really good. You could rename it to some=
thing like
> "is_almost_or_better()" if you keep the current semantics, although this =
is not an
> "easy name" either. Or rename it to "similar_or_greater()". Something lik=
e that
>=20
> Although ...
> >=20
> > The idea is that we want to see if 'b' is at least
> > as good as 'a', therefore what we want to check if is b is greater than
> > 'a - threshold' only.
> >=20
> > Imagine that 'b' is greater than (a + threshold), for me the function h=
as to
> > return true, because the metric b is at least as good as a, but if I in=
troduce
> > the abs() the function would return false.
> >=20
> > Example:
> >=20
> > a=3D190
> > b=3D240
> > threshold=3D20
> >=20
> > a - b =3D -50 < 20 =3D> b is at least as good as a!
> >=20
> > using abs:
> >=20
> > abs(a - b) =3D 50 < 20 =3D> NO! b is worse than a....and this is not tr=
ue.
> >=20
> >=20
> > this situation can happen in the code because usually 'a' will represen=
ts some
> > kind of current metric and this is not supposed to be the best ever (ma=
ybe we
> > still have to switch to a new best).
>=20
> ... we actually compare to the biggest value (e.g. highest gateway rank, =
highest
> bonding candidate), so I wonder if this can really happen. So adding abs(=
) would
> just make the semantics more clear without breaking the current code when=
 we simply
> replace. Although we need to check all occurences again, I'm not complete=
ly sure
> that it's always compared to the greatest member.

well the current code uses the semantic that I implemented in the API (IIRC=
) and
this is why I've done so: I wanted to keep the very same behaviour.

I'm also not entirely sure that we always compare to the greatest member.

What you are thinking about is the compare() function taking a threshold as
parameter. We can do that with the compare() API if you want, but I think we
should keep this "~is_similar()" API in order to avoid behavioural changes =
in
the code.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--MI2pJyvBeFc4alSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRphdyAAoJEADl0hg6qKeOtaMP/04OMFctDLtHw2kS4rE2xL/+
Eo7BHFJm73Pui0WkuF473gRugT9Ms1wGHY6QnY4pSZZeyfURHgEPV9NDo4sTRTdh
267LiI9bJzOdcsXR7n43a0Gr2tGSjHpVj1chupc1QmmS65nmE3QdDLu/pE0FRw3k
Swt21ltLTzw3smLJ4FIg9sorTe3+RHLY73ybRCN2ba/OIjo+03gCA+tkDMLWDrkf
gmP+CTqXxu0hglZtFCBIWMCcNSfrG4iDCSZRgxX8v3fYcq8aaxxPfG++bIMXqdRa
vGMxNigQGAvnwPF5zdDL/HbQqJ+JSWzfFfl6eCBcYXeuBd63okLXRHSCmcYQaMOo
pi+/Oa1ea0ixS9/Zl39LauuTnbCDXeGVwQvTR931IBDTUxM6a6qfXHJMWtWkl8Ao
23Z5g7SeXfUqEbn60DqkRh/a/i8k25vrEBszaeaSsD9W2dzWyrpq1gwaeGfMR7os
b5Ln4ZfRLEJe2uUwKiLHfKSFsS9tBpeceDwWVepSb1LwaZ0/MlMTbcwwWNLIXXEs
c8W9qj8UIFKAgVfkLHuJG4fSp+U2Of8uaOub+bHQnr796mQeJ3t2MgvYfFldi/Ny
q7ZS70xqdSQlWT2bW0fHPZVyn3p5AaCTqPxTAZU5jYikNg52c9rgSfGQlywzGEEA
39O3NPW4YJhr0vuG6EmN
=SwVK
-----END PGP SIGNATURE-----

--MI2pJyvBeFc4alSb--
