Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 18:32 +0800
Message-ID: <5897872.LvVFKCtQ2N@diderot>
In-Reply-To: <1419594103-10928-2-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-2-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart284196186.krGTJBaXP6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/26] batman-adv: debugfs,
	avoid compiling for !DEBUG_FS
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart284196186.krGTJBaXP6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:18 Markus Pargmann wrote:
> Normally the debugfs framework will return error pointer with -ENODEV
> for function calls when DEBUG_FS is not set.
> 
> batman does not notice this error code and continues trying to create
> debugfs files and executes more code. We can avoid this code execution
> by disabling compiling debugfs.c when DEBUG_FS is not set.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Makefile.kbuild |  2 +-
>  debugfs.c       |  8 --------
>  debugfs.h       | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 9 deletions(-)

Applied in revision fe67bb4.

Thanks,
Marek

--nextPart284196186.krGTJBaXP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUslEgAAoJEFNVTo/uthzAqTMH/2SJetviMhACxZ5HuG2gei6S
thYbOhWGcWyewlND6O6V+8oOHkEu9QC7ULhFaCJynHd0ZHwXKZGAxZiTKRqAiu/t
8dZp3ZCcexQbTYBTnYD5Pu0Y+aEa6nb1/Ry0Q0jzuN813iuwfBnH/YObvEm3xxzH
Ve9I3gZlU+/wpaJNAAIxpYDi5PChJQDzN6SwrcYi3AMoyGtVIOu67A+pL7es8c+K
TyJ9KWtZzkSPiB56slSnhv8Q+H+F9MwythNO3UJWx7Nf7LZI8ax3Ka0oTcOCAfcG
TrBNwEN91i7APklU+WhzHQNKI7A5D+E+T/mLVD0sh6oP4Ab5uL2lsgwR7/b0QqY=
=BTjz
-----END PGP SIGNATURE-----

--nextPart284196186.krGTJBaXP6--

