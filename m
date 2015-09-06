Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:36:02 +0800
Message-ID: <5729114.Rdet07UaxZ@voltaire>
In-Reply-To: <1440577911-16107-1-git-send-email-sven@narfation.org>
References: <1440577911-16107-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2546665.JkRGibp9Qp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Use chain pointer when
	purging fragments
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


--nextPart2546665.JkRGibp9Qp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, August 26, 2015 10:31:50 Sven Eckelmann wrote:
> The chain pointer was already created in batadv_frag_purge_orig to make the
> checks more readable. Just use the chain pointer everywhere instead of
> having the same dereference + array access in the most lines of this
> function.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/fragmentation.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision d54f7c8.

Cheers,
Marek

--nextPart2546665.JkRGibp9Qp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/ryAAoJEFNVTo/uthzAhPAIAL8ZhMQFb2XpUJX625Ixie04
8GgSTLFvFcOs1OXDexIzEXvxtiQJJiBd7cWUZm6xciG9jok9I4UWQasbDZd6gQoG
5ePLUIZxEIElS1j7HIbKPqq7co4TOfkjrJTPfKe2e0pGCj+tEt0ovDVwlyZWrg8I
KcxKd0/ZzF96YwZ8pAh41ANV/L8yPlPg4DcJkukFp7mOGamgZsBFQrTG/UG8xO/V
zTn7XBiJNRaEB+fikXlq45Hd8ALbevJA13jpjHyjNf/FR9+EEzRxcTe/pRqoYbAR
10gap9vh6hsuh6GKU5brzeTp/+HsrMgiU8ckNOOwsjqiZrIODjikB39TYWshsKY=
=nogm
-----END PGP SIGNATURE-----

--nextPart2546665.JkRGibp9Qp--

