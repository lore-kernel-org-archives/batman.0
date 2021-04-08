Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Batman-adv On Raspberry Pi Zero
Date: Thu, 08 Apr 2021 16:00:25 +0200
Message-ID: <2330760.6cGzkY6KVC@ripper>
In-Reply-To: <20210408134330.1234.53011@diktynna.open-mesh.org>
References: <20210408134330.1234.53011@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24306713.peh82CmNTL"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: giuseppedv@gmail.com

 
--nextPart24306713.peh82CmNTL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: giuseppedv@gmail.com
Subject: Re: Batman-adv On Raspberry Pi Zero
Date: Thu, 08 Apr 2021 16:00:25 +0200
Message-ID: <2330760.6cGzkY6KVC@ripper>
In-Reply-To: <20210408134330.1234.53011@diktynna.open-mesh.org>
References: <20210408134330.1234.53011@diktynna.open-mesh.org>

On Thursday, 8 April 2021 15:43:30 CEST giuseppedv@gmail.com wrote:
>     batctl if
>     wlan0: <error reading status>
>
> Anyone experienced the same issues?

Make sure you've updated batctl to the most recent version. For example from 
Debian backports. Otherwise batctl might try to read the status information 
from sysfs - which is no longer supported by the newest batman-adv releases.

Kind regards,
	Sven
--nextPart24306713.peh82CmNTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmBvDHkACgkQXYcKB8Em
e0aEoA/+P0mX69VFGIG4Vnnid0+4x7c3mrJzyuB7WcbG5OyyRQxyCQua9K2Z45Dz
ZQLkT8B7xOMSc2rpohxFFOBt56IhZl+Yh2r2hOL8cEUfKST0knOzO4r4YEuweqG2
SAzLFqt9PiX/FGWT35evhicatgaaLwX0XXUrNfWFNfl/h9tVCjB3BwFIczl2GVPH
icJ+4e06OCjFmsttZwgx8tiUGwL1xACUTivfPPOfRE2+0cIQDerNNX38vK04QEPp
XGU5xcEx/6Wi1QMiWLj5bka3xbJLovhom2DZiqTtz7g0zH5OOgpg04FzYvvu8PsE
bQCxQ1r2Pt3Kk+I2licBE/iveV3BZW5rZvTWsGlTnqNlEJQ8b3rgzG6kxTYCEvOy
LGGPzb/fBdSFFaUBsvChgPDx4o0V1BWe9/AI8ru+xXUShNCnI2tG/u9wfhZxgfK9
laLnSQm+JA+MHoeq1XAw4aa2uABcjcsPYYQEeS1xnNwYZUmhLdqv7NGAIlv9GzRn
VjgRxq3xrrpKhhYeQlpnX1g3NII1RGl7smmX4BnnhaU5HXV6Lnk1drcxVvxJwOsp
k6/9S4GeeFHZOk3s+sn4oFTv05jlOj2z3E2wiRAcHUWD/v2ziWsR0kmCd3U5wdzK
l1xyivrPmTeK7TXRh/Myt1ubtzGQJi7arB29waGBnsrMK3ThUUs=
=4vzJ
-----END PGP SIGNATURE-----

--nextPart24306713.peh82CmNTL--


