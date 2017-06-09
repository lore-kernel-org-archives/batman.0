Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 09 Jun 2017 10:29:00 +0200
Message-ID: <2619130.mzRjIueMWn@bentobox>
In-Reply-To: <20170601151126.20708-1-sw@simonwunderlich.de>
References: <20170601151126.20708-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2501163.yGnNtpWTg7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: do not add loop
 detection mac addresses to global tt
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

--nextPart2501163.yGnNtpWTg7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 1. Juni 2017 17:11:24 CEST Simon Wunderlich wrote:
> This change has been made for local TT already, add another one for
> global TT - but only for temporary entries (aka speedy join), to prevent
> inconsistencies between local and global tables in case an older
> batman-adv version is still announcing those entries from its local
> table.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/translation-table.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Added both patches as 1f1b6c0d9612 [1] and 746ee78cd190 [2].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/1f1b6c0d96129e6445652061d93a7fb1f0476fa3
[2] https://git.open-mesh.org/batman-adv.git/commit/746ee78cd190b7ec9eeb15feaaa32fc6811320d0
--nextPart2501163.yGnNtpWTg7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlk6XE0ACgkQXYcKB8Em
e0aZJhAAyH8lJkPztVyawSkRBORoErsrrmLsaTMupzTv8GoLLzlfv/3VtAhkIQZK
9zykLt1vy1f8x9lbI8+3UHIMbkoWP/AJUw4ssCkqtV4kikYIZJSEw7WdLfO1xpip
feTxzGPxfXza7ViahAui59uXyKB0GSYA5E+Y1rOODbmJiSxLC5K7GjeIBQVQYG4K
nIZMgD5hIAaKw3d941Do+l3ycy7U1tNq+Tug8/5u/I8LdNHIGbf7As6xkGVNqhqg
OkELxRLz9IcyrwiT5UJV9ErzFpb6rbone555ljBHAyGSMug/Q9FtE2tpR1kV3S8f
8o8SSAxbKMo7sMJmsQSU4bGjZSSIZsoDMpTyui0n0z5pGgryntDz0jUKjRYKaHZy
EE9jhs68TW/pej16lKB8ZGvobAAYjCexFb3/XJYFkuxrTSP8/bzPD7M0XYHENj0/
dEU2w3dd3xcgLaNsKd4mrvCzTepew3uJTWDVtHbYLc1kHJI3UTmXphSJUtuxg2JA
ddrR5h1A6GvSAorYFyTcHnr20n2IcCWTeeFw23GLe98/jCgJLP8C8k27maBCBaOp
SYxq2vPW3aJaRXtPS5sDTbMmbzIrDMtGoSaLs7MRgTIWvWQDGaKlt4Ea4WFe93Ms
+RDnDIZsg/vevGhfYmedSnXyIUWlQEDy5BPKOqmWwocp9t/6vq0=
=sesT
-----END PGP SIGNATURE-----

--nextPart2501163.yGnNtpWTg7--

