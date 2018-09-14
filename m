Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 14 Sep 2018 19:48:24 +0200
Message-ID: <3307401.fCaFkusQ1B@sven-edge>
In-Reply-To: <20180816145445.27289-1-sven@narfation.org>
References: <20180816145445.27289-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2430174.eyVj0xqhkX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Move OGM rebroadcast stats
 to orig_ifinfo
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

--nextPart2430174.eyVj0xqhkX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 16. August 2018 16:54:45 CEST Sven Eckelmann wrote:
> B.A.T.M.A.N. IV requires the number of rebroadcast from a neighboring
> originator. These statistics are gathered per interface which transmitted
> the OGM (and then received it again). Since an originator is not interface
> specific, a resizable array was used in each originator.
> 
> This resizable array had an entry for each interface and had to be resizes
> (for all OGMs) when the number of active interface was modified. This could
> cause problems when a large number of interface is added and not enough
> continuous memory is available to allocate the array.
> 
> There is already a per interface originator structure "batadv_orig_ifinfo"
> which can be used to store this information.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c     | 330 ++++++++++----------------------
>  net/batman-adv/hard-interface.c |  47 +++--
>  net/batman-adv/originator.c     | 107 -----------
>  net/batman-adv/originator.h     |   4 -
>  net/batman-adv/soft-interface.c |   1 -
>  net/batman-adv/types.h          |  62 ++----
>  6 files changed, 145 insertions(+), 406 deletions(-)

Applied as f36b93064420 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/f36b93064420d44998f7984671d5c78668cca059

--nextPart2430174.eyVj0xqhkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlub9GgACgkQXYcKB8Em
e0b+3Q//R2FSOkzBLEHMXGpMSSyuPklwK+F4yg+cWMFDtqnxGZZ/LxPyY6Ub0LgL
t6An0POrnWUwr5U+hpmfb8TIStetITU4HNuSvyLAWtIGl0hieNbBhuIY5qF9i5Y8
vPisUEvYLs3VeAu31r5mR5oUFtD4PWfpfwtZ8AubiwyY1UdC9CrJzSe8BS5Wd7p0
qzi+qwnd9nx0vJfmEVX/oT7NXDWm1slgx2wj3+xUsQsCRQK6bhU4Wyv2xUdi7FTZ
y/i/8VXyQOGSF0sb3jzh99yfCx+hlj8WkvUWCoSfp4deZmaaw2SWdLOtwvhMU6pE
t3sj/8f9t9vmMoff4Gk6WhzeJT7Kov/EH0kY9P80ZPA74iYcXqI4hqjU6GQ7EH4B
yMr0GMd6RmZtXL3XvYlbPrc6VLKUyD1G+j/xkDbJw73QCvWkcrqa77jFlium0AXl
txxPsG1diVpIRS0y42sOL7QZccx9TWRRM0Elwo+G41OWBsMeGRXvGUwYco2DG7WQ
WNgEJcNnsWUITP2Wa/vU3AJabTFT3CJyhIFXG5fpBHPcOho9PO9yBMWz/qgpU+PU
QI859Znt0uI4UeoaSlrr2LhEqJ8WKTGh1/M32eIscIKRg1P1L9cqGd9lMUgFF+HD
2ZOCy4akz1HpHxVQ5jvjnjlHkurRq8qOl/IUz0dEioT/q6meALo=
=wrL5
-----END PGP SIGNATURE-----

--nextPart2430174.eyVj0xqhkX--



