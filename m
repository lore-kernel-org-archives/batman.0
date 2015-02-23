Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Feb 2015 00:50:10 +0800
Message-ID: <474924669.Bjhk69c1h8@voltaire>
In-Reply-To: <1419594103-10928-15-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-15-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22635713.kXe9StAotW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 14/26] batman-adv:
	iv_ogm_aggregate_new, simplify error handling
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


--nextPart22635713.kXe9StAotW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:31 Markus Pargmann wrote:
> It is just a bit easier to put the error handling at one place and let
> multiple error paths use the same calls.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  bat_iv_ogm.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Applied in revision a467a76.

Thanks,
Marek

--nextPart22635713.kXe9StAotW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU61pJAAoJEFNVTo/uthzAnRQH/i2YSTTCpP3CO8wnO4WbtB2h
VoiaVqcvmCuJNj/2sZqpDjF2r2QOJFzzyt1P5w0oP6fjXaXawTYoRH6P7cfDIGrT
F6xMf+bOMTO5saeifeHd9XFKqaOyC1goNYmGu175U1seV+6vXGWAbN1++fQ0QtWN
9RHdZ47PMhrVtJaPNJ2PidB7kaEVxaNeeLDZHDwRiOij00qL1K9dVGON/y8AJSUe
cqgk3lNRPPzyZNmUKIZlQWfgtB/B5a0dH3yEPwVL3Pd+IYKXIdJn+3WlH5CTon2X
6HyWk3714pcpXPvoiYu6iZ9lfc3QsJX64CCywnRONjHEH0Y3T0FRb3eEsSaQ488=
=hck3
-----END PGP SIGNATURE-----

--nextPart22635713.kXe9StAotW--

