Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2012 21:31:32 +0200
Message-ID: <5586996.9LN2odWeYM@bentobox>
In-Reply-To: <20120511192347.GA14707@lunn.ch>
References: <1336760987-1523-1-git-send-email-sven@narfation.org>
	<20120511192347.GA14707@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2968059.I3gjbB0qBt";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Prefix non-static
	functions with batadv_
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2968059.I3gjbB0qBt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 11, 2012 09:23:47 PM Andrew Lunn wrote:
> Two probably dumb questions...
> 
> 1) Did you use objdump to check for any symbols you missed?

Please look at
 https://lists.open-mesh.org/pipermail/linux-merge/2012-May/000851.html :D

> 2) A quick look at the patch suggests its changing function names. Are
>    there any variables with global scope?

No, it changes all global symbols. That means functions and variables. Just as 
example: hardif_list

Kind regards,
	Sven
--nextPart2968059.I3gjbB0qBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPrWkUAAoJEF2HCgfBJntGGQYQAKIYlw5oaBKjdIUpSugccd1v
fuefKrInTvGPgo56F5zIX0nT2B8dJlfdVrqyZq9pNEST22ypKUxaNHVvINVG3/RJ
GI9G67SzdMEtGvXBIs0UaOvCXicH4S6ssdpySaELojzwD5ycJwUuUyctCGttIYTO
JwNgMuRZFAUaSnqC0m+OeQuchP9sy5sEj+/bIh9l5kjAqnXqoiRMgk6bOy4bCzkY
8nv+TjJoBGLUp2zMC15+AsWYZons9DASqBXpqoDWHXPnPI+HCWGdYzzYanm5yFKP
f+yr/uXs83KQtBV20mhRIK8JjJAX3EMyPQ3orjsd3CQzTcqHbLbdgkD37JKK0rq9
328DaDDd8kuXQVAQTUlQjbVU48TKBLYlAE0nDXOgT2TPhAwIwZQqln+ass+CK2io
4slBv7D71y1zSjFZh+laNVc/EQeThZ4NwuVycb/ewZkuD2ur4PXJahgzdGHfsLIs
neTdaTbpOgb7DxIBAYRbQjzrap3yw2a7rj6fX8f3iwmDySgv4ERYcikjeBsWsUuN
4DgxV0RKTIwNIl+RWTLuTmPFELiSz1cPiAFvxT+0VVhSsyG0//zlePchfPqSPIQ+
NhXRw38gpslFKrSzisKfB4pQqO/2mIBNXnm4eojSddNiYyqHd5qXHrJw8KjIwUNW
jMtKUBRYaHKEo1Klk2X2
=+qwg
-----END PGP SIGNATURE-----

--nextPart2968059.I3gjbB0qBt--

