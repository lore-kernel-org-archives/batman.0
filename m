Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4] alfred: introduce 'server status' IPC call
Date: Mon, 21 Feb 2022 10:14:18 +0100
Message-ID: <49865018.WmOq9pY62i@ripper>
In-Reply-To: <20220220183614.54865-1-mareklindner@neomailbox.ch>
References: <20220220183614.54865-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3242400.sB13epYpGi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart3242400.sB13epYpGi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v4] alfred: introduce 'server status' IPC call
Date: Mon, 21 Feb 2022 10:14:18 +0100
Message-ID: <49865018.WmOq9pY62i@ripper>
In-Reply-To: <20220220183614.54865-1-mareklindner@neomailbox.ch>
References: <20220220183614.54865-1-mareklindner@neomailbox.ch>

On Sunday, 20 February 2022 19:36:14 CET Marek Lindner wrote:
> diff --git a/alfred.h b/alfred.h
> index 9ab92a2..598d38b 100644
> --- a/alfred.h
> +++ b/alfred.h
> @@ -33,6 +33,9 @@
>  #define FIXED_TLV_LEN(__tlv_type) \
>         htons(sizeof(__tlv_type) - sizeof(__tlv_type.header))
>  
> +#define FIXED_TLV_LEN_PTR(__tlv_type) \
> +       htons(sizeof(*__tlv_type) - sizeof(__tlv_type->header))
> +

This doesn't apply on master. And also doesn't make a lot of sense, because 
you can now just use FIXED_TLV_LEN(*whatever). So I have dropped this part and 
applied the rest.

Btw. good that you've spotted some prints to stderr which should actually be 
to stdout. You only missed it for "mode: unknown". I have also fixed this.

Kind regards,
	Sven
--nextPart3242400.sB13epYpGi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmITV+oACgkQXYcKB8Em
e0Ze7hAAlG3PmLCTqgMIhTJUNSzM+xYY9LEEMr4gA5SMVdi+IrN8n3bMWF/0Fuog
6bRDa/fAHXfNVcC8XzmOzY+U9HrIx2fU2E/BywR7ko1/htuddChunvKtxwhO+ckn
Y9Lrxh3kkUo/NAsyvstpWupw6g2bE48C2XlNyXS7L5/lpB4ahNKBT5ISmiekyVHh
Lrk2OINPDy2JhR7XaBYSc0H7GEQhi+KK/TZ7N6xP+VgjWoQlr2UEi9xRgMRkLmmU
/7Awj7bf2LE75Nm5QsD8bPgGPclLIOomKfEhCc1Ox88OKSv8Jm7beHswcb0VVG1g
IrbyLiM2FMOlcU4Amjn18c0OtK1RPwKnjE32XGp0Dx96PWtT8QHTNpNqeWo8I/bY
Kl9sZdcJ6gyw0C5D5XgxvIGgDnncJbaPot+9pOIzKQZ1Z90v+i+msPhw6L7G9UTW
Y/MWYTEyun/Dg+BcxdbccQXnMoEM+tnlMa0nABfuDdRPWKPq0imeUw5HcJE6lnrF
91+jJVxA7YixQyDlMkBRpNHec2Gpd0A603rJkrI8uKLYmA+yQ4gXMG7xVoKv1kkg
yXJWJMKth1BhEggUV+lBiwlKG7iapMMYU7EYsBD3tFTJJn1GUuNNCWgX0EkmzlQx
NeYhDyrxK9p9dWQcH+Og4lX0MeuG2waAIE7o5Bt4i/sTBwsDNWo=
=moav
-----END PGP SIGNATURE-----

--nextPart3242400.sB13epYpGi--


