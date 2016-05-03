Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 May 2016 20:17:49 +0200
Message-ID: <2980530.WMHeG6Nn99@sven-edge>
In-Reply-To: <1462293026-24716-1-git-send-email-andrew@lunn.ch>
References: <1462293026-24716-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1469023.NZ9hX47XBf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: Use netlink to replace some of
	debugfs
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

--nextPart1469023.NZ9hX47XBf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 May 2016 18:30:26 Andrew Lunn wrote:
[...]
> ---
>  Makefile     |   13 +-
>  batman_adv.h |  111 +++++++
>  debug.c      |   19 +-
>  debug.h      |    4 +-
>  functions.c  |   11 +
>  functions.h  |    2 +
>  main.h       |    1 +
>  netlink.c    | 1024
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 8 files changed,
> 1181 insertions(+), 4 deletions(-)
>  create mode 100644 batman_adv.h
>  create mode 100644 netlink.c

Could you please go through the messages from today and check what wasn't 
addressed. I've already spotted that netlink.h is still missing. There might 
be more.

Kind regards,
	Sven
--nextPart1469023.NZ9hX47XBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKOtNAAoJEF2HCgfBJntGIKgQAMCY8xl0jEfztBTsABdLBs/0
+r4uvev3d6sp0dM51MeHvoeHVNqEtIYT3TlAomIGJ7P7/S9AaM30zodlH4bUvHxR
dawKeuNkECl6vrndg/zqEvo9CFvYrQtHXhdspL2iqDzxjJCAgAdstDdA/Q3F5z0K
+vDsvJm+0nZJ8c0mnEVoAG7g1fbDIJx41LZ3frgWz8INJRO0AdGrnxbCTXR+NYgs
bCSZJ//R4UeuUZpBMMCYB08j8UNW1C4hHLRhTS2pVlShoHvErr4pZab+3ump770q
9A1Se1vL7z/qmVlgicZJW67T3GslAk0bhO+EtsRYzj4Zft0dZKo6hUy0QFtzQWRG
cU4UU6AiUbqFWX7xp3lrbeXkxrZjv3dl8a2ozlrIhPsGIAoPPpwQ9FcKaCbS1DoU
CW3xtAD1xBzLWkhbVbdim4ZH3HMUL3VYYFhlkHITwwjJNjzO0F3fXD7GiYdopWkr
1lyNskOQ5tqsH4px2hvL1pAT9xFhi4lXn1k3fsoufZkrElzJLDdEqV3YGDQNyLXh
pbeCJGkigE+1y+cSxoiFVpH8IVY+GzCmEAVJ2/SrYcUuPMQMxryD6J6obznA8S7I
yV9lZusB4b3gcLfx2kSPXMh0OI+0w2eVFK8/atqGgNFTCgoiNIrjhKMCluByMzlD
lVWN8Xk4BxsGFEecra9D
=HAt3
-----END PGP SIGNATURE-----

--nextPart1469023.NZ9hX47XBf--

