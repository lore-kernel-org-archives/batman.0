Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 01 Nov 2018 07:15:13 +0100
Message-ID: <2322988.VfWoRf7gTx@sven-edge>
In-Reply-To: <20181029175759.20637-1-jhaws@sdl.usu.edu>
References: <20181029175759.20637-1-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1646792.X6EIWSn92c";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] alfred: Request MAC resolution for
 IPv4 address not in ARP cache
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>, guohuizou2000@sina.com

--nextPart1646792.X6EIWSn92c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 29. Oktober 2018 18:57:59 CET Jonathan Haws wrote:
> When using IPv4, if the remote server is not yet in the ARP cache, the
> MAC resolution will fail and data appear to not be shared via alfred.
> Add a routine (modified from batctl sources) to request MAC resolution
> by simply sending a datagram to the discard port (UDP/9). This adds the
> remote MAC to the ARP cache, resulting in successful MAC resolution.
> 
> Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> ---
>  util.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)


Applied as 5610d5bf8f44 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/alfred.git/commit/5610d5bf8f4447b4d689aede638b4e92ae343340
--nextPart1646792.X6EIWSn92c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvamfEACgkQXYcKB8Em
e0ZhpQ//THes/gEeLAe8mRWKly0D+vkU8j97oArzzVc0nBdsha05dvaXL0u4Q+OG
3U6bCQYY2PxZoSdxplcStLMC00kUMIbGdZw8Fmiz+6x568wkOOi4O62Gt6WquRl4
eJ65cjEn9DTomkrS4B1Jl3msS4p04VZdmgWoy8EWKG+AUNMMfwHTiRcGPOMLMFX+
5MMm+/YskOr09vZr5uQEAhdWxoftSOlIWrN/VC26T48RzHg9+HC5mDjhf8m11OJL
DgS1U1zNmDF1BWcqU7iu8ZZpOxB7H4OeawlVd13brOiPUSyDdLOcUTtFTyr3LGIP
UncIpy0VgiHnHTwEk6wc9bQRp27jPT8SIa2YCo8ZyBvOxIp2q8QuFhF8p8gKVeuh
SM5Qxi14dbpN3zrscy/VH5tVxyqNm63x+AxyPKTv2+Y/TfYhVU0HPoKVoNLoJfKu
csZUVN83RMHUVoj6X8kN/DCXoN9mrBlOREsTrKwnlch0FYWHS09oNPH9ZI0y8niz
KoUh5QToBZpQXKx7yNayNwtbHIakpY1jHOBaD+3+fj7eB6ZpAjoKG9uLCRuPq1la
6JOyWC3SRfzfdRfMQ8r5c8ERmmi+/Mqy6X+4QIhB3VdvuMcPrcPRcMNpy4wT6Y+v
+UBuTO+2b2td0dyrM48ErcoQFub7cnVjBVbC16Dd/7ClkrOp+Xs=
=653F
-----END PGP SIGNATURE-----

--nextPart1646792.X6EIWSn92c--



