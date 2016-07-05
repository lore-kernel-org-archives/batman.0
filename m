Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:42:44 +0800
Message-ID: <4409004.MzGxlJWWQl@voltaire>
In-Reply-To: <1466445289-17840-2-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
 <1466445289-17840-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2235426.BPo86eleOf";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 4/4] batman-adv: Remove
	unnecessary call to dev_xmit_complete
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

--nextPart2235426.BPo86eleOf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 20, 2016 19:54:49 Sven Eckelmann wrote:
> The dev_xmit_complete function is only necessary to check the return value
> for *_hard_xmit functions. But batman-adv only uses dev_queue_xmit to send
> data via the interface queue.
> 
> From the kerneldoc of __dev_queue_xmit:
> 
>     Regardless of the return value, the skb is consumed, so it is currently
>     difficult to retry a send to this method.  (You can bump the ref count
>     before sending to hold a reference for retry if you are careful.)
> 
> Fixes: e3b8acbff9c8 ("batman-adv: return netdev status in the TX path")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - added this patch
> 
>  net/batman-adv/routing.c | 10 ++++------
>  net/batman-adv/send.c    |  2 +-
>  net/batman-adv/tvlv.c    |  2 +-
>  3 files changed, 6 insertions(+), 8 deletions(-)

Applied in revision 1718050.

Thanks,
Marek

--nextPart2235426.BPo86eleOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3MEAAoJEFNVTo/uthzACU8H/i9dhxcVhghFb+An1UGh6JuJ
CRXMNO4433LaP/pcaR8ZWTzJ/HIsG6SGgcriHKwQ6fVQrsBHkLPySdDfqwZ/QyV2
w+JlQtWE/yOQWiyYB5+2NQFmJaEIlXpxMGk8EFhVLZv7BWAssaGHcLX2M+zgF94Q
bhj7Wsq+QhASA6wqQuxQDJlFjET1IR9V7eykJmhK3wyiAwvKOl9i9WSETzgMxbOa
e6TtHjC0rYhOELnqyr3JwFW1/w0OU33T/MngE8ovxoPRuGYQxSKjy2ZZyrMy0pJv
gkSzrgvcZT+aRA+KMlxikUCSxNI1+NlY57e2DyDj8i2vmwC0prk7bbX0qGFUeF8=
=wPio
-----END PGP SIGNATURE-----

--nextPart2235426.BPo86eleOf--

