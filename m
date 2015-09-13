Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Sep 2015 18:24:32 +0800
Message-ID: <1770787.C9qRAE2RKP@voltaire>
In-Reply-To: <1441568333-15947-2-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
 <1441568333-15947-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1745111.pWKMC4mExG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Fix kernel-doc parsing
	of main structs
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


--nextPart1745111.pWKMC4mExG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, September 06, 2015 21:38:45 Sven Eckelmann wrote:
> kernel-doc is not able to skip an #ifdef between the kernel documentation
> block and the start of the struct. Moving the #ifdef before the kernel doc
> block avoids this problem
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/types.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied in revision af45ff7.

Thanks,
Marek

--nextPart1745111.pWKMC4mExG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV9U7gAAoJEFNVTo/uthzAs7cIAKQPY5VyQHFxNau9GXzF0/96
6X+3S5XWOLx4nfdOzUVd3yJDDFZ+3OPgEqoe6sbt49KygmyaFYgY7p3LGbRO9KLN
JXpoeP8MdRoGKcIfg/CdVf+PYgFc8jIbsscwm1sxXP0x4cfob51oClXKDiJzXvit
4isRc0f15EddB4VwzSBhJmBVqW9XYAS7/wMozKT7gbtlWMmc98OonkD7G3va+gnb
FQ0bY4Diy8W/6aEsv8KijcqsYfr6QQPu2joscgYsSOrdgTLTToZYf4UD1KsUGqPd
LT7njcmvA0FZU4bU3p1TXFwzVZwUqi3r7yjPv2beSRfdFsnyejAboWrmKnp17X4=
=+Qbz
-----END PGP SIGNATURE-----

--nextPart1745111.pWKMC4mExG--

