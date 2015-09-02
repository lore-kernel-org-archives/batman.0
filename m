Return-Path: <antonio@meshcoding.com>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
 <1441217396-18043-3-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E73BB5.7050702@meshcoding.com>
Date: Wed, 2 Sep 2015 20:11:01 +0200
MIME-Version: 1.0
In-Reply-To: <1441217396-18043-3-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8MR7kjMc582U5v8Fmf3gDFcR0cQl3oUc2"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 2/3] batman-adv: avoid keeping
 false temporary entry
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8MR7kjMc582U5v8Fmf3gDFcR0cQl3oUc2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/09/15 20:09, Simon Wunderlich wrote:
> In the case when a temporary entry is added first and a proper tt entry=

> is added after that, the temporary tt entry is kept in the orig list.
> However the temporary flag is removed at this point, and therefore the
> purge function can not find this temporary entry anymore.
>=20
> Therefore, remove the previous temp entry before adding the new proper
> one.
>=20
> This case can happen if a client behind a given originator moves before=

> the TT announcement is sent out. Other than that, this case can also be=

> created by bogus or malicious payload frames for VLANs which are not
> existent on the sending originator.
>=20
> Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

--=20
Antonio Quartulli


--8MR7kjMc582U5v8Fmf3gDFcR0cQl3oUc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5zu8AAoJEOb/4TMchkvfcz0QAJ/sBGesEmdrd8CfcGKhsBhM
9uOVHI8qPs+W2P7vxVawpqe89pZzWaM4GvdQ22rSS5eBt1pkS8QWz9/ZBKMU6qf7
fzj2+j0ALYQ1C85QlAj1TmRIRq0BS/99hjzY15IhBujkWeqbRtHk9xpLT5ju09p1
INDNg+NQZeLYeMiCqfohlWo7KxEqhFEu4fsl+QhgEKiX833w6R8qKkzF14LfepoX
OTDRez4oqWtMpnL77rmhQMwcY1nzSYg1QeMzXZQVPAfDOcduESjFKPXeYa8J+taT
f367XtJ0K8UZtzOW3jIvr/NZw48F98atwSAP4J5kV/N0PnshXBcHlo4wuxV98eEy
UuOwwjnenNy/FCxJVSDu8kZJXUuyl8OrAQ3CcdIjq3ajEOHvogXlon5BzfInSosI
K3O6dcRarbziFY3lwXVFOXhHRGbmmPfgNzioPTKZARHDtC3nEc5AbTajiGtwqqq7
XxGnK2INppxZK8iIgCpNcsfaa6iuXOWhnq33JuARVfm+qdtthuu6dpEygHDhJshY
WketbRs+S3NHu3kMYsuuE7DZyO+djA2t9fr257CMDFAHhcu8agZZHNmlCyeOmQfS
C7sZB+oCr/NJqzLQ1Jpit3hk9E0UzJUjN9lzkqbDorj8tON+87g6wOaJLraG6rlo
vcIe6IyhSqxiSWWI0uGJ
=Oups
-----END PGP SIGNATURE-----

--8MR7kjMc582U5v8Fmf3gDFcR0cQl3oUc2--
