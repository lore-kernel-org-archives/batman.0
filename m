Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 05:48:34 +0800
Message-ID: <1654342.xzdxStlkQC@voltaire>
In-Reply-To: <56391EAA.2060002@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <56391CF7.9080400@users.sourceforge.net>
 <56391EAA.2060002@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2885958.OeX6xKt5oC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Delete an unnecessary
	check before the function call "batadv_softif_vlan_free_ref"
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
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Julia Lawall <julia.lawall@lip6.fr>, Antonio Quartulli <antonio@meshcoding.com>, SF Markus Elfring <elfring@users.sourceforge.net>

--nextPart2885958.OeX6xKt5oC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 03, 2015 21:52:58 SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Nov 2015 19:20:34 +0100
> 
> The batadv_softif_vlan_free_ref() function tests whether its argument is
> NULL and then returns immediately. Thus the test around the call is not
> needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  net/batman-adv/translation-table.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied in revision bbcbe0f.

Thanks,
Marek

--nextPart2885958.OeX6xKt5oC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUOayAAoJEFNVTo/uthzAkjsH/jVuyf4Ouw89Isf/n3xjAKOT
b6GzZR66BrYCQeizuq/ZvxiIyqbM2J+rv2JrsO0Bz1kVqC3TJMC+JGvR6k7YWkBK
VDgWOs2d4FTlu+XIk6Wn5sd5C+5a+xcKwxx0FLifM+9DejfdLPoQqDJx+P7OXjFA
ddzXEaW3JqoTc5wceXDGKGcnt/8zlvAUWjxIhs3tYeE4Uc+VbU0kJLZFORIOt9O4
5lWbdKNVoCU76A+NmxjflJX1wvi64gi5oikJrfVPJu2dCAAySSV37vG3uaaLanLU
Hs+nEQE9IqVoxTtXmNGChZ4rqvYvHJtgoUzmnBcluzHq7CRIfrEcGMpsqYmeU1c=
=mmCS
-----END PGP SIGNATURE-----

--nextPart2885958.OeX6xKt5oC--

