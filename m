Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:36:41 +0800
Message-ID: <5639899.FL9JXomkJJ@voltaire>
In-Reply-To: <1457201124-8495-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-9-git-send-email-sven@narfation.org>
 <1457201124-8495-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8906102.JDOR31vxKq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 9/9] batman-adv: Use kref_get for
	_batadv_update_route
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

--nextPart8906102.JDOR31vxKq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 19:05:24 Sven Eckelmann wrote:
> _batadv_update_route requires that the caller already has a valid reference
> for neigh_node. It is therefore not possible that it has an reference
> counter of 0 and was still given to this function
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch requires https://patchwork.open-mesh.org/patch/15888/
> 
> v2:
>  -      Remove one of the empty lines around the removed block
> 
>  net/batman-adv/routing.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied in revision 4390308.

Thanks,
Marek

--nextPart8906102.JDOR31vxKq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC345AAoJEFNVTo/uthzAp2cH/jUhHiPC+hBsdT4rEASc24za
Ev0sV3M7dFOCluER5Suk+cSRBFoCa2UFoItXB1uClkOWBg7Vl6fvRzKAko5tUvsl
oiqdw4CMPYeH0jQqxr8Z9KbSFfXr7p/+XgP8O9de8bZ08kaYBajxbOuFCHe27vtr
xqir2o5sZenZ3bllD3mOMwYRzxPomDej/qDPdyWUPUUBi4DBOKKzhe7IHyOZMSnF
2bePCReZNJtgGYRb509y0wsEaoXkXs/BF8Grs/tpEPY41w1bxilrhxDnEXsj4Y44
oqAXiwHR4O+fsi5F+h8hcNj/8wmLCCyBfYAFrQWcnzR6QJyfZcWv7NxAmmiQ9uQ=
=X4pg
-----END PGP SIGNATURE-----

--nextPart8906102.JDOR31vxKq--

