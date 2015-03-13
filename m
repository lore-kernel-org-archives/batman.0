Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 Mar 2015 14:06:15 +0800
Message-ID: <3195269.J1ETID3QPh@voltaire>
In-Reply-To: <1419594103-10928-25-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-25-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3749706.PfWSoDCXOo";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 24/26] batman-adv: Remove unnecessary
	ret variable in algo_register
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


--nextPart3749706.PfWSoDCXOo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:41 Markus Pargmann wrote:
> Remove ret variable and all jumps.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied in revision 16b4833.

Thanks,
Marek

--nextPart3749706.PfWSoDCXOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVAn5YAAoJEFNVTo/uthzA8c4IAIyREYB2yMd7+zAOBcM5IEi8
Xwv69dbdO0obvtyraP8rwOhY5HTSyJgKIx9KO96Asx7AGT0Ckf8/imyzWtqK6L1a
Spo22S3EssMVojsNaXMlUwNFmEahLHtOrCwJGP8IAmrgKj4MYHA3BRBW/YdJhqLs
JxXS21igrbzv6yYp5oFpzpgate4rCC4MCuKHo+h4Y8OIqRyZ8w5nwwo9cEhx9hXq
i+mHvceW6R7pK5VmkBgl6hWfuJWMLCDXaFHC3tYL2kFo+uEyfCT9xqNui7Sn9yCx
FIwTbywf3ghRtLxJ3lbYv8XjCu5smAGcT6cWZEtKRpOseJ59qtRbFyBp/VXslOY=
=rbXs
-----END PGP SIGNATURE-----

--nextPart3749706.PfWSoDCXOo--

