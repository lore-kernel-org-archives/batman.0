Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 29 Jan 2014 12:44:18 +0800
Message-ID: <1433642.KAeoiFfFlZ@diderot>
In-Reply-To: <1390821808-3855-1-git-send-email-antonio@meshcoding.com>
References: <1390821808-3855-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6269706.plkOqZiHmp";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT-TVLV parsing on
	OGM reception
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart6269706.plkOqZiHmp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 January 2014 12:23:28 Antonio Quartulli wrote:
> When accessing a TT-TVLV container in the OGM RX path
> the variable pointing to the list of changes to apply is
> altered by mistake.
> 
> This makes the TT component read data at the wrong position
> in the OGM packet buffer.
> 
> Fix it by removing the bogus pointer alteration.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  translation-table.c | 1 -
>  1 file changed, 1 deletion(-)

Applied in revision db13d36.

Thanks,
Marek

--nextPart6269706.plkOqZiHmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS6IcjAAoJEFNVTo/uthzAjOkH/iuVKdO/7PewuVvHeaLJ680a
UhNYgySxx3j5rtw8F0VrQWVnD4Gk3LG7PewVa0QFGF7e3AmjtX1YF+mJ/pXGpUBn
v/VYbotLSilKIt488Dy/BA/rM9yEXbe89K0gUoTb7ZyK6Yw+RSiVY507f8II8INa
KwdyfpJn7Mkpi+Ij/dpDd7ssv6PWjUk/zZhoBUtNDsnITSTztizoiYKjb6fPCavx
JyJyOv+vGL8ydcuF44w+Gla14/3KIIny1mtJeFE1Ie3onFtRh0BNJSskX/V4gyiY
Qp9j71LC5XS/JmcO46oBSeD10ThzA7+Sr9jyYvzQFUrQdyFGnpHgA/gWvhA/a4w=
=bKiV
-----END PGP SIGNATURE-----

--nextPart6269706.plkOqZiHmp--

