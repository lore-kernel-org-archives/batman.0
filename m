Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jun 2016 12:43:05 +0800
Message-ID: <2347483.HUSTML5s1j@voltaire>
In-Reply-To: <1465332293-6218-1-git-send-email-sven@narfation.org>
References: <1465332293-6218-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1585888.20rgqUlpiG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Document optional
	batadv_algo_ops
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

--nextPart1585888.20rgqUlpiG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, June 07, 2016 22:44:53 Sven Eckelmann wrote:
> Some operations in batadv_algo_ops are optional and marked as such in the
> kerneldoc. But some of them miss the "(optional)" in their kerneldoc. These
> have to also be marked to give an implementor of an algorithm the correct
> background information without looking in the code calling these function
> pointers.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/types.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in revision d6f42a6.

Thanks,
Marek

--nextPart1585888.20rgqUlpiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXXjnZAAoJEFNVTo/uthzAUpoIALn4hDrTBuSxxNIvAwTGi+7B
Y4U0o2A8FaPBxbwYwd+h6NVTtN8SEPWwtP0+hn8AVsapvI8Oi7LZzumQX042pN0u
kMlHvXheV7A2PEj1Z6GrBBfzefHeJ9cV3fasT0IYMc/+Zu78qZ/xcJHk/dPieqwh
yXf30pJc43DEbb+z6HxpGsrGdPrXVl/2AtDjd7PLsQrMbwY+MpFf6nM4tqM68tcT
T1q62YN/4TMO27saTIypDYOTnaCmPDdZAPxKhbPCdqo04QeQJcyQ4Uv9j+2Xgdfg
utIUIdtPbOC1IQHkJdqe1mNbsLCc9u57G/BcHQaOn8NVR2halHBD1oKCC/ajgYk=
=IZBz
-----END PGP SIGNATURE-----

--nextPart1585888.20rgqUlpiG--

