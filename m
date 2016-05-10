Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 10 May 2016 16:23:56 +0200
Message-ID: <6446352.pcAao2qlWC@prime>
In-Reply-To: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1812409.W80UtlWQIY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/2] Fragments and QoS
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

--nextPart1812409.W80UtlWQIY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 09 May 2016 20:03:34 Andrew Lunn wrote:
> BATMAN currently does not allow QoS policies to be used with
> fragmented packets. The first patch copies the skb priority from the
> unfragmented packet into the fragments as they are built, so the lower
> layers can then prioritise as appropriated.
> 
> The second patch places the priority into the fragment header, and
> upon reception of a fragment, copies it into the skb priority, so that
> when the fragment is retransmitted, it is correctly prioritised.
> 
> Andrew Lunn (2):
>   batman-adv: Set skb priority in fragments
>   batman-adv: Include frame priority in fragment header

Series looks good to me.

Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>

Thanks,
     Simon
--nextPart1812409.W80UtlWQIY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMe78AAoJEKEr45hCkp6hPGsP/2sT0QvMge6QLttkkveYpQO8
aRvsCESpRxRQFjPifxEITYePymPZ/6QGg8AWZG2uNg76p+0jEyzpiocmReMbQlfx
in1AVJmesYd+0ijjxIsZc7h/tfFWCxT8t3DMqfXwKL8ls9gpIhjAt8SSFHbREBmg
jFumXDg9AfGl32/3mkSAD5i59qmhQx8b5GbxgS6Pzwe9r6fS/jJrKeURH3YECcf1
DzwYmyjnyZuUZuQmMCnLHMMV2Te7z32xf9qfchkxAXr5+4qhE0HDKL7ztd7/+hNv
/+4ibnL0tGAWMf3BvUo/H2aliDoAGMr75V47Mu2ZzEwDgciIfgHcwbwozGlKRiso
xzGAB6dtB9Zf14Wx1xjIxHRgddda57D9h+KEOsGKL0mujxG6mXwxbudLf1T3pzvF
ssqlLkhHkLhMDPs6pmLXhaRA07DmpBqAOUVNS7wrxHb6L+1GCfZ9XU+ah3m5RqYG
6i46RFenPBdDe+M6vnsQkHEAQJnvP8IByiyH77tl9CguLwQRAKoTQYNN03/M4K5a
QRGsm7fh25Bzk/bpiROve119TEUYqsiZwYn+cGVeraOR0LKUhlUKjIYInOtbG6Kq
TR3AsQXCvHgpEUU0xDmbXtM4M9dYywB63pfibLQL/vpzlyyJKJHUbu8ufqncFyNt
KQS748Wm1bdTa8boP+db
=O1ZD
-----END PGP SIGNATURE-----

--nextPart1812409.W80UtlWQIY--

