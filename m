Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 Jan 2017 08:49:36 +0100
Message-ID: <4353909.3ARBFDpkjy@bentobox>
In-Reply-To: <1484804915-14791-1-git-send-email-jhaws@sdl.usu.edu>
References: <1484804915-14791-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2170510.Jgd1RvMRHq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] [alfred] IPv4 multicast distribution
	support.
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

--nextPart2170510.Jgd1RvMRHq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 18. Januar 2017 22:48:35 CET Jonathan Haws wrote:
> Enabled via -4 expert option where multicast group address is specified.
> This option will disable IPv6 communication and is intended for use in
> networks which do not support IPv6 addressing.
> 
> When this option is enabled, all IPv6 communication is disabled. Combining
> IPv4 and IPv6 alfred nodes is unsupported.
> 
> Hardware address handling done by submitting queries to the local ARP
> cache rather than forcing an ARP request.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> ---

I haven't looked at the patch. But please use "alfred: " And not "[alfred]" [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/alfred.git/shortlog


--nextPart2170510.Jgd1RvMRHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliAb5AACgkQXYcKB8Em
e0YjlBAAnNDTrS9RVzPtN7yp211FMkbdgrDVFRS5qL7hQ97UKyvxfKo2kX/EF7hx
84+EHLlSv3NELt5OpbRD5BC2nHT+osd1ioCKzUGpqBDtJKFDpwvzRxWsFABtYSSM
TW1Z6Fd5uOmU4TCfPwgYA1y0X4Mx14G6cdcT9ZQ2njARpkDxxUln2AVCJj7/Rhs4
p1nx42lKfuFxZ1l8rPffHn1BN930evAHA4xGsLNJnbMyuqbIRhPndM1sj501dvNy
a6rIBDY0FzniolM8GBSGeEvTR/9O+2QWUopseYNgYCXZpCKv7YP+OyGkFLqVvb6g
jp5Kl/T9g3Eh+z2Fo/7ULg+p9E6xbiWHRDdSHfR8ba4/rQsEVUolQI9KUG+jrCXb
q31mQb95K4TCd+KZvD7l1aSr5G0V46H8igaH9PREeiaTyt/726DcZvQVfMdbimpR
NA9FrtmikQGQjf2UrgbjmDAnrg+djD/bSMQYs/QP0aMFwDghnhq/AWSCjTfEr4/4
8VDuO7H6ZuOrykdR35JEg1759Fjj6OgctbjYSKQqC5z3FjZXVnYEWh1yj24xLgFb
pXXfOF6o5PGeH+aXDJicIFpubLmKph/3p070QO71Cw85sDfKVtheyg0jOCMNAfrM
tyXXoMQjfEa4ZZHy14x6cbbfmorQg/GAVkQfUUdifnYGeie6Qi8=
=dDLJ
-----END PGP SIGNATURE-----

--nextPart2170510.Jgd1RvMRHq--

