Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 13 Nov 2013 14:55:05 +0800
Message-ID: <18218643.t6ud2FMGTs@diderot>
In-Reply-To: <1383807727-662-1-git-send-email-antonio@meshcoding.com>
References: <1383807727-662-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2120537.1WgEPiqhdr";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove parenthesis from
	return statements
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2120537.1WgEPiqhdr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 07 November 2013 08:02:07 Antonio Quartulli wrote:
> Remove parenthesis around return expression as suggested by
> checkpatch.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  distributed-arp-table.c | 2 +-
>  main.h                  | 2 +-
>  originator.c            | 2 +-
>  translation-table.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied in revision e6198c4.

Thanks,
Marek

--nextPart2120537.1WgEPiqhdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSgyJQAAoJEFNVTo/uthzA6s0IAJrO545CgsIHPZNRdGZFl+M9
1yj4HQDp3PmLqExEJdBJvS5wMZSdojLIRSUlA9nrl7iXyNT4HS2O5dGg/tCQttx5
wDR8sXrFST2SA39ulPcirGqa7kqY92LRCyRvFnBJWfRV8/QwXvNT/njgeVizWOc2
7B7MDgwJ/JGV/rXCgXRy13AyIbXaUj/ec3MR/hHkPEsyNaL8Vw6ryRAZo4PB9Jui
wM0p43NLava08WZORxCn+f57q74+/3Y52G/9GZ7dEmHm0NmMb+qyl+8+pLMx6Y7t
c5Pk8NECXswJlGDTEQ+cgj3Ey3UyBllxvEEW0yD2dPIJtsf0hNbQ3tl9YjMmS0U=
=5HVD
-----END PGP SIGNATURE-----

--nextPart2120537.1WgEPiqhdr--

