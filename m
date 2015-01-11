Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 20:46:28 +0800
Message-ID: <5552426.9Lht0LTzNo@diderot>
In-Reply-To: <1419594103-10928-10-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-10-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1713746.Rh3SGkCdjT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 09/26] batman-adv: iv_ogm_iface_enable,
	direct return values
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


--nextPart1713746.Rh3SGkCdjT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:26 Markus Pargmann wrote:
> Directly return error values. No need to use a return variable.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  bat_iv_ogm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied in revision 0cc4569.

Thanks,
Marek

--nextPart1713746.Rh3SGkCdjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUsnCkAAoJEFNVTo/uthzAaX0IAJ2n9AEbPjCV1oPQTAQUg5fQ
4sq4dbOdbRb6Cb4hVgQPF8SJreKu8Z/BtkQw5KNDhofBC4+/uICaCrWOuzOe63sI
hTcDAIkC6zswJar/9PIacAqD38LwKhRStAkY8mQR8aO35HfdM2acdC4prrd07hSo
drR6ArIPeeI3TR0Ml/vVTfqF2D2SjiegmiVlpnl5RxTFzPQVCUQMZmyusY81byU2
jh7MMj8lfPzETzSUn/KnxeZL8VWhJy4oU7k7fR35sQirTWpCKwaZqLGXm2h/SqiH
eh6/cWg+Ft71eDLv/5uZPpXw+YC+F/PWljc001+KD/MJ5IJXTUD20fEc7xx07vw=
=r35z
-----END PGP SIGNATURE-----

--nextPart1713746.Rh3SGkCdjT--

