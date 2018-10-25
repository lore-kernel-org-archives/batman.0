Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 08:15:07 +0200
Message-ID: <1897809.X9xPm7IOO6@bentobox>
In-Reply-To: <100c018ff42541ddb2615fae42bc64f62ced80b4.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <19500073.zgPyDjR2lk@bentobox>
 <100c018ff42541ddb2615fae42bc64f62ced80b4.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545029.ofro60iFSz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "guohuizou2000@sina.com" <guohuizou2000@sina.com>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1545029.ofro60iFSz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Oktober 2018 18:39:43 CEST Jonathan Haws wrote:
[...]
> I just submitted a patch that pulls the request_mac_resolve() routine
> from batctl, modifies it appropriately, and uses it when MAC resolution
> isn't from the cache.
> 
> I've tested this with my VM setup here and it works properly (after I
> verified that the nodes were not sharing messages first).
> 
> Gary - can you try the patch with your setup and make sure it solves
> the problem in your setup as well?


The patch can be found at https://patchwork.open-mesh.org/patch/17552/ (or 
directly on the mailing list)

Please reply via mail with a line

Tested-by: FirstName LastName <guohuizou2000@sina.com>

when you've successfully tested it (FirstName and LastName have to be replaced 
with your actual name).

Kind regards,
	Sven
--nextPart1545029.ofro60iFSz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvRX2sACgkQXYcKB8Em
e0ZPTBAAwXCYMGddkDUeyJQ4oTrcQq6drT5P78LF+TyJ+3v0FvOgt9t/zFkZzIDu
7ms9eIju0T91MU9wf0h3zpo55Wbvytr0NrnbxhqRaMIQ/5tNG2vse8llmE62rMmX
GTkVSNnV7uz/mASycBUEHfxNXJ15Sbjp3CSwy74f6u+/ggJU3Ys8Hfo0tCChl6BX
ZezuLv2WYyNxvT0qGnjR4fcOcnnsaxgmWW/YlSWb/gHxN65Lac/mJtxn1JKpa4J2
UguSQ2bYMpV2ArRJnSP6ZclqH+oLKd6B4Ge7oTPwOnsFD0sdpDmsO2IA02mjWTYG
9Xt48NOaqTzJs2ZNtHr5CfhWjHX1/7ImtGIeArTcrnqggVQ06aIVRH73IdQYByZ1
zkRAaJzUreG1Kz8yArDVBlyb7zqfsAlz9kt2HJltQwWxhcPBOKc6ozk+U818F1l8
Q9Bnn+X8d6yePzsZ5V8Q9znQaGlxrtyBIH4+ke6fVj+g8WtuKUqEuRatN0PM+eUt
o6l6OX2M1E6bcYeTpnhyX7Rb4G0lx26ApPO8uGEh0aV2b5FsmTWcAEpUBtyfB+15
gE5+b2W2TmsUvlfzDQ814VybgHhyx+jtlTJQxMuNSMQmfRyk+ksAEuG+G+rDjzvF
DSZjtA8RgkCZ0RAhR3SgZypaBVKXan3fCOIOkYi3xPPZLG+IKak=
=TjoH
-----END PGP SIGNATURE-----

--nextPart1545029.ofro60iFSz--

