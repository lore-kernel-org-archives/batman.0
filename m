Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 23 Nov 2013 01:29:26 +0800
Message-ID: <4796641.YPunqkdCHu@diderot>
In-Reply-To: <1385123427-15460-3-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
 <1385123427-15460-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5500357.rUKoP9R5KM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: fix sparse warning in
	batadv_iv_ogm_emit
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


--nextPart5500357.rUKoP9R5KM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 13:30:26 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The directlink variable is not needed anymore, and sparse complains
> about that. Remove it.
> 
> Removal was introduced in 29b9256e6631876d4f1719f4d5e13d7ee140c61b
> ("batman-adv: consider outgoing interface in OGM sending")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  bat_iv_ogm.c |    2 --
>  1 file changed, 2 deletions(-)

Applied in revision a0fc2f1.

Thanks,
Marek

--nextPart5500357.rUKoP9R5KM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSj5R2AAoJEFNVTo/uthzAR+EH/2WouzrQko3nFDyEYWKzQWFy
S7woKXhHObUO/liySVOsiIgo9Yg70oGAj97TNSLNjDnPyh13p1DdL50qiNQdjYTr
t8j9QLQWbCnuDQ1QMPhOxlJ0MsbyuKLLyqRZdtW/VTMkn1wWmRmkGSkIP84UmWXJ
Myqu1EG4Fr06yMMn2dsWDy5FGNXWz6JYXfgicE+wJAJv9xz0kXp8EpZM9ess9fea
MmXjJGGH3gdoE10HseieUa9SernMJqUMpzo0R2nvsFgPgXCETql/buXtQWseJ6nU
GU0URQZH3O6ADzFsWpvR7LHBUCT0ho2jpGEY+K5x6Da0f6H1yvnBC0d/mJJnyFA=
=9eoG
-----END PGP SIGNATURE-----

--nextPart5500357.rUKoP9R5KM--

