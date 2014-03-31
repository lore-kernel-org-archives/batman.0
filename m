Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 17:28:54 +0800
Message-ID: <2653301.pzRrpynKvb@diderot>
In-Reply-To: <1395845184-15186-4-git-send-email-sw@simonwunderlich.de>
References: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
 <1395845184-15186-4-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1831916.E96jDTf5Lq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 3/4] batman-adv: always run
	purge_orig_neighbors
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart1831916.E96jDTf5Lq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 March 2014 15:46:23 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The current code will not execute batadv_purge_orig_neighbors() when an
> orig_ifinfo has already been purged. However we need to run it in any
> case. Fix that.
> 
> This is a regression introduced by
> de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out router
> from orig_node")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv1:
> 
>  * check two change variables separately
> ---
>  originator.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision 7212515.

Thanks,
Marek

--nextPart1831916.E96jDTf5Lq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOTVWAAoJEFNVTo/uthzAAPMIALnJ/hgv5wDXEYSvg6shpFs6
sJpr80f4CCX4FdxabyCg6brHdfNLhnL4EfxLTQkCOOXJqoH70cGH4pnKc+jP3cHu
GAtB3ELNBnaRtGmzWBYqj5d9EYI2atNNJR4ud33wBkyJtQwYc3TBBa3S9wdeuDFB
gOIzvS5gjFnT+NuIAULywROw44K/pqyCzez3UKSsKhyK/ZjSGAmd/B+SM8SNvvc4
0G37m6iiEMWp4WK1yk+Jbiw28KOgTEVe4MaREY1v70yh4UbDuDYECqWbmz3R2DGX
KXVdekq/bEoNtEHerL1O0HXh66Nr27+VXKW2CJGoVQP0dJP0QWT56KxIIgDEnas=
=hlHA
-----END PGP SIGNATURE-----

--nextPart1831916.E96jDTf5Lq--

