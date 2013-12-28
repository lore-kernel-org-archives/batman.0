Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 28 Dec 2013 16:39:04 +0800
Message-ID: <2694049.AXOnNYvq8q@diderot>
In-Reply-To: <1388080621-15040-1-git-send-email-sw@simonwunderlich.de>
References: <1388080621-15040-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3195011.MUnETSytIL";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix NULL pointer deref in
	batadv_find_best_neighbor
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


--nextPart3195011.MUnETSytIL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 26 December 2013 18:57:01 Simon Wunderlich wrote:
> If there is no best neighbor, don't dereference the NULL pointer. Try to
> acquire the neighbor node right in the loop instead. There also was a
> logic bug, finding the worst instead of the best neighbor.
> 
> Introduced by 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv:
> split tq information in neigh_node struct")
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  originator.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Applied in revision 183150b.

Thanks,
Marek

--nextPart3195011.MUnETSytIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSvo4oAAoJEFNVTo/uthzAtCoIAJytak8lmEd2+h9gacrtu4xk
6eLT4NCXa9zXTQN8DIrh6THNFlLuiBImy7piQiKCUmWDTK6gJNue76t8uVr975ZE
zZA3gUR8p3T5L8iVEb/2IgTFxRc0PGdPc+4S/FyljbmRBfMgnKc4jkfdPM7DLRmz
PbLSnqbsUP3IGQ8ZqLeGQ2VwgK+NkI3B0vgh+TX2bi0MCH65tw2ToaqCA0S/8sSF
PtD7oZxeOs9Ex+19CFK4PlKGTR5i7T/bWtnJ6pJACHOI9ZpOb4ncIkXxpFPHD/N1
1qWjC0ZxSaXJnnZ6l+cY+K+Wwousx+myps3ypvldvg9KP6IalesYW41k0qezqo8=
=eAtD
-----END PGP SIGNATURE-----

--nextPart3195011.MUnETSytIL--

