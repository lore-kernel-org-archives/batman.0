Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 16 Dec 2009 16:57:27 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091216155727.GA21394@pandem0nium>
References: <1260890410-27960-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1260890410-27960-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman-debug4] Fix small typo
	"unkown"	-> "unknown"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

thank you, applied in revision 1500.

best regards
	Simon
On Tue, Dec 15, 2009 at 04:20:10PM +0100, Sven Eckelmann wrote:
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman-debug4.pl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-debug4.pl b/batman-debug4.pl
> index b2f9f45..1322b32 100755
> --- a/batman-debug4.pl
> +++ b/batman-debug4.pl
> @@ -100,7 +100,7 @@ while ( <BATMANLOG> ) {
> =20
>  				$receive_hash{ $last_orig }{ $last_neigh }{ "uni_flag" }++;
> =20
> -			} elsif ( m/OGM\ via\ unkown\ neighbor/ ) {
> +			} elsif ( m/OGM\ via\ unknown\ neighbor/ ) {
> =20
>  				$receive_hash{ $last_orig }{ $last_neigh }{ "unknown" }++;
> =20
> --=20
> 1.6.5.4
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkspA2cACgkQrzg/fFk7axYewQCgwtc03xaHVoe1a5bLZ1mDVzpq
X7cAoIvyW2AE+5fM5hFGzAxUSbPCXrsj
=WMTy
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
