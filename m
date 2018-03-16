Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Mar 2018 22:25:36 +0100
Message-ID: <2296963.xb5DcbEhU8@sven-edge>
In-Reply-To: <4626296.strlS8ikrF@sven-edge>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
 <4626296.strlS8ikrF@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3659307.AQ23XGVrbs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify
 batadv packet header before pulling it
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3659307.AQ23XGVrbs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 21:24:32 CET Sven Eckelmann wrote:
> On Freitag, 16. M=E4rz 2018 11:29:11 CET Matthias Schiffer wrote:
> > +       skb_push_rcsum(skb, hdr_size);
>=20
> This function is only available since Linux 4.7. Compat code support must=
=20
> be added to avoid build problems with oler kernels. An example can be
> found in=20
> https://git.open-mesh.org/batman-adv.git/commit/9f2b23430dec8caceedf996eb=
8ec75d3f8674144

Looks like the dependency skb_postpush_rcsum was added in 4.5. The
corrected version can be found in=20
https://git.open-mesh.org/batman-adv.git/commit/9269709d9dabf13e70f1be2fe62=
2278648f47017

Kind regards,
	Sven
--nextPart3659307.AQ23XGVrbs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqsNlAACgkQXYcKB8Em
e0Yvsg//V5EW4js2DfUbwtqBEZe+FOqm8AvbSKTkHjZcsre/kyKPe7ajstMuRz0X
N1RYffh2lAu0OGsWh/HTX689BpeLjTCyaAtoNHrHXmL/8H+dtc9sEAPzzQnmOhvP
Q2+Ulxhrf3hia5IvWFHCul7n1edJQa3seNjvMolMKWm4AwKT7aBF2VWqSuSsvDQL
SZT5w+IYjdITtEB6gq4VNzvQ1uJ/V/wM9rp/FHDzPXvpcMmrupZ2/qHhcw/wdOm3
eU7rZuoA46d2leyxxw9WuxFb5nMdsfVPHyaGXhnlb35o4HsiS1E8ioXV+xrTvqoX
IX5vsZjmGGswo/QI3SqVm2jHy8mzg8V7QPZJqy6jzZBf+2mAWdMbCEPU+AGkYYRU
JC3CEopL6N2Uu1aTFfGD289rihTTXr8XS0BhQlxm+aENSEgBDugJCZ1bbb9WVcTD
KjQSvcMvxa/dOoTEFHgGwmGTXP2Txw5wAgfDVMLuF0STEZoVzf/RrbE1Y+EwGapa
1UxaHWrNIZku+2nAW898PKHUZg4NTFFWoIDQzOSNEm0qPX10mr6k5lBz05n/M4dd
gUFXmVzhMdnSmp93aAzc/XDVuLqqFu6hFEpFrw6YCRLQqLM9xGcuTx4I7AfV6FBg
sRxMPkGAplmR16QUDHSCJ69O/nVfUSiVl2bp/Jn+pT/0nJsLvPE=
=of5a
-----END PGP SIGNATURE-----

--nextPart3659307.AQ23XGVrbs--

