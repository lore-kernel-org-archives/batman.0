Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 17:14:39 +0800
Message-ID: <2046742.HvVA89XMWn@voltaire>
In-Reply-To: <1419594103-10928-12-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-12-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2038230.EuAZWU43j9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 11/26] batman-adv: iv_ogm_send_to_if,
	declare char* as const
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


--nextPart2038230.EuAZWU43j9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:28 Markus Pargmann wrote:
> This string pointer is later assigned to a constant string, so it should
> be defined constant at the beginning.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  bat_iv_ogm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 3de1d1b.

Thanks,
Marek

--nextPart2038230.EuAZWU43j9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5FgDAAoJEFNVTo/uthzAE40IAI9HtRgrA+pdSGACxu4trI1h
7PPdf+78nzJmF0zgs0erSeSygV7ihCycBChzd6yQQ4h5HRw7SZrc44dSDK3JFdGi
Pgkbs/rnwWwX3xUlUhqPth8jGJp5gqCR++u2AT5zLR43nocCi+3adfWxQAZusYx8
P6z1Wn4BLf/ZDvjoe0oFIOIVwzioHxORjyCB0XdQ2mm4NmrLVHfzkgTJbbNmhKlo
F2mbFrRxQ+UW1hADmZ1Ih4CjtG/CqjOSsAA0hC/7Mc1AnCo9RQUFXfD+BE/aIoYz
s2/qvONacw8sHejrTwZrWL5qV7R37kjXorqdprAOkZYsZXxrh7dqsDtr3X/8D5U=
=aGwp
-----END PGP SIGNATURE-----

--nextPart2038230.EuAZWU43j9--

