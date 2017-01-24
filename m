Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 Jan 2017 12:44:38 +0100
Message-ID: <4448368.uV4yijacOc@prime>
In-Reply-To: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4048512.lWkgNfKFCe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
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

--nextPart4048512.lWkgNfKFCe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, January 19, 2017 9:01:04 PM CET Jonathan Haws wrote:
> Enabled via -4 expert option where multicast group address is specified.
> This option will disable IPv6 communication and is intended for use in
> networks which do not support IPv6 addressing.
> 
> When this option is enabled, all IPv6 communication is disabled. Combining
> IPv4 and IPv6 alfred nodes is unsupported.
> 
> Hardware address handling done by submitting queries to the local ARP
> cache rather than forcing an ARP request.

Thanks Jonathan for your patch! I've just looked through the patch and 
discussed the matter with Sven yesterday. We are both not too big fans of 
supporting IPv4, but since it helps your scenario and you supplied a well 
written patch which properly abstracts the address mode and has separate IPv4/
IPv6 functions, I think we can adopt it.

Just two general questions/remarks:

 * I do not want to give support for IPv4-related questions of users. Would 
you be available to maintain and answer questions regarding the IPv4 support?
 * Do you plan to provide OpenWRT support as well? (This is more out of 
curiosity)

Thank you,
     Simon
--nextPart4048512.lWkgNfKFCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliHPiYACgkQoSvjmEKS
nqHHQRAAndzS7VBjs+8yHZx6w9ZiTRPxYty5HpRALXf/DraNGyd3Ic6VS2mXiS18
nOdcxTOJP/lapfEs3h0DFPpLqmCebakvGsBxAUS8oNqdAFo9omy3wJONdWPgwNHc
DHerEE8Ufemdzp6BB4KS/fVVxe6MZeEC9grZMIjKauBAjj/9MLH3lOBAPvBBrOxX
TUUCskhMxmCicXyI7oG+/n9a3YGz8ZXg2BibfnTPF0w6mZLYmqPSgM9+dAeGlzoD
l1cQXRN2kBuzh89PY15v9pkZNZCWREUP2sezCRRncSPKVcXZw+k0Jt3zZKjYd+Mf
KgaiT6NMJzh0hdHRpjelleypz9ivrx+cUqOSEVk0cB5WmR5ZVbxFs0F856xZKNfK
nlkEJailQg+jx4rplE0iFdhUB5fzuiTyIuZF/0wXbfnhXHq1c/xij8cF4E0KGdiF
NuDom3yvyORWJ47mqfydEJiwBTJB1co5P4rVeTE+dbs90w+2UwXn82gd2NLgt9yH
/bf09mK7bx/45RgT2Wgptu+jYWZG/QZq81W1f4X2QXgiT6hjeqCTwjbHK1ebloMK
dfsZL847xHiJ6pzmSJeUOwfZTlKvSHprY/8MQ1RY0HpWgz6mIrUmSKl4ahhtKoG+
ypiej0ecw/k8JVcys8VC7GcTye6me1fzoZOnSKHMqDwn8DDzeWM=
=7bRY
-----END PGP SIGNATURE-----

--nextPart4048512.lWkgNfKFCe--

