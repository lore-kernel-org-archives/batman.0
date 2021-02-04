Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
Date: Thu, 04 Feb 2021 08:41:24 +0100
Message-ID: <2833533.ujcMDckppk@ripper>
In-Reply-To: <20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210202174037.7081-1-sw@simonwunderlich.de> <20210202174037.7081-2-sw@simonwunderlich.de> <20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3413650.uM9juBY1BO"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>

 
--nextPart3413650.uM9juBY1BO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
Date: Thu, 04 Feb 2021 08:41:24 +0100
Message-ID: <2833533.ujcMDckppk@ripper>
In-Reply-To: <20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210202174037.7081-1-sw@simonwunderlich.de> <20210202174037.7081-2-sw@simonwunderlich.de> <20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>

On Thursday, 4 February 2021 01:33:02 CET Jakub Kicinski wrote:
[...]
> For just comment adjustments and the sizeof() change?

The process is basically:

1. update the version information for a development period
2. queue up whatever comes in during that time
3. send it to netdev for net-next when it seems to be ready

The first step is not influenced by the 2.+3. step. So the development 
effort is not reflected in the version number.

Kind regards,
	Sven
--nextPart3413650.uM9juBY1BO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAbpSQACgkQXYcKB8Em
e0aJQA/6A1TAaQ5N2HfD9Y0+CLbPpq7IREDN0a7qQiX8AIbFkaC9MQa8szAY/BEt
y0n4g7umhcBs+RT78lgqocXQc7HWDjeVwM5EFqR3FaAH6fWpDOtOTSsiNIP66QIe
97JeoZaZrchTIC5we6gG2NTlQqzj2Al0AzWpFq9UR+UPKHhrT7CHr7lZ8Qx1tZPU
fkVIPDr2cdK0Z5WoPf+cVo6EsBdPHNqBtU3pNnJ/BwWJgHGM2ABQMMfLWJMmVtvs
koiulH8k3dfrcHDxbaIzma2pwyB3JqZ8OKqPq4cpQ8b1QIvzLndrXVICBKv2wXfK
RVUZwfO4cLT1RuC1FnXUWJRpIcyrirmCxvUXz27SeMOD8SyMke2l3PhaU9Nz6G7P
pSPcZmLTofjVDByZ2NzZrMzneKCEj4z5kW1TvSXqzTBwsVyiWnW96SayE2txGaVE
pLwcCK4larojhyg6zAF1WoeOVPz8zZd9IRXrfQ/0tVD2UzZKJv5x//y5cVV0PvDM
ydPwlq2hJo6rrXG7L0ES5l0oaGEumf0aOLnkguxCNki3p04wuifGWtGq35pTh30c
Moe/4DslMD+H5s0y14UFDP+Kelda2TvMRB7attN2QhoOkPbi+q2Qh4scqOqlL3vr
N3PCY67t5DccynMz9YevRYt6KsFpkksu0r9ONrRgRhCvPJGyv/8=
=4QMF
-----END PGP SIGNATURE-----

--nextPart3413650.uM9juBY1BO--


