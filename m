Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:05:39 +0800
Message-ID: <3550187.MrbJrCgVC7@voltaire>
In-Reply-To: <1468836728-21890-7-git-send-email-sven@narfation.org>
References: <6098496.c9QsHxvAun@sven-edge>
 <1468836728-21890-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3524657.DTFGMGlffK";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 07/11] batctl: Import alfred version
	of debugfs.*
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3524657.DTFGMGlffK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 18, 2016 12:12:04 Sven Eckelmann wrote:
> The alfred version of debugfs.c and debugfs.h contains several cleanups
> regarding error message output, removal of unused declarations and usage of
> const buffers.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  debugfs.c | 17 ++++++++++-------
>  debugfs.h |  4 +---
>  2 files changed, 11 insertions(+), 10 deletions(-)

Applied in revision 23c3c6d.

Thanks,
Marek

--nextPart3524657.DTFGMGlffK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJXkeHjAAoJEFNVTo/uthzAWXcH9jLmnUr58ZOygQp0JiLL1HeL
7gTgf+llCLOQdtK24QILpTmkmsd1ADgaXH9A115llBN7MxM7w9lX0nvmJDq4X0jJ
h0QYfQjNFzU0AkMn3LpOtnJvNotZszIExsRehYDaWmiRdI/8jxuo8cD0LfslvJqx
ZGaqMAkdjc7OsnxaWk5sINpcXJHdDu+F7872zg+QFIVIdKFduMGuM6lVTNCqnrIr
+51/EUmJf0Xi/bq4ru3n1j3daNtV8h/Z8PLP7BaK0EXH/IAdlQCqaq9aG2U9XXVm
t/HhITyxb2vfk/30ykWgypJMc9otSs4ThSsS/F0Uz+0x4jpPVslBvohZFoKK0g==
=Rl21
-----END PGP SIGNATURE-----

--nextPart3524657.DTFGMGlffK--

