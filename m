Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Jun 2017 13:53:01 +0200
Message-ID: <2063591.f2Dj0aj4GU@bentobox>
In-Reply-To: <2394098.zSA1hTeZKT@prime>
References: <20170613103916.27299-1-philipp.psurek@gmail.com>
 <20170613110824.27786-2-philipp.psurek@gmail.com> <2394098.zSA1hTeZKT@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1926834.Stezp6AjhD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
 compiler warning
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

--nextPart1926834.Stezp6AjhD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 13. Juni 2017 13:46:04 CEST Simon Wunderlich wrote:
[...]
> I've adopted your patch, but put the second part of the comment into the 
> following case to avoid the ugliness. I didn't test with gcc 7.1 but hope that 
> should work. Please check here:
> 
> https://git.open-mesh.org/batctl.git/blobdiff/
> 620226bf8cff30e6dd966c8fe922b2d4cddf843b..
> 50ee3c45feeda6d8c04ee127097badf99f78a26e:/tp_meter.c

The other option would have been to change it to:

    /* fall through - print the partial result */

At least the documentation allows non-escape chars after the "fall through" 
marker when a "-" was added between them. I've removed the "and" in this
example because it looked weird.

Kind regards,
	Sven

--nextPart1926834.Stezp6AjhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlk/0h4ACgkQXYcKB8Em
e0YFkw//egkB0SS230Ya018bxn+gBnXMmNS3igQ1tiw2LrluRh8NFElvKu98+96O
wEBkDLssVRUBMwIIVX+WOk7wbY4t3EUQ6NyeJ5MvzgL6bUK338gcrCjmhXSVK4Pi
42/MaYnl4VchfJJOV3VaY3xn/a8G2LdrBZ+RS4QXKf3kZclz/kL/pHsFcgZbLXlo
C7oyDUU6n1Vd1h7AGyo4Rl1MIteMcD+kPSyKXlNDv/nIx2twWjCMh9k4JLM7EHNl
ljCxwXRbsjJdQUvs9KwCp4QjnzjFoKFBh/sELtzH1thuIoMSEZNkKnhjRSMDRZ9v
IXJdRhP4ul4UynWTwa6lMryht6jDtbRYMLTMmeR9H0corqIdWATnFUGWargGKIlr
zi90ToQAgaht2lMGqsM6NTdoSDQaTHjn37NYedK31nSSaFuRAKAxjRYigOSkmDcq
m0+MH4nC5V3WDZxOxBHgPuAbNVJeEJvQXbVv5PlgGPtldp7EFDkSf6/x82B2jxfH
HNyAgdahWTsmnPqpqPax34lO8pgaAwvdN6vWM2B/WUAe0HO5eSfMwX3sKeFavNLX
tXAIL6RosD6Wolh/2WxILqJIAarSh7hHM/RccHefjgWBMBe2QATMPndHe85R3Fg0
1uOphbj1vkiPU/CBxoOneBbiC8BdjDMNn6CRBJ9sy62tmI1Ezyw=
=vWc3
-----END PGP SIGNATURE-----

--nextPart1926834.Stezp6AjhD--

