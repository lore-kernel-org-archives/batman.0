Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 01 Dec 2017 12:31:22 +0100
Message-ID: <3026754.xcniUJ4oqX@bentobox>
In-Reply-To: <20171129092502.10474-1-sven.eckelmann@openmesh.com>
References: <20171129092502.10474-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2085319.RAPMeIBsJY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Always initialize fragment
 header priority
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

--nextPart2085319.RAPMeIBsJY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 29. November 2017 10:25:02 CET Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> The batman-adv unuicast fragment header contains 3 bits for the priority of
> the packet. These bits will be initialized when the skb->priority contains
> a value between 256 and 263. But otherwise, the uninitialized bits from the
> stack will be used.
> 
> Fixes: 4f241fcea704 ("batman-adv: Include frame priority in fragment header")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Cc: Andrew Lunn <andrew@lunn.ch>

Applied in e45a75c82fea [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/e45a75c82feae23a20d2744ccfde03780ccdafc7
--nextPart2085319.RAPMeIBsJY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlohPYoACgkQXYcKB8Em
e0Z7+BAAsNtE7oWt46xgyFhlsOWPOlkefaz8kCE//jr9AFM6O/DCS2xZfBVegnf0
zA0SpiFQbvf5SgOgy5z3vxaQC6ZSPMoARyWgeoyNy3c5HEIQIThs3XYYEiOsGnGR
XBxXfrQzJJiBk9U311hMCVzOmfMVEIsM20to0SOle9XVqEv6u6bvKJz15u4vIk+u
ncKIaMq+1f/7Btm3DG14akk63BiDHJvjavc6xfLP9ylWyu/wju0Ekzq+YyXIJiLr
/b4pmzrjh08zGVxBgruUUZYQ+dKvYNUSZbBbovOM9T4V8esx0dXzzrNbxRunpW8/
1B5UtxPFBVHCXEDNZtu4tNvwGKHUun50rhcUrsajp17otUTu72HAxbJ0MwhBy+1k
lcNiPklrFElJ1o5u7bc7wSIuTv6VgGXZ6QiIuO82Xfp4ZLz7YgcPnQaInod0vfKm
bPgqy3ORZAIelFRbFnGMaWA7Oha3eEMRjpLmGhBQbN0jOgueLqGpv7nY9nFq0tRh
pR6l/M9AKG2dZOGbBnovLk72EJSDtbdNW6xqGhGtwvBl6Nk4IlNPgbhslHuI7SMR
nrKVpa0Pw0l8Grht+8U8XEmD9ct7giD4uXbPwKjSJY3M1SfMQx5YtaF1LBYnc/Mq
1teVh2LRkn6oQmVGjlWAKLiaPyYz+8IMp2JqlyLTFG6psd9mSNE=
=gTYM
-----END PGP SIGNATURE-----

--nextPart2085319.RAPMeIBsJY--

