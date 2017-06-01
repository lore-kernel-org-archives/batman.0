Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 10:15:20 +0200
Message-ID: <1557491.UkJBJ90mGv@prime>
In-Reply-To: <20170601062632.4239-1-sven@narfation.org>
References: <20170601062632.4239-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2521112.rArNQU5TPf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] alfred: Check if tg hash was really
 initialized
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

--nextPart2521112.rArNQU5TPf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Thanks a lot for fixing that thing I missed and the initialization problems. I 
guess this also takes of the covery splats. I've picked all patches as they 
are.

Thanks,
     Simon

On Thursday, June 1, 2017 8:26:30 AM CEST Sven Eckelmann wrote:
> The return value check after the tg_hash_new call must actually check the
> return value and not some other datastructure.
> 
> Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/server.c b/server.c
> index 1e358cf..9774281 100644
> --- a/server.c
> +++ b/server.c
> @@ -232,7 +232,7 @@ static void update_server_info(struct globals *globals)
> 
>  	if (strcmp(globals->mesh_iface, "none") != 0) {
>  		tg_hash = tg_hash_new(globals->mesh_iface);
> -		if (!globals->data_hash) {
> +		if (!tg_hash) {
>  			fprintf(stderr, "Failed to create translation hash\n");
>  			return;
>  		}


--nextPart2521112.rArNQU5TPf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkvzRgACgkQoSvjmEKS
nqHbiA/9HCeO/OlTk5+01pUhZ6NJNTST8DvuZYTIzP3uMqdv+ArN+WZ5w6bFf5Fm
0PcHXxS+bMBljYdA0l9JBoGLA3rE82AKz2hNMW7MK52uAMqAhhujHPQEBu0xERIt
IHxELrlAa0+ua9CeUD2RD01lNDOovaXJBJlHNgJKm4/HBInR89DHwV6uIlWG+XAi
GQ6u0d1QkrJKff7KStxlQiAeWBX2tNqlIyw0LUPeGsXrAbEeZ4r/rgQe5nrKsGdM
WvDjwFWttJNDyHI+f6n/D1hRlrTAyMpTZBqXJo2ArpqlM81nfv9Lcs0kEPHkdqdn
XQZfaNMur9veTeCHQ7vhQxGpnmvoUD5KOcweHjqd72YIy6m/KvDxathxiHW20iqS
57YnadUWpdyR742DzG8rOgtQn//k3qkdx/tda7F7tXj/RfXPMhrGNEYiEPmYRpWO
HBRVR4HKTdOZU6YFuDvdJyCm8jogHGbaQ3jk/NQVQYAlQB4EjUrevpx9i6VgNhP3
6zolHl1hFFh/1ajoi+m8wGaJe9HmFsy5Fb6HeRaAJcf5ijG3TNvi3SyRpQeD3qTG
fqMOK4H8H31BbY5VsztoH0JYqlU8U7PsIwx+Mu/qtmCpd67l14fgSV4LA7s1j2wi
/6vW0/pgAHlsj+4MCDixaF5jN1khdNQtwQe8jeXcWQIRztUnxoY=
=N1zp
-----END PGP SIGNATURE-----

--nextPart2521112.rArNQU5TPf--

