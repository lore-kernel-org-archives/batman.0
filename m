Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Sun, 09 Jun 2019 13:09:54 +0200
Message-ID: <1947180.xEAkfTJNMO@sven-edge>
In-Reply-To: <20190609101922.2366-1-treffer@measite.de>
References: <20190609101922.2366-1-treffer@measite.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2162718.gB7noGsGIn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2162718.gB7noGsGIn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 9 June 2019 12:19:22 CEST Ren=E9 Treffer wrote:
> -       u32 throughput;
> +       u32 throughput, rx, tx;

Avoid adding multiple variable declarations in a single line. And prefer=20
ordering declarations longest to shortest.

[...]
> +		// try to estimate en expected throughput based on reported rx/tx rates
> +		// 1/3 of tx or 1/3 of the average of rx and tx, whichever is smaller

And for the next version of the patch, please also use the same comment sty=
le=20
as the rest of the code [1,2].

And please explain also where the magic 1/3 comes from.

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/v5.1/process/coding-style.html
[2] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
--nextPart2162718.gB7noGsGIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz86QIACgkQXYcKB8Em
e0aDjhAAu4iypNJNnDhsHSGtCap1wcZZCDiOdAl1aZVF6FC1GJCVw/SuYI1c5dmZ
xYP0bNtzKP6drYkHK1OjyKYskvhHBhARXbmy0fUgW/Yrz2N00zZRG8Eyjux+aiOx
KiyAH5fYYLr8DAVTvAJ9o3+3f62sxhbjtruK069CSZSkiP/ga1OuKDWg/6+D6SSR
baFiEbMI0Ql61+tngYlc+rVX+K5e9t170d/8DdkEbAoBakQL3JAoX0QnfGGFx/Ym
sGcUcsyWcXfzSc917t8pQgI5euA+dMZAUhywNVxj5SyqOB4YygerwmheWj9vxqkf
v1wZ9flWZeYRGoW2nV8yW6Khx5xiAjiAYEen7zk55vLl9rEwDu6NRYWTOTMZ1Neo
yaXWbu+tYmMz07muG8Ze2TaW9XupVYXgqZfN0pRPqOCTj7GZp4aihNRndTcOfWNX
pns6SDxHYuccFL51B4ZKBmd0y0YA1hvcV5yI1m3AxrT1P8SZFr8zWlDz0oXGrDP5
LnzZeFO+oGR1Tuzt+T/AzWHTH4ALdL+vidhsIu9a5dpZcLcB6cy2H0Cig3j1jQY6
HfuuUd3QYiFj/8bjJmAPODMDdzSpP5CzPOAHeyYTLV92HysyZiMz68QfzviGtSzn
HjYzHAtpdkXuTOLGNo6qEsKAiDjmk4jau0rFv1gx3P3lkLACoIQ=
=Xz1Y
-----END PGP SIGNATURE-----

--nextPart2162718.gB7noGsGIn--



