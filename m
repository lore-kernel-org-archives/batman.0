Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 16:29:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529142934.GR3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-5-git-send-email-ordex@autistici.org>
 <20130529141758.GC23657@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zxEKvxCKojqA/Afl"
Content-Disposition: inline
In-Reply-To: <20130529141758.GC23657@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [RFC 04/10] batman-adv: add bat_get_metric API
 function
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


--zxEKvxCKojqA/Afl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:17:58PM +0200, Simon Wunderlich wrote:
> On Wed, May 29, 2013 at 12:20:43AM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Each routing algorithm may store its metric value in a
> > different place, therefore a new API function is needed in
> > order to ask the algorithm to return the metric of a given
> > originator
>=20
> This looks like a duplicate of the ogm_metric_get() patch in the same ser=
ies
> with the same number ...=20

mh, you are right. one patch less :-)
I don't know how git could allow this. And if you are wondering: yes I had =
a lot
of fun with my rebase.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--zxEKvxCKojqA/Afl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRphDOAAoJEADl0hg6qKeOrC4P/1y0dG1fFSoXyvBM/VXgO1ZJ
FaBN535PPL7DYhgCfphcDpa0auCsk/LuTvdBmsJbc1K/2heNwJ3qpLRnMBUuhhvs
zKUyjD6Co74DQ3yMWVa6C4f3hpk7aUBaCo7kNc+HW5abHCTg7ktQdXP/PjJG+uX5
5EaeMCLMAuP1YB9uPZ/C8QruDx6dDsh66YzIIC0+WOjQCriYTQ7yKf477aKng/SQ
U+eeXxvVI4XT6U/ZxXYIP4YUlaZT8tiibdziRJGhse360gC/istQHGdJfh1wtK4B
2e+GmpswmhCJ9hCBw+7LBGuvsmzBtLP4nDSbhu603uBD8pe7Lga0fX+ofBTbdb5a
9zKCfM3/VmTPftYzbHFQiUgJP9oTZrhTwWAOVeEjzre56Ve7pRn6uLDOkzsbNwru
WJzP76fGppVPiU/qa3oBJBRC1XHJzI74vo5ZIjOaWW+BoO5TUKXJk9pFe1Ah77uz
sAhliAXj7SwcDWtBMtzBWz4fRmsEJuLsBcgeZYcbxA9Xt2cpvWSrXS0f6R+xp8Ld
6Ja63Av7pPSiIAGjCoY6OnCj07ZJ5Gnbh+n0VrOePKnXiJ7SXyTrKgFIgxd69j5S
dSpS0wa0DaycdLzYK4ZUmbWiJfAi6pTwHfI5EmVxekUBcVHsTgsL/d/S8mz7k0RB
KYC3S75aOmjAt+eJy0mL
=HMpV
-----END PGP SIGNATURE-----

--zxEKvxCKojqA/Afl--
