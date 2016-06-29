Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jun 2016 00:19:15 +0200
Message-ID: <2204976.3uEdOmLjge@sven-edge>
In-Reply-To: <1467237137-8418-2-git-send-email-sven@narfation.org>
References: <1467237137-8418-1-git-send-email-sven@narfation.org>
 <1467237137-8418-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6409071.9ZkJkfjlEk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: Fix non-atomic
	bla_claim::backbone_gw access
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

--nextPart6409071.9ZkJkfjlEk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 29 June 2016 23:52:16 Sven Eckelmann wrote:
> The pointer batadv_bla_claim::backbone_gw can be changed at any time.
> Therefore, access to it must be protected to ensure that two function
> accessing the same backbone_gw are actually accessing the same. This is
> especially important when the crc_lock is used or when the backbone_gw of a
> claim is exchanged.
> 
> Not doing so leads to invalid memory access and/or reference leaks.
> 
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Fixes: b307e72d119f ("batman-adv: lock crc access in bridge loop avoidance")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Hm, this doesn't look really correct. Maybe we should drop this for now.

Kind regards,
	Sven
--nextPart6409071.9ZkJkfjlEk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdEljAAoJEF2HCgfBJntGHkUP/2yPTmH2WhXnVJBG6DdDNv35
Gyq97lM5NEXrZaZSKF/CIZwdiJSx3acWpHG+cvZHsVpWQ8wDBTuzWLoV9MFBIZlq
LRVW4K+6tMDMqbskgzPHssoVaC4Pbnk0K8E8gKb4eJQwRlWA1KEHuZOQsYu/ByIA
tl3R260N71ZH00nGPvGC2kzzV0YzvJzjChZVTikuXw9PPDMtl4lxZCZmOT9MldZ+
r7EWV17Uib8SPDnZ5pkpcooKl3+rTsr1aNMbXYdGtNG89O6nltQRVwTKD+PcLomW
kjLA7g9WmQjw33RoY7hQ3doyJxYM/vXdoW4tq1iXX2TSSIaGQU6Nx0uEPS+MYgxB
rDDEth9Hy14PuIY+E6v8/PtNN9P4X+SXJ6GuQLVyUqRFS7d1nUPoCQRgWwSCiOOq
Nev6XW+pa3/K5vF7gMJPrztP9hD22pJ8FyECq30TKZtmWDMtSMqK8NdxEAfmSiZr
RUp13KKJ88bb684sXT/ALJGeKZUumzoi77Lx5XdR6rdB5ekwi7pf39SyZnNmTSEL
/ntqou2j6baPurPyo2P5ejYTi5oK8/wXhEfRa9BICaadl8cPambU+Peu0kcfBUbO
AIqBioEoisRZuffiRUoCUgWRfQ0vlTMpX0K4RGLv3O9eats294RjFfQv+DkrGgyM
S8XguI/d4M3GS+JJCjhN
=OnaR
-----END PGP SIGNATURE-----

--nextPart6409071.9ZkJkfjlEk--

