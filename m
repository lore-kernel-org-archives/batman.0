Return-Path: <a@unstable.cc>
Date: Thu, 5 May 2016 23:12:20 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160505151220.GP11201@prodigo.lan>
References: <1457775018-16546-1-git-send-email-sven@narfation.org>
 <2831615.2xmdSus33c@voltaire> <20160505144727.GO11201@prodigo.lan>
 <2301460.z7t4xX8ItU@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUcp5/vPb8ZOOFiR"
Content-Disposition: inline
In-Reply-To: <2301460.z7t4xX8ItU@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: use static string for
 table headers
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


--SUcp5/vPb8ZOOFiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 05:10:28PM +0200, Sven Eckelmann wrote:
> On Thursday 05 May 2016 22:47:27 Antonio Quartulli wrote:
> [...]
> > > >  net/batman-adv/bat_iv_ogm.c            | 8 +++-----
> > > >  net/batman-adv/bat_v.c                 | 9 ++++-----
> > > >  net/batman-adv/bridge_loop_avoidance.c | 7 +++----
> > > >  net/batman-adv/distributed-arp-table.c | 4 ++--
> > > >  net/batman-adv/translation-table.c     | 9 ++++-----
> > > >  5 files changed, 16 insertions(+), 21 deletions(-)
> > >=20
> > > Applied in revision f7be1df.
> >=20
> > The Gateway table was missed here ..
>=20
> Yes, it was also not part your first patch:
>  https://patchwork.open-mesh.org/patch/3599/

Working on that now. I will provide a patch for this.

Cheers,


--=20
Antonio Quartulli

--SUcp5/vPb8ZOOFiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXK2LUAAoJEJ4aZjxxc6bK5fEP/3g8vas2Dn4NCikk3X9o6M7D
nXT2fXhb2Ay2KPwPa3RYc4oZ95J7A7PoF2geacuCitmymuCEVfp6QXeOT4Haedo1
5TrCzjWFnsSXoIEYY1AqDFHUCMIOgNygrvF97UUuGDQYHCOOUKUBqbmieC1dbDv6
YnBZHMcQOqoT66SKQnkO/JoWhiqmnLiET6fhR3gIq4Fhe/AsAOEYE/Fz3wSykGVt
z7OfTUTW3dN0IDLHiH5s+RYgB6R2y5wsOO90z6t/r5TOJTcLSjWBzW0Ls/CcNrR6
jd2EKeG/GlmqXbWgtn1JmDEpf6IQ6uGh2F/n/lAGOiNDw9WVVG+Jde1r44dF1t9v
gLGJwuDPNkMGXTHV6dLBhVrep/azFMVm/wjzokCUZHABR+RwHMB5FfTn0bO/HAQY
SZsO9zAG1T/28eqa2TtIdLWENY9HDc3qUkuzNSIV0YYA+ot3ySKV2WZUPy62Z2OD
BmaRdIi7IHPoPog+btNGN0uM1p6YWGL8n42Q2MrYuDjK1LYY2CtHxiA31vqOUzWO
UlUeq92PiVlRNPgaXMjfcBF66FmhgWbhqjK7MS77jisrOVIeFUWfGyQxqHX7QBZr
57KTbplzhsYt9H7OvmfHqty9uynwSJ9Gh/vSTaZhXTKX7e/cs65y2nDwAUDiBKuM
3ke7P4syGsWxSPqU6xW5
=Dk3V
-----END PGP SIGNATURE-----

--SUcp5/vPb8ZOOFiR--
