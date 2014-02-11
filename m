Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Feb 2014 20:02:58 +0800
Message-ID: <2534982.9qcKRLp38k@diderot>
In-Reply-To: <1391873298-3639-1-git-send-email-mareklindner@neomailbox.ch>
References: <1391873298-3639-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1499150.jg4L8sYoYC";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: call unregister_netdev() to
	have it handle the locking for us
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1499150.jg4L8sYoYC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 08 February 2014 23:28:18 Marek Lindner wrote:
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  soft-interface.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied in revision 548c938.

Thanks,
Marek

--nextPart1499150.jg4L8sYoYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS+hF2AAoJEFNVTo/uthzALskIAKLA9IyTS2rrjL8vaMXe8lkL
AJQOu1kpdTQEN9CT8Sgyspm8ygUVenFqYphaIhZ2ZzD90TIEi0YEKixqgUJVhHj5
OXRNoia26ncSFiKQNqfhOSTauJ10T3LJeT2d4m/Ps3ToRhHY6pppAKr6nRVjj6ld
eCLmxMVixmqr5S2ZcJLXcj0vl7g6xKLX9GlmFD/erp0iO+tl8vVTT5xs1+3yGxfQ
yOmCjbtXbiv50wfFAKrmVpzvQ+NGbvn/2XmeUp5CRqy2zB6j3ujgpXrrmrYIqYSE
ZgXhyZGgmGjYeY+1aKmvVhGm1I2EzH8v6X+rXB9Phzb2pD3jGLpIVc9Qz8SJd8k=
=9JNX
-----END PGP SIGNATURE-----

--nextPart1499150.jg4L8sYoYC--

