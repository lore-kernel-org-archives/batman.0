Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 05:47:11 +0800
Message-ID: <9988401.mi5Gfk0igO@voltaire>
In-Reply-To: <5648463F.3070403@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <56484502.8000206@users.sourceforge.net>
 <5648463F.3070403@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3115496.lf9YDrhiNn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Less checks in
	batadv_tvlv_unicast_send()
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

--nextPart3115496.lf9YDrhiNn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, November 15, 2015 09:45:51 SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Nov 2015 09:00:42 +0100
> 
> * Let us return directly if a call of the batadv_orig_hash_find() function
>   returned a null pointer.
> 
> * Omit the initialisation for the variable "skb" at the beginning.
> 
> * Replace an assignment by a call of the kfree_skb() function
>   and delete the affected variable "ret" then.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  net/batman-adv/main.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Applied in revision 5a878b8.

Thanks,
Marek

--nextPart3115496.lf9YDrhiNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUOZfAAoJEFNVTo/uthzAmIIIAIhojBp2a/my4W/0Q1Q5mhMr
ZlWxOIdgKhWPsYJ/OGPNEgpLHa543ItCCyiF0lf4N3NUEvhCoMmLJhOWqS82KoUM
X7oxaBJe4hjIOWkNSozWWYvERt+FlBUBUOQyWMxoEmnRvYcdyRG0DuB1s1tyWu88
1KqGJY8n1a8ogQim3sBCsmMNZyF33W/5t26cyogrZjiKwheA8K0BX92pjjgxY/0J
OzOhCNHn0O+bI3B/n9teKM80ZWbp74ffiChHl/v+Nf/K2U2fySiHnaRSSb7z/YjG
meknJjGKc51xb+RkAt8oVtPnj/hYv1IS9PL0vo9C+fNiqrRytOs1jFP7XJ8yIyM=
=Wl4b
-----END PGP SIGNATURE-----

--nextPart3115496.lf9YDrhiNn--

