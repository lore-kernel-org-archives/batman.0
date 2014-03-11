Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Mar 2014 17:53:45 +0800
Message-ID: <2431783.amLVKcr4jb@diderot>
In-Reply-To: <1393420242-1698-1-git-send-email-antonio@meshcoding.com>
References: <1393420242-1698-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3933670.1mHFsAt7mF";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use the proper location in
	ether_addr_copy()
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart3933670.1mHFsAt7mF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 February 2014 14:10:42 Antonio Quartulli wrote:
> Introduced by: 513b2d107a4d88f62b9394926e377d2c6250775f
> ("batman-adv: prefer ether_addr_copy to memcpy")
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Changes from v2:
> - added another fix in routing.c
> 
> Changes from v1:
> - added Reported-by clause
> 
>  icmp_socket.c | 2 +-
>  routing.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision 3b8bd3d.

Thanks,
Marek

--nextPart3933670.1mHFsAt7mF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHt0tAAoJEFNVTo/uthzAFjUH/jJGRL0p/RuPwVSaGAd2Iqpj
XdtIpda86FDr2ZxlT6Zv6VYBmmRvUY552Dphueug4ljyUh649RVIPx1v9ViajJse
TggkTxgNJaqyCQMNUWobjTHr7cza+KnhQhOEWORzjvDgUoosxMsLNG04cYpr0/zC
KbuJ/bHnb4yOxZFtazIiRWwmg/ErmRbCkqd8SzcYb9i6aiBSMfpCr5HiTZaVrV2p
rO2a06fDG9pZcz2N+Ps8vVEWpJ8A0mxlIm3M9C54RrojLj3/SE0WHuJJXGOZXjs9
5wPrxYdxFyTiwrM+A+26+GtjLfrPwHaAhwazYGxh6RT/BYO2DoPBJBvyotakbyw=
=MC2w
-----END PGP SIGNATURE-----

--nextPart3933670.1mHFsAt7mF--

