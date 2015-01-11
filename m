Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 20:48:25 +0800
Message-ID: <4512771.fZWsjPeCVm@diderot>
In-Reply-To: <1419594103-10928-11-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-11-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6899685.sRATB65C6h";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 10/26] batman-adv: iv_ogm_aggr_packet,
	bool return value
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart6899685.sRATB65C6h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:27 Markus Pargmann wrote:
> This function returns bool values, so it should be defined to return
> them instead of the whole int range.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  bat_iv_ogm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision ec3b2d9.

Thanks,
Marek

--nextPart6899685.sRATB65C6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUsnEZAAoJEFNVTo/uthzAAF8IAJEuWcphpLr5765WMJvnWEKj
Xk47mDlXIsOpdvUTG8wXDREkTQRHfYol7pOfPCHzFB48p90oF5NOOxKfdxRiXuha
sjKulW+ESqYLDGs+aIbu1KGELdS4IGEUWZSCsXdecY8PnCmhbm78LftWqWG4IZ5v
7gAty7v8eqotecws+n7BIrBkFyPUV4QKXQ0fkagmbFN+uTgdBaf6a8ttJqgnkq25
1YD6rY+Oa4NS1flXd4U9ofN/SJ65/ev+wbPPXS00ga4wDDtgpfQD88gAN/CZIUhl
Ku7PR3B1T6ISmvpRcnt5GzAKR8jzuOeT2XPoy9c4kk5AFeKeg7uqjJnsICUGLNY=
=WKOR
-----END PGP SIGNATURE-----

--nextPart6899685.sRATB65C6h--

