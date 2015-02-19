Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 Feb 2015 00:20:21 +0800
Message-ID: <2446417.y7QTPJMH7o@voltaire>
In-Reply-To: <1419594103-10928-13-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-13-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3030901.b09IVET663";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 12/26] batman-adv:
	iv_ogm_can_aggregate, code readability
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


--nextPart3030901.b09IVET663
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:29 Markus Pargmann wrote:
> This patch tries to increase code readability by negating the first if
> block and rearranging some of the other conditional blocks. This way we
> save an indentation level, we also save some allocation that is not
> necessary for one of the conditions.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  bat_iv_ogm.c | 98
> +++++++++++++++++++++++++++++++----------------------------- 1 file
> changed, 50 insertions(+), 48 deletions(-)

Applied in revision f7ac9a4.

Thanks,
Marek

--nextPart3030901.b09IVET663
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5g1IAAoJEFNVTo/uthzAC+8H/RumtaRUojInw0mBdalVIPhM
oihXbrQDO1ej/7LIhpZZf9dVLKuC9hjnJqWYOYP0SMHHBbmKiHxqx7X40gsap/PL
M0IFZBFzmxJs+Xrw84Tz3votatxr9oYexn9vCzIBccHCvUJMWis+G4iu26IMZmse
ISDZW2Grq34cBYccx4G38OEHr9N+LrSIlLSwHtvaBqgDhxAvwFr8VN+XXMK8PvPv
2H9N05NIxhtkm6krXkdMhaG5UrSDweiPQNK8wNuBB0A5yqbSxtw55vaN0Dg5bITW
RTKEcnyF2nJY1durTLID6NJ9kXCl4UMc8dMHq4KqeY7h+OKhpQFbFMknDV6sQPE=
=IchU
-----END PGP SIGNATURE-----

--nextPart3030901.b09IVET663--

