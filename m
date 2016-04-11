Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:25:55 +0800
Message-ID: <4712273.JC3yrz0kFn@voltaire>
In-Reply-To: <1457190564-11419-7-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1695566.mza4IrFzO8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv: Use kref_get for
	batadv_gw_select
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

--nextPart1695566.mza4IrFzO8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:22 Sven Eckelmann wrote:
> batadv_gw_select requires that the caller already has a valid reference for
> new_gw_node. It is therefore not possible that it has an reference counter
> of 0 and was still given to this function
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/gateway_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision e698321.

Thanks,
Marek

--nextPart1695566.mza4IrFzO8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC3uzAAoJEFNVTo/uthzAZ6sH/02t4GZYaF0pakYsI62EYsKc
Ay/mI5T20DnlYZtoNF+o/JV9ZiNzVGrFHdXd/E98B6mvvLIiO2Zz5s3iBPepOKd2
DiZozUMmtc6dKEZV7zb6D4XxejMa7/TW6qqjt59TZ5KvTSnTbOoCwjolMVakhJCR
eAmkgMhp0UbFjEEP5TWBjuaGtEwXM+Co/51acq3xY8Ov2UXwBSKFdlW9+ne1oG0d
n/tjWBwzBbx5s8pushywGdoHkoNPn1pO4Ve69QBdb+wqv42BFptewPgW8mdz/Fl9
wSqU7+rAfFxEEGmCd8Q9IKfP0War1j5TiLgKkdA2GEdQs65Nph+e1CKlTeLxZL4=
=BXka
-----END PGP SIGNATURE-----

--nextPart1695566.mza4IrFzO8--

