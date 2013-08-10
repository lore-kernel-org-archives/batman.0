Return-Path: <ordex@autistici.org>
Date: Sat, 10 Aug 2013 18:24:14 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130810162414.GE849@ritirata.org>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-6-git-send-email-ordex@autistici.org>
 <20130803211005.GD12891@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20130803211005.GD12891@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 05/10] batman-adv: add
 bat_metric_is_equiv_or_better API function
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2013 at 11:10:07PM +0200, Simon Wunderlich wrote:
> > +static bool batadv_iv_ogm_metric_is_eob(uint32_t metric, uint32_t new_=
metric)
> > +{
> > +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> > +}
> > +
>=20
> Since it's static anyway, maybe call this function batadv_iv_ogm_metric_i=
s_equiv_or_better instead? eob

if I use batadv_iv_ogm_metric_is_equiv_or_better than I have problems wit h=
the
assignment of the ops member later...line toooo long :) This is why I chose=
 that
name.

> looks so ... random. :) Also, maybe use BATADV_IV_TQ_SIMILARITY_THRESHOLD=
? Although TQ somehow implies
> BATADV_IV ...

I don't think it is correct. Metric is separated from the algorithm and and=
 this
define belongs to the metric. In the future we may have B.A.T.M.A.N. X which
wants to use the TQ again..at that point it should (re-)use all the constan=
ts we
already have.



Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSBmkuAAoJEADl0hg6qKeOfUEP/jtp0spVF6p33+WI0dIzzofN
XsmriPNh2Dk6bfOqLZGc5es3SDbwUYcmhidluGhVXJZ8LgfxtZzUHSQFRrp18EDh
iUzokTwLXQ6icS3zkmPUBQb7CndFSM9Lo6Y5lKxqhoJL6uzawrlQzRTX1bwFoo+y
Qtce/pnqmTlIqE0YdJPwwVqeDS7z3iJlDJPqW4hiyOdHjvDZxKjeUVgRG4Ud1Aqf
ZDe4slhIOma/4K55GMLzM5MNRrJeTEpRL/aRyVeoAuS9GneDFCd21geQ24eCRWby
nx+q60YPTjWUjqauDyTvzwGH891Sy76y3oFIWWJ8BnCm2871E7V2BRDlImwVFmSr
bymYWublsprbt+9yZBzZTeSClLOnzRVjcCNe+VdaESr3R7RNBrhv2tLEgpNFS1E7
zrspU09guDiI+eh1LwJUaNrWz6VlFRvGGX7+MVh53zPNSmXqP/uxQe/4NM3UPM6A
2xUCk/6W0uV0F29oF25GWHKvUFs7NOcFqTUyvd3adeL4243O3j9tRrlEmwPt69Kz
zuhGtHTGCBKGPfHKfZosLN5za9mIzWsY0P8ZJ10Ya2dXa2fjajBzQQkYYQa8J40m
ki6OdFcr1a0OvMDcscY5FBs3AfeYEPLG6PGCSpaH9+A8bos8/ZmN1n3R+IhoTXQH
SNFlxJoFGW4nspQmaFfS
=6WP+
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
