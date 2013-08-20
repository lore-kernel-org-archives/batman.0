Return-Path: <ordex@autistici.org>
Date: Tue, 20 Aug 2013 08:39:06 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130820063906.GA2963@ritirata.org>
References: <1376595170-506-1-git-send-email-ordex@autistici.org>
 <1376600755-544-1-git-send-email-ordex@autistici.org>
 <20130819202028.GB18020@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20130819202028.GB18020@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: check if a softif_vlan
 already exists
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 10:20:28PM +0200, Simon Wunderlich wrote:
> Hey Antonio,
>=20
> Thanks, that solves the problem on my ancient kernel! :)
>=20
> I don't see a problem with -EEXIST (at least there is no error
> whatsoever), so I think we can leave it at that.
>=20
> Tested-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
>=20
> Just one thing ...
>=20
> On Thu, Aug 15, 2013 at 11:05:55PM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Before creating a new softif_vlan it is better to check if
> > that does already exist.
> > If so batman-adv should refuse to create a new structure
> > otherwise this would lead to an inconsistent state.
> >=20
> > Normally this is not a problem because the operating system
> > will prevent from creating the same vlan twice, but some
> > ancient kernels exhibited an improper behaviour that led to
> > a bug.
>=20
> You might want to skip that when sending upstream? They might not
> care about older kernels. Duno. :)

This patch is only for us, because it is going to be squashed with a previo=
us
one before going to David. So I'd leave the commit message as it is.

Cheers,

>=20
> Thanks!
> 	Simon



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSEw8KAAoJEADl0hg6qKeOCNUQAIIcRlOxbcBQq1XQrB5gNZ1A
zpoP3/rY5inXqRDJjlprCU8q3MOkSAGZanf0JV7U6KaaLfDFavogBBySzifrUkzq
NAKsomijBXFaKyZjv0j/TCSiM1tq/xFt5HwBRwRvgJ+q4tGhV0U7SGRyAWa7rBtw
AtZigUnvrQXlrg9wvW185eAdo1aydjLvEHRBHCF+ybICLY5SQQOJbXxzELdDubRp
JkXprL+vMA48Om0lElHOXnpk5jlP3RfUS8/oASzvBgXJ9jkXhaZoIOqDQ6mCEgQk
akMAbRVhPkXMbhzk/wVCHcDwhDR16QCtbiIUKCeJzwkLIk1eEfmnnjgQCtlUVSsi
uP340vqFLnUjORKq7Qfvm8m/XcY26FNSZU9WbKbKN/Hr/TdydveeUCYjXrhRGgUL
XvXGkpYFtCVz+3cihOnRo7YFK2Nle7ETKBbjA0kAdBurvS+JQuW3DVgswfNhxTD9
8qryQfSYM9wJbqVwaZZcH3y5Xy32tUgqdCLRstfAUFiXJ7KXhACUY1MlrVdLSI14
qPuMdsCBiZ+8WGafhomcNrLOCnYmXHneBrSG2BVoj88PtIdE1oylxNxcO21x2rdD
bKnwG+dSO5UmM30aNBf/4GLn1Bx+0n8G5SY2I07Pc9AjRQFtuFKLcfdPEPW4tgaa
i0KXfzvS/oSC2nhGkfkp
=SvzR
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
