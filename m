Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 13 May 2016 17:59:14 +0200
Message-ID: <4382613.8hyxXfBgJm@prime>
In-Reply-To: <1463153416-6569-2-git-send-email-linus.luessing@c0d3.blue>
References: <1463153416-6569-1-git-send-email-linus.luessing@c0d3.blue>
 <1463153416-6569-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart182896303.P4Uxe6qV2d";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/2] batctl: adding mcast flags debugfs
	table
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

--nextPart182896303.P4Uxe6qV2d
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

> diff --git a/README b/README
> index b5de8a6..f92bc26 100644
> --- a/README
> +++ b/README
> @@ -426,6 +426,40 @@ display or modify the multicast mode setting
> 
>  Usage: batctl multicast_mode|mm [0|1]
> 
> +batctl mcast_flags
> +=================
> +
> +display the local D.A.T. cache

DAT? This seems wrong.

The rest looks good on first glance. :)

Thanks,
    Simon
--nextPart182896303.P4Uxe6qV2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXNfnSAAoJEKEr45hCkp6hx0IP/R/LMd4g+N6ZElCWOvqh6yjn
yjRjqBx3AeS/bdzIYF4ZndX68aJutsHFliTwA7QJi8KiZlQo0JjJY0drmgL8VuwI
XU/mXs/z8r76wcs6D32X/Wu4gVfcT7wxhD5/TMJjZwLzYJ8eEaGPmXvGWr+q9k7Z
I4ociCFF0Gb/RKRjOKtZyIi2cKq/gXE7l9ChTV+5VUco+tEmffpPih+lnh7DzgWy
JN6/7kv+QiXpCKEdthZZ8yCefHao7VdGV1yUWwPuZ/yB6WtUitHjoFwiRzqRReqD
MRfjyCm0sT5y8JzFYigYH3p6BUALAoXWHfOIxDFU89i9KzEf6n3L8TGGnj1Pc+qD
p+3PLlRA2Zn+GXpSuthbx91jjNvBzB/1qXb6hK6vPWeQd0yZo0lIt58ONrRYYk+3
labAwUrr2VyA9KkQQSjXW9p0TnAstB4gmtwzD1g7JllnIW4Rzn2zcXq1mLCgvtVV
YmPJGW0ENcQfBJFNT+bJcpFsFxxhb7Dp+5YY0oQvPn/NLURkiK65x/zexuUFGLrG
GhRQbijm+o3hA4vlUk+RqRXqXUMEResTfavsmNeq/M+1bLfCRmMfiV9dKtrE51mq
UP5bTMEj8P807V8QYjNV5QnLYZKJ0tUWt1kOrOZjMYnRudS9FHpUfwNCoHOS3tjs
haAw75JmpOgTBqUDGPgA
=H+W3
-----END PGP SIGNATURE-----

--nextPart182896303.P4Uxe6qV2d--

