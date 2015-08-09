Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Aug 2015 08:20:37 +0800
Message-ID: <2099688.GgYGYm6FHi@voltaire>
In-Reply-To: <1438992110-30581-1-git-send-email-sw@simonwunderlich.de>
References: <1438992110-30581-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1448367.3UeP00I20X";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: rename equiv/equal or
	better to similar or better
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


--nextPart1448367.3UeP00I20X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 08, 2015 02:01:50 Simon Wunderlich wrote:
> Since the function applies a threshold and also slightly worse
> values are accepted, ''equal or better'' does not represent the
> intention of the function. ''Similar or better'' represents that better.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
> Changes to PATCH:
>  * rebase on current master
> ---
>  net/batman-adv/bat_iv_ogm.c | 8 ++++----
>  net/batman-adv/main.c       | 2 +-
>  net/batman-adv/routing.c    | 6 +++---
>  net/batman-adv/types.h      | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)

Applied in revision 81e457e.

Thanks,
Marek

--nextPart1448367.3UeP00I20X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxpzZAAoJEFNVTo/uthzAe5MH/Auu3PNXafwPZSBdQr5gkN6C
SiRNsitrqr0MWHOHGi7A+SFxy24NkPjF6TBaSJlHF0zX3aVfKRwd2THTH+UvvdRm
Av0QeyC7oKzj17YMlLYSDaO+BGOKu9MP6IspXb8NM3LT2iGOMBnRDDZxLKhiJD7b
N8R02Mda4gTqbeflMy7JvmbftPvD2AQlsMY478PLe7+VEAQFZQp1Wf8U41NZFpPY
1nffGlRgMp8p+6NlbdjZHUOAjUG8SNaU4JUEaKIskZuLZ+qlFxbkwseugXaM/YpN
3M/lAoe3mfzy8BPxn2IT9HiS6RT16J+eeaIoC/59l4UoGgJpqSWMv3uk6Jbp+cE=
=pGvs
-----END PGP SIGNATURE-----

--nextPart1448367.3UeP00I20X--

