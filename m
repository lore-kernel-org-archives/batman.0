Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 27 Jan 2017 15:10:05 +0100
Message-ID: <1865571.PHlDmin6Ej@prime>
In-Reply-To: <1485483789-5327-1-git-send-email-jhaws@sdl.usu.edu>
References: <1485483789-5327-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4358055.vCQetceeIN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v1] alfred: Formatting patch for
	sync-period casts
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart4358055.vCQetceeIN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Thanks Jonathan,

I've added your sign-off manually (but only this time, since its so trivial! 
please don't forget it on other patches) and adjusted the subject. The patch 
can be found in revision c73e56c.

Thanks,
     Simon

On Thursday, January 26, 2017 7:23:09 PM CET Jonathan Haws wrote:
> ---
>  main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/main.c b/main.c
> index 1cabe15..446eecf 100644
> --- a/main.c
> +++ b/main.c
> @@ -276,8 +276,8 @@ static struct globals *alfred_init(int argc, char
> *argv[]) return NULL;
>  		case 'p':
>  			sync_period = strtod(optarg, NULL);
> -			globals->sync_period.tv_sec = (int) sync_period;
> -			globals->sync_period.tv_nsec = (double) (sync_period - (int)
> sync_period) * 1e9; +			globals->sync_period.tv_sec = (int)sync_period;
> +			globals->sync_period.tv_nsec = (double)(sync_period - 
(int)sync_period)
> * 1e9; printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n",
> sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
> break;
>  		case '4':


--nextPart4358055.vCQetceeIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliLVL0ACgkQoSvjmEKS
nqEF3A//ftRcA4ndaWHxhOmPes/HxBu1wHrVAuiQj5C+1v12urziZqIyfIBaCo9d
sxgCmaXca128CO3t5sw22kGlSfrJ8SgO946ZYdyoFNyffvPfwUtChzqmTZYQeRBK
dAJU5pEP++IIxV1irsh+o15d2yA2TpEfw54gUK8ZPm4LTNVfkLjH7ByRMZD6j3mc
q38dq6V82Y/tAgz7L7i+YfcUiMxCwMWrJl16Zw8foB3EbnbpSrxyuENdSjkZ+g7B
mUp262UEQXdk7f4e0M2hD7j/IcoHEZqLqwLdv7roprzt/ntUlnKX3pFo1/RzlbJm
thQ0tcmdh0ZenYMtqN98NaGgbWvc7m1DHynb5P7vW5Yg9LGFaFIkvx7sitneJUBI
89Yy3EyRCpsyErHJgqtmbgLYtBu2VinV8dC7YzexJAfKXA18cvkAuJny4ObJIbjv
NQdLtNyjS5gK3zlJWxVoLY4sdwi/1LgKTwBlne/s2BRfdJZRtIFYVbXVyWXgvXvZ
uPKpjm5Qtkghltimus9IT/ynLcmXJ2XslttYjaVY9rng8rCdP7j+vdC3wIYZI9ZQ
FH2a9ukvPKR//Pa9+1L9lDegKx2STE2Vlb1bFE2CFdWO0g9d6Av6aw+hKAzRhDgN
859b1z+T4p0/PScB3m1JfTzf/5TfXaE9coLTdkzRUnThvUR82SE=
=2+Wa
-----END PGP SIGNATURE-----

--nextPart4358055.vCQetceeIN--

