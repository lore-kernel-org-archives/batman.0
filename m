Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 26 Nov 2013 01:48:59 +0800
Message-ID: <8299583.p9F3l6Gztg@diderot>
In-Reply-To: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
References: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3668848.9S5gFcGq9W";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix another sparse
	warning in batadv_iv_ogm_emit
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


--nextPart3668848.9S5gFcGq9W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 24 November 2013 14:05:43 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Since the directlink variable was not needed anymore and was removed,
> more variables are now obsolete too, so remove them.
> 
> The directlink flag commit (which was obviously incomplete) was
> a0fc2f129f7193cbdd7e9c2e4da0d6e7ac15dd58 ("batman-adv: fix sparse warning
> in batadv_iv_ogm_emit"), which itself was a fix for
> 29b9256e6631876d4f1719f4d5e13d7ee140c61b ("batman-adv: consider outgoing
> interface in OGM sending").
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  bat_iv_ogm.c |    5 -----
>  1 file changed, 5 deletions(-)

Applied in revision 20978ca.

Thanks,
Marek

--nextPart3668848.9S5gFcGq9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSk42OAAoJEFNVTo/uthzArwQH/jd5MbMFF7RGARx+qwgI9lPT
phl2o5Iqrw0ppcdlxDNI+I0MSWcPYLVwAZsIxweyzASCj749cY1utj4ffauTTv40
HAMjVe1ml6avpt3AIO5KMZrDC6OGT74f2nCH9Hq0AnIvEHr2F2NwWi47M/Q9KJK/
6XTO8h7aTy8Hqc8KW9DUzzQ/vHYeRgHL01eM6Tr5fORVzxRwWhssHYW5hfojrGyi
8GTGPv4etj/ARAbPTkbRHpUMdygya05+oeCfPdjhiPhKNFNmVgaiaPWRYUfufvbc
o6vF3ILKmEqtii5Pyh0lnxJQyZDWRqAVvNeU4ZCBena6OV0/MO+9AYwLTNBJmHU=
=5m9H
-----END PGP SIGNATURE-----

--nextPart3668848.9S5gFcGq9W--

