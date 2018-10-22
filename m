Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 18:42:25 +0200
Message-ID: <4210821.HbKLZVPWWj@bentobox>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4545993.vJxjh6QdZB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/38] batctl: pre-netlink restructuring,
 part 1
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

--nextPart4545993.vJxjh6QdZB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Oktober 2018 00:54:46 CEST Sven Eckelmann wrote:
[...]
> So as first steps:
> 
> * restructure command registration
> * move commands in separate files (which should store their actual implementation)
> * add a new helper command to receive multicast group messages from the kernel
> 
> More things will follow in the future.

There are now some minor fixes for the posted patches in my git development 
branch [1]. I will not resend the modified patches directly because there a 
quite some patches in this series. The important changes:

* correctly split ap_isolation and bonding patch
* fix copyright headers for new files
* move more routing_algo specific code to its command specific file
* fix build problems with musl in OpenWrt 18.06

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/shortlog/refs/heads/ecsv/restructure
--nextPart4545993.vJxjh6QdZB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvN/fEACgkQXYcKB8Em
e0YRbg//fPFXfSNapuVBCVl+5e7kfDw/XBek4aCgkmltC63N4MEObu/NvaRMlxiq
uNyNp4bmnMoD+msCBmyLp/FdOqmSqgRKnsWbDhuGDnm0TqMDau3m3lzALrMJHRQ5
WR8Q+nUE2/Nm9NzlLuBYpJ/NMTrenMKf01SFJ7oAsaUseLj964omPL2yVEOvC3rN
vCcExfh6XV3fAPJp7yzVqzqjAov/yqy5cPoDxs4uBrsz+LClPk65rI8MolRKjumX
RtwrGf7PE26Mum/TXH4wOoryO86mG/R5OSI4U+ZKbhiZD8GtXrlMxCLhTiGqEC7y
cM4HmMH6lnR6MbpI+KlKvSjIxgBHrp8ZjYkinzq1ogi/2zcvE8QkZ3ayD3wDXN7P
kButSp6p7XQpHV0lrda4iBx+2npreFXqVOPTGCqdHaXkBxUiAzzx8VcmXa7+EBgh
GysGuUpeF1zrBWwxuqRaF58UtgXBSIdsHMmSEZUeJu758qU3LF2MwRbvQ4Me4Y1P
RvZax1jKCmPLdH7zwQycNT29IhlFF0vXnOWnnUQbWGKtk3NaSHcznk0MYjiLSvtq
iOpbLF4lV8mxit2qwjZAe66k7U5XzJVkuafgiXRfN+H6J7rqF14v3trmrY/pB6Q1
eld4y9wCRYVSmiosQWIL5Rph2NMmQCBP51fNDCmYyCJrGQoidYs=
=g6Vg
-----END PGP SIGNATURE-----

--nextPart4545993.vJxjh6QdZB--

