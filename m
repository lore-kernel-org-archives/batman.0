Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 23 Nov 2013 01:28:20 +0800
Message-ID: <1883196.2CQKWgRpkL@diderot>
In-Reply-To: <1385123427-15460-2-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
 <1385123427-15460-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14897757.sJ10aV0bsX";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: silence uninitialized
	variable warning
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart14897757.sJ10aV0bsX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 13:30:25 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> sparse (at least the version of the build checker) is complaining about:
> 
> routing.c: In function 'batadv_find_router':
> routing.c:431:28: warning: 'next_candidate_router' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> 
> Although this is bogus, silencing is not expensive and is done by this
> patch.
> 
> Introduced by 797edd9e87ac838711e03498a4ae795b600191af
> ("batman-adv: add bonding again")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  routing.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision aed390d.

Thanks,
Marek

--nextPart14897757.sJ10aV0bsX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSj5Q0AAoJEFNVTo/uthzAEd8IAIhiJcZ7VQpsk5lMVOt0TYfO
uiz0XknKg93K3LkrRQxUp074UYe8Txwxgr06yS1irWqPTbb67ACvc8hSbuoJ5PZ0
6qRxlyHBuGLeZBQ/XTvwQkdWwBJeDCFaRZzYi7WfC7yNjAAEfHzyZ9X/YxZcGFtI
fJ4/BJBJy4lwZeeY+iQ2h5dxK8GxukUBT+aHuGXfto6cGR1EnM1NxGDjAda2o92p
HlDyLHqbZalybYyXYOhjB/fI8YEfoITVySgMcca8LDbKvOR2G5AnHmQo4ai6chsS
9KaPSr0Kkm5x0Wc+wL2iRyPWu5qO32tyRYLcQA+WqUo1flztjII39iin0zyOqzA=
=EjF5
-----END PGP SIGNATURE-----

--nextPart14897757.sJ10aV0bsX--

