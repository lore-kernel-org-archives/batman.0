Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jun 2016 16:37:17 +0800
Message-ID: <18126005.IvImGrenlx@voltaire>
In-Reply-To: <1465796492-5039-3-git-send-email-sven@narfation.org>
References: <1465796492-5039-1-git-send-email-sven@narfation.org>
 <1465796492-5039-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6482120.mOgXTjjtD9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: Revert "postpone
	sysfs removal when unregistering"
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

--nextPart6482120.mOgXTjjtD9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 13, 2016 07:41:31 Sven Eckelmann wrote:
> Postponing the removal of the interface breaks the expected behavior of
> NETDEV_UNREGISTER and NETDEV_PRE_TYPE_CHANGE. This is especially
> problematic when an interface is removed and added in quick succession.
> 
> This reverts commit a33c882c1069 ("batman-adv: postpone sysfs removal when
> unregistering").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v5:
>  - rebase on top of current master
> v4:
>  - rebase on top of current master
> v3:
>  - rebased on top of current master to fix conflicts with newest patches
> v2:
>  - rebased on top of current master to fix conflicts with newest patches
>  - adjust commit message to use 12-char commit id + commit subject to
>    reference
>    reverted commit
> ---
>  net/batman-adv/hard-interface.c | 26 +++---------------------
>  net/batman-adv/soft-interface.c | 44
> ++++++++++++-----------------------------
> net/batman-adv/types.h          |  4 ----
>  3 files changed, 16 insertions(+), 58 deletions(-)

Applied in revision 0994697.

Thanks,
Marek

--nextPart6482120.mOgXTjjtD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXZ6s9AAoJEFNVTo/uthzAr6oH/1LEqlDtGPHaaNrgZDEsUIOe
lzsyogPLBiSzmaUJ7WSHaVj9uLETc2qvG3aQDQvcD0SB0WfKd9fwwadG9tHX0R0S
+gNBQT7k8a/MZ6TMs33fKSzdJEUm39qPqDEucdBGVJdr+ZjKmaVd4Zth24/HRmzZ
WVm7skSjfv0HMXp4i82OxxS48K1Xhe1WAQJ6mGTq5XEaUyMO9wie+60Hpa+Z4UHV
zPuGG1aByAud3HQB0QhOdquWc6ImJfSpsN7Tj44RuQ92iYHjZt4a6xh1ANyC4LgU
kV3tXZzEt1fe4eWyY88BaIfNQubm8XboGSet4MN7I4qA67XjXgh1ysaw8BAi23g=
=Tj3J
-----END PGP SIGNATURE-----

--nextPart6482120.mOgXTjjtD9--

