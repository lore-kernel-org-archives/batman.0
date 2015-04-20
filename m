Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:37:08 +0800
Message-ID: <2514179.t8iz1bT8cA@voltaire>
In-Reply-To: <1429288461-26260-3-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
 <1429288461-26260-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2889755.ULTbVkJ0Jr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 3/6] batman-adv: Use kasprintf
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


--nextPart2889755.ULTbVkJ0Jr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 18:34:18 Sven Eckelmann wrote:
> From: Himangi Saraogi <himangi774@gmail.com>
> 
> kasprintf combines kmalloc and sprintf, and takes care of the size
> calculation itself.
> 
> The semantic patch that makes this change is as follows:
> 
> // <smpl>
> @@
> expression a,flag;
> expression list args;
> statement S;
> @@
> 
>   a =
> -  \(kmalloc\|kzalloc\)(...,flag)
> +  kasprintf(flag,args)
>   <... when != a
>   if (a == NULL || ...) S
>   ...>
> - sprintf(a,args);
> // </smpl>
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  sysfs.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Applied in revision aeb0f1d.

Thanks,
Marek

--nextPart2889755.ULTbVkJ0Jr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHRkAAoJEFNVTo/uthzAfWoH/j7SoynNt+zLZA3GgrcbMzGd
68U/QktMhrwpBeiELSEVMDNisxq9gsph21kZksjKsR3ZJRo6Es1lr4OfPMty+Li0
ISqcCJuETUTFlsvQQg7qd2hSmju6xAqXbeW4nBkcfV2jsNIqx6rRWAiRHPE76lU8
OtkLqp1pil7GdLp2nmUnjxI4kHKoG/Zamu5ReEtqE9eCNOnqvt1pUxFr5ky88U9o
/H6M/7HCU7pBnu/i8EyABxQFv9y5kWaM5bGelKWucGjd+tRBaFo9s/ZWyr5gBuZY
YSKZHnMuuXSl5U8+2TGL1P3RlMjpGDMc2M7Sin4yLDQzh6ZZePAan/AtKi8CPMo=
=tOI2
-----END PGP SIGNATURE-----

--nextPart2889755.ULTbVkJ0Jr--

