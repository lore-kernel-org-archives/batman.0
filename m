Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 19:44:40 +0100
Message-ID: <2657763.4IxibMMjmR@bentobox>
In-Reply-To: <1408455756-10794-1-git-send-email-sw@simonwunderlich.de>
References: <1408455756-10794-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2633800.k2vF4xURvR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add detection for complex
	bridge loops
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <simon.wunderlich@open-mesh.com>

--nextPart2633800.k2vF4xURvR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 August 2014 15:42:36 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> There are network setups where the current bridge loop avoidance can't
> detect bridge loops. The minimal setup affected would consist of two
> LANs and two separate meshes, connected in a ring like that:
> 
>    A...(mesh1)...B
>    |             |
>  (LAN1)        (LAN2)
>    |             |
>    C...(mesh2)...D
> 
> Since both the meshes and backbones are separate, the bridge loop
> avoidance has not enough information to detect and avoid the loop
> in this case. Even if these scenarios can't be fixed easily,
> these kind of loops can be detected.
> 
> This patch implements a periodic check (running every 60 seconds for
> now) which sends a broadcast frame with a random MAC address on
> each backbone VLAN. If a broadcast frame with the same MAC address
> is received shortly after on the mesh, we know that there must be a
> loop and report that incident as well as throw an uevent to let others
> handle that problem.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---

It looks like this patch doesn't apply anymore. Can you please resent it or
mark it correctly in patchwork [1].

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/4154/

--nextPart2633800.k2vF4xURvR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4cCYAAoJEF2HCgfBJntGWZQP/1HzikJJubSA1jkNU7EFRFrG
GEeUvraarxqmt7C1n97C41BW/3fgIBWaltNDw4RkZL9npgbYrSUAzMVulDCCh51L
fc27cEM/EjLGUA6RfH41jF1dHS6QDfPuwWupjwmi4iI2QAdRdH34rvlo3YGNIZj7
YCpZH1ILXgS9zAj+Z5dnQRRVJfzi97tVvPBW+Sl4/cxUdBFeqSEut0kE/AwFry1y
IZCqtt8/S1utkhV8VbfQYxPrHAwjb9VYnXIFjd1uYw1FOSRe5WWgs8l5DnZ1LPRt
S9yCEesDc68U+B+wwktFEBvFdCm9gR2M+0paIE/w3bwhM2MIH5XrtmZxWGe0uSTE
A14HAj7BIxih8wdJ1mwPLozdOrRpR+fpNtCz2lqEWmYfDDxnRsLjPM4HSohqv0cJ
LUIBgs+dWL7uyotJdtXAycuX3Jpv4J0Zd/Wr5sxD/UowaOzuzqBNWxfxDndJoZQZ
dc1+MzQfEv+6KS+G3APZ4ggk4NPybpnEL+RQm9A8DKMHhpo091aD8T4MTdX2e5+J
IoGVngs8S2DZsCfz2OXxKmM+HOcXGorm73JxULHwpk96ZcpZ+FOlCopyYGMyLtTr
nohU6rhcS3e9ZQjCmUPM3UeEjZeWd+Mvwv+ruisO5aZIBX0/XA6Nx6VRnLV50kWK
yMDHyqeZM5uycgwQHf1h
=7SOp
-----END PGP SIGNATURE-----

--nextPart2633800.k2vF4xURvR--

