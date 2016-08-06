Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 18:38:35 +0200
Message-ID: <2339296.p0oRt0exUO@sven-edge>
In-Reply-To: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
References: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2484933.RfxcQpcQyo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Externalized synchronization
	interval
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

--nextPart2484933.RfxcQpcQyo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 28. Juli 2016 14:43:16 CEST Jonathan Haws wrote:
[...]
> +			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
[...]
> -			printf("announce master ...\n");
> +			printf("[%ld.%09ld] announce master ...\n", last_check.tv_sec, last_check.tv_nsec);
[...]

Are these two things just relicts from your testing code?

Kind regards,
	Sven
--nextPart2484933.RfxcQpcQyo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXphKLAAoJEF2HCgfBJntGViMP/1d4uvr/PE1sJeaWHpcUFFhJ
i6CVZB7gf49pKN8OsLrcO2JM2rRlRfcDOQqlGQ7X82C2kk5y61o1JuLh9VKvZwyG
WS65iNAXOWbUJTrylWku13ibPK7zhIibcQJwzjE2sEfnM3JZQvZ2epnCG0NW1hVE
2a+hWxalug0bd/m3r7BQBSUveeg7rD8oNW+rFICdAwHjilo2lAFfBTpxRHteQAbk
/PSpQ+gqGeSQ1n3OR9ro4NZ0v6YFbJ8BSDIb1fIIc1aDgFoT8B/3Rs4A1aLXDXX2
jxqFl/+fWOZ80Ov8a9suetdzjYvEb+dbK3YHz6fDNd31hkNCFUPI3iTJHOa2YiCE
5H2KsdljESn88/MKS64xih/F46T1xm6Gw5bqmx7v/oqVr9TyOm+Kf+Excbql/AdN
YHO7ewhb7ObwAP6d2Kni179qbKRp+4e8RnymGcfDf7X6aQ9v9a5jhVDWOiruN9rG
I3qUsmUromLiRqgfDkUG9iGCGGU3vEYJFjdP0XPFRU8etozdB+nfbOQjKcS0NtSU
YJ6I5tTtk6A5DT+M36Fwxctq+WWS4X2p0A+Xqq3zZtjKp01i6qUf6iNgkDPHe1py
y2N1YbRKraf8CDx4M1ZExwGsQEyVvXzvJpOSFdNT5be/Nw+53FkD4rjyNG6HtsiB
3s4FxOCYRoi93IKNPCkP
=jXDc
-----END PGP SIGNATURE-----

--nextPart2484933.RfxcQpcQyo--

