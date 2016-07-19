Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:40:26 +0800
Message-ID: <1631793.Z2QaUxcbWW@voltaire>
In-Reply-To: <1468597173-25378-13-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-13-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27716900.mqGHKUm8Xp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 13/18] batman-adv: Place kref_get for
	hard_iface near use
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

--nextPart27716900.mqGHKUm8Xp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:28 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/hard-interface.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied in revision a1ca984.

Thanks,
Marek

--nextPart27716900.mqGHKUm8Xp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjed6AAoJEFNVTo/uthzAuxAIALyeMt2j3cyn2ahvJ3m1bMPX
2xu8/rWPrqPPUgYfzQ59z7ZB/prD/pXXDrZQU4nhuDRZcOH4mKWg7+PTs11N48UO
mGV8nxz+WH/3nI/n/3nOiAJ11/l75eZll3kvxjWHOCwM38ZIAwxfDP0kdMg5dMlG
yxqlCeNJ/c7VIZrtQXcz5AXMhAIv/eY+oQWGfrkpDsrwdsQ5xgrap+TYAP0cxo6n
DbI3BX9PAlz2OU/yQKoeF6IXdRcS6oKedeUd9dHpbJZEYAWmHv7/PRA48doa92KQ
apnqVqQ0m8n7Od1Rb2RwCuiDFYoat5ck+s+xH5SkZdWUCW3SugnSXClLTfxMaRI=
=jFhT
-----END PGP SIGNATURE-----

--nextPart27716900.mqGHKUm8Xp--

