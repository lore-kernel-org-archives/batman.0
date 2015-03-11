Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Mar 2015 17:45:02 +0800
Message-ID: <2878011.uJW0RIHhzk@voltaire>
In-Reply-To: <1419594103-10928-22-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-22-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1619248.x1gk4nE7KC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 21/26] batman-adv: main,
	Convert is_my_mac() to bool
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


--nextPart1619248.x1gk4nE7KC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:38 Markus Pargmann wrote:
> It is much clearer to see a bool type as return value than 'int' for
> functions that are supposed to return true or false.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  main.c | 11 +++++++----
>  main.h |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)

Applied in revision a5b709e.

Thanks,
Marek

--nextPart1619248.x1gk4nE7KC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVAA6lAAoJEFNVTo/uthzArY8IALk6aMr3L13/ZZost97a+3ZO
z5FIPbED14WlQPxC8snavJEDgj1FPDrWqUDjI5WHLOhF3mZlevgNha2KjvoRtoSc
GYNArifnJzH1XZkRmz7FbLgOY1sXm86oazz3g2+MEgAPQuPHBF/8Ww8Dn5g7ZtLZ
IP9qDNw8jS2zUDiAxFaisVkotztDqBkVDwIQsL3PGj4XTcL0GlbKYRFDVJyhC6n1
d2iGGbNMeG7NA5AO4wxohjq1j8rt8/CpUVq3LBtLy2N2MqxmEsRsqsBiFlwwpOwe
BJTkEm0T5Dljotg6lVjolTxiLUEW/TKt2VCHg02EwrdfeN1VoCy3odLjjlcTtrA=
=etkr
-----END PGP SIGNATURE-----

--nextPart1619248.x1gk4nE7KC--

