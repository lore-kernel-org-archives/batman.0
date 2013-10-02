Return-Path: <antonio@meshcoding.com>
Date: Wed, 2 Oct 2013 18:01:06 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131002160106.GA1939@neomailbox.net>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20131002130548.GA24077@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2013 at 03:05:48PM +0200, Simon Wunderlich wrote:
> > I'm also wondering if label and gateway could have more meaningful
> > names? TQ and host? Also, is TT the best?
>=20
> Hm, that is a good question. We also have the batman v with new metrics
> coming up, I'm not sure how to handle these (maybe Antonio has some
> idea?). It is not the TQ-value in the label after all, but some kind of
> ETX-converted value (255/TQ if i remember correctly).

I think the ETX stuff comes from OLSR (but I don't know the details).

I agree with Simon that we should find a generic name (e.g. metric ?) but I=
 am
not sure we can represent this value in a "algorithm-generic" fashion (and =
maybe
we don't want to).

>=20
> Maybe we can change the names to:
>  * for neighbors: router->nexthop
>  * TT: "gateway" -> "client", "router" -> "node", maybe also change TT to=
 clients?

TT is specific to the mechanism we use to announce clients.
Moving to the generic "clients" could also be ok.

> >=20
> > I would like suggestions and comments from others with more experience
> > with json. Is the basic structure O.K. Are there better names to use?
> >=20
> > There is also the issue of can we change the format of the current
> > output. Is it considered an ABI? Should I add a third format string
> > which can be passed with -f to produce true json, and leave the old
> > format as is, for backward compatibility?
>=20
> As explained above, I'd like to keep the old format, so a third format
> string should be used. It would be nice (if possible) to consider BATMAN V
> at this point too to avoid adding many more formats in the future, but
> generally I'm okay with adding new formats.
>=20

I have to think about what batman v may require. But I don't see snything
special right now.

Cheers,


--=20
Antonio Quartulli

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSTENCAAoJEADl0hg6qKeOcQYP/jQEYh1BaI9kVz41lDrvH973
AROyO5LjeTL07J+RdoEV5wEtBhhAf7oDmbTHyBJaUgmsd/DDId+b1Ix3ZeleFtbi
TXJVQ9qgi+JaJJSC5QpECgKhe+PYNphQyXAjwGUTNW3oH+pmD8cZmvQhGF2iVxxW
PchAx2M/KA1nOsYbB/J3dnyhEG3x5IXTX4d5iAfLGxZ+ZnZrufogocp78jySm4gy
0RR5yHIkWr7pvXkX8JReZRM6MLKD7o1WMwmzbG6o8GBUkl+KjS1EWFmF7CEDE6iD
7afIlrLIg9jlfpHXuwxsU9v1MujvOSbKPqxS41rs5o1FGOElOjXdVSUPruuXCA7S
8sA+koObNE8frzcl2gDD1+qiIqqe/eloW8Ci+il2Bbtv8d9CVsRW9qX3Xq0WeORO
yJQ1dpdbw7qEwnyxCzPvn3bNd3YbuFQXOR+0/poqTn74mHHeEB2TFE/B4Y+4Nelt
/HgYgYK2QpiMekOKC1gOsQNPvvRimbcI7vDEI5l7ExWeFgkFpZOHzY07XFUOEhIA
9Dpv/ws8E5qdao54McN2uFETGzgcfB6H6q7DeItK7QmtE4RbjyTrT4/TIP+lIDpb
wx2mNiwtz9qoPvJZfl170xQshThHWV4bIbHoniGCcLebKGGYCbuka1F+y0+M1Z6z
HlQQWd7052X3P6YNiE1r
=vpBD
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
