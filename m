Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 16:28:51 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529142851.GQ3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-7-git-send-email-ordex@autistici.org>
 <20130529141657.GB23657@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0lsrIB+s628ok5gC"
Content-Disposition: inline
In-Reply-To: <20130529141657.GB23657@pandem0nium>
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


--0lsrIB+s628ok5gC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:16:57PM +0200, Simon Wunderlich wrote:
> On Wed, May 29, 2013 at 12:20:45AM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Each routing protocol has its own metric semantic and
> > therefore is the protocol itself the only component able to
> > compare two metrics to check similarity similarity.
> >=20
> > This new API allows each routing protocol to implement its
> > own logic and make the external code protocol agnostic.
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  bat_iv_ogm.c | 7 +++++++
> >  main.c       | 3 ++-
> >  main.h       | 6 ++++++
> >  types.h      | 3 +++
> >  4 files changed, 18 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> > index abf4cd3..18c9ae8 100644
> > --- a/bat_iv_ogm.c
> > +++ b/bat_iv_ogm.c
> > @@ -1441,6 +1441,12 @@ static uint32_t batadv_iv_ogm_metric_get(struct =
batadv_neigh_node *neigh_node)
> >  	return neigh_node->bat_iv.tq_avg;
> >  }
> > =20
> > +static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
> > +					    uint32_t new_metric)
> > +{
> > +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
>=20
> You might want to use abs(metric - new_metric) here, otherwise is_similar=
(a, b) output
> might differ from is_similar(b, a).

Mh..imho the name of the function is bad because this has been done on purp=
ose.

The idea is that we want to see if 'b' is at least
as good as 'a', therefore what we want to check if is b is greater than
'a - threshold' only.

Imagine that 'b' is greater than (a + threshold), for me the function has to
return true, because the metric b is at least as good as a, but if I introd=
uce
the abs() the function would return false.

Example:

a=3D190
b=3D240
threshold=3D20

a - b =3D -50 < 20 =3D> b is at least as good as a!

using abs:

abs(a - b) =3D 50 < 20 =3D> NO! b is worse than a....and this is not true.


this situation can happen in the code because usually 'a' will represents s=
ome
kind of current metric and this is not supposed to be the best ever (maybe =
we
still have to switch to a new best).

I hope I made it clear.


For me "similar" was something like: "ok, metric b comes from a link that c=
an be
used where we now have the link represented by a".


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0lsrIB+s628ok5gC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRphCjAAoJEADl0hg6qKeOuJoP/0dABKvw3aODkfO6PHrZNeYO
ZlmVZOd/dn/Him9/dthnygbf/taAHc9f7HBPBlObjhbB0C23XCAhDhrG4fxibGQT
SEvL5+uG6yOVzeTLq5rsHDk/e+b+ogjFfkQF2tmKMGC5OMVwrmZfG1oDvFI8A5/j
rZM6p8Mdqt/Vstycs3Q2MaChkU1/5RCQ5fAyN9T4XblR8QXxd5hhQ2s3O/X4wi++
NfD6ETgUqJhOQ8fQv7XnliO/OCTtB2Eq25RlFUOR/MQfyTyFSBuPay2gI+7I1QwX
5kvB/k0IbQi7RLimNsI5/3I92ehBaMHLlOWIhuRj0HTlrRnMr6yrdaFIj+T6Wrgv
r8fyqEP+5vxjMwygeVXDncaaWDuDrdAj1W6VQmjxBBP/4w7s575KCUkhBoEVVIEx
CG5SGKnpo+9okinaZF8jq3YeEreNdEA7/F3+tKI4f7ynGC167wOhqAuzzMTmiMNS
gI/dgHwA3qUOiIHMPfFJNSY6VCDU1V+LVf5ktfgIMsCKGNCgMqEZgH5zOgcemXg5
uWpdNf2DyMyX4U2YoCvFEhsmx8OFkv13oDKEKW5jMlUw40QlTPceKMzEleckjqbq
HrDqECWJfw+DWAzUaVr1ZZuQxPqOW4YQYnKtxNHi3p48u8RYJsm82A1lRATMlnDf
lULHgIH+vjp9+M1DE58Z
=hola
-----END PGP SIGNATURE-----

--0lsrIB+s628ok5gC--
