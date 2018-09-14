Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 14 Sep 2018 19:48:38 +0200
Message-ID: <1593180.YIzXqLAnu7@sven-edge>
In-Reply-To: <20180717181108.2844-1-sven@narfation.org>
References: <20180717181108.2844-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2396136.fbkgCZF29T";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Disable MCAST during
 compilation
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

--nextPart2396136.fbkgCZF29T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 17. Juli 2018 20:11:08 CEST Sven Eckelmann wrote:
> The multicast optimization compile option is disabled by default in the
> Kconfig of batman-adv. The out-of-tree module should keep this setting in
> sync and thus has to also disable the build of multicast optimization by
> default.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile               | 2 +-
>  README.external.rst    | 2 +-
>  gen-compat-autoconf.sh | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied as c79a99f58a26 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c79a99f58a2649c0cfc1e2ab1e013bfa4e30079b

--nextPart2396136.fbkgCZF29T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlub9HYACgkQXYcKB8Em
e0ayRRAA0h5+AXdMS6ofvrrs5jxOG2Qz8Xneqq8NLNApeUkGUFdSuIzXggCl+9nR
0bObI/hsFCwqynphphG1bOWvLFIBHSu76gz3fowRkjGnnKoiVhI/o6inLuibFFkq
zA5u4W9G4tq6QX2euw3qqJ76A7ScBD36e7JpBeKJXOTERx8ClktRi7kWq4esrGpH
k3jqGnSdcKntUr73ONZ6YcgP5J3ndfaIQz13CAS2s4mqm7YOk9XFvp9kJBY1GKfl
E3W1fw8QIXqH9tecmXYzZGlS8eE7Kyj7aN4VGoA/xL5sPSP004+LAx5w+0RwTJqV
2Hd3RtlenxGRbcO4CVEC2B/fAkEw5saZD5G5mNjN4EEIny5dP5Z1gomR77PerVoP
vCcffZ+xmve/RBBnYiflx9c9N4RTmwQOt5QfbqcPwkp+A1jd9p8NGRNthaF+n2vT
qnfRFI0UECwJfF2n62g/sGOg1g/KM0+woE0eqhLMfdscNzwqEKRs3eH2z0ZnP3G6
FrQEVfZ8So2QVCHdKSnzor9ixqk6GtIlqrnwX4pf0MPhGNiU9plNLrZeeGn9aVsY
f/jE56A4bz6mE72drCcjj2q8KXt8KiuZZ5MjQuJp2chXniAynEAzHe2rsHVYbj/W
xgYATcSRSb8cIQPTRZTrl+R4sgRFEGkhBYFR5Vvc7b8lSiQvf9k=
=CDyg
-----END PGP SIGNATURE-----

--nextPart2396136.fbkgCZF29T--



