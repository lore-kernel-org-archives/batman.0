Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Aug 2014 12:52:52 +0800
Message-ID: <1815637.PGfB9BjSzh@diderot>
In-Reply-To: <1407335643-2124-1-git-send-email-sw@simonwunderlich.de>
References: <1407335643-2124-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2137714.YuepJK3R4x";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: fix backbone address in tcpdump
	for bla request frames
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


--nextPart2137714.YuepJK3R4x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 August 2014 16:34:03 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> hw_src just contains another copy of the destination. The backbone
> sending the request is setting its mac address into Ethernet source, so
> print that instead.
> 
> For reference, see the documentation:
> http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-Prot
> ocol
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  tcpdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision b904124.

Thanks,
Marek

--nextPart2137714.YuepJK3R4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJT6EwnAAoJEFNVTo/uthzANJYH/jq+OIPWNzvg5LAoB6JhDXoZ
eD5CPKdeUAqBs8F/pTta6r9x1cA7rM1h8oQBW/Hwzl2fnlq/Dj4NP7XPfTZ307C6
wlhlCwUpaKXX87c+0xkFiGNLkMvgqcTWUHttWSJGWgcoroVhtHBXdhLHGYzezY0F
BQtSCP5U+L+GjE6W1NmNDKw9SGVDQYzgExXla1QM/HjBTUfNirRnTgxBbTfRKKHL
8WypJl7M3cqGnc7blXqnBCxytAipXJFfKSb2bQsWE07qTt/hX9isSHihFYf/ul9v
G1NjmowVe5WLoAr7eYGuwHnx0DhPJsL6Ua1G6ZsgcXEniKyQHlAHZiOKxu0Fe2o=
=JQr0
-----END PGP SIGNATURE-----

--nextPart2137714.YuepJK3R4x--

