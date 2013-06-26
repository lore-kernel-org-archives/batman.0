Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 10:59:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626085934.GL3136@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-7-git-send-email-ordex@autistici.org>
 <20130529141657.GB23657@pandem0nium>
 <20130529142851.GQ3333@ritirata.org>
 <20130529145519.GA24352@pandem0nium>
 <20130529145754.GT3333@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20130529145754.GT3333@ritirata.org>
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


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:57:54PM +0200, Antonio Quartulli wrote:
> > > > > +static bool batadv_iv_ogm_metric_is_similar(uint32_t metric,
> > > > > +					    uint32_t new_metric)
> > > > > +{
> > > > > +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> > > >=20
> > > > You might want to use abs(metric - new_metric) here, otherwise is_s=
imilar(a, b) output
> > > > might differ from is_similar(b, a).
> > >=20
> > > Mh..imho the name of the function is bad because this has been done o=
n purpose.
> >=20
> > agreed, the function name is not really good. You could rename it to so=
mething like
> > "is_almost_or_better()" if you keep the current semantics, although thi=
s is not an
> > "easy name" either. Or rename it to "similar_or_greater()". Something l=
ike that
> >=20
> > Although ...
> > >=20
> > > The idea is that we want to see if 'b' is at least
> > > as good as 'a', therefore what we want to check if is b is greater th=
an
> > > 'a - threshold' only.
> > >=20
> > > Imagine that 'b' is greater than (a + threshold), for me the function=
 has to
> > > return true, because the metric b is at least as good as a, but if I =
introduce
> > > the abs() the function would return false.
> > >=20
> > > Example:
> > >=20
> > > a=3D190
> > > b=3D240
> > > threshold=3D20
> > >=20
> > > a - b =3D -50 < 20 =3D> b is at least as good as a!
> > >=20
> > > using abs:
> > >=20
> > > abs(a - b) =3D 50 < 20 =3D> NO! b is worse than a....and this is not =
true.
> > >=20
> > >=20
> > > this situation can happen in the code because usually 'a' will repres=
ents some
> > > kind of current metric and this is not supposed to be the best ever (=
maybe we
> > > still have to switch to a new best).
> >=20
> > ... we actually compare to the biggest value (e.g. highest gateway rank=
, highest
> > bonding candidate), so I wonder if this can really happen. So adding ab=
s() would
> > just make the semantics more clear without breaking the current code wh=
en we simply
> > replace. Although we need to check all occurences again, I'm not comple=
tely sure
> > that it's always compared to the greatest member.
>=20
> well the current code uses the semantic that I implemented in the API (II=
RC) and
> this is why I've done so: I wanted to keep the very same behaviour.
>=20
> I'm also not entirely sure that we always compare to the greatest member.
>=20
> What you are thinking about is the compare() function taking a threshold =
as
> parameter. We can do that with the compare() API if you want, but I think=
 we
> should keep this "~is_similar()" API in order to avoid behavioural change=
s in
> the code.
>=20


so I'll go for "bat_metric_is_alike_or_better"...we couldn't find a better
name..but if you have one :) let me know


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyq12AAoJEADl0hg6qKeONM0P+gLmwSnWNtkArUNMNth3ReVV
kF5tErOEeBaNEd6FDwWb34X55L+MEvh6HAYT/haX+RTzGu9ZRbEu5HCUs1s0u5cx
P1R/8BNCi4hERycZERfLRhNjL+TFUx8nCFykZuGO8gFKFIbtHX8dbs7CFbQmvo3f
fXiSrl8pB1C5iu9p9/DbPYGYs6dw5PIpChi8e2WSVUgJL3EgR3Ca4Dq9L9XVzHNo
qyrDrquPWDKEI7hKm0++fdKCLqYam+dZXtuaRht7B/GBpGJwknyLI31JstpPbzco
7J69jMWiWbVq7hkyHCiuE1/JO5qyQ7Wc0KmqrSHf5BZAMAom2dm67uc21Zqumo98
yBCKB/KyfsZQdpLMmpumxKHt6kfnAKGv3AHN+6uzNHvH77xa8er80KMp5Z2oBKSh
PFJrwXGu+tF9fVBU3hgjSkskvZuUD8Q/UqJtLsHu3HLDjjEZKz/CzRM0WBhN9i/1
TaDC6pad13KHAf5nNUAzvzD8DOonGoYp3h5b7pi+OremZBA9gXeNUM9U9L9O86Mv
jSEhiDjd+fHvoPS5DVC9ng8NcthN+GwmbVaMCMhHQemo1x7Z4vhHFuWc+jjuuhET
B4QjF+ie3NO2GBO7VfuiOSOovwCYTeNkgvmV3DIwvDMidcX6mIsbeJ6tFPbrXToI
p3C/J054dND1o14/1a6U
=7SZ4
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
