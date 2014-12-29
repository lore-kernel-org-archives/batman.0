Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 29 Dec 2014 11:55:21 +0800
Message-ID: <2801975.TCvzZFZTUf@diderot>
In-Reply-To: <1413741581-20407-1-git-send-email-antonio@meshcoding.com>
References: <1413741581-20407-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1627905.BKCDkfUhXO";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move misplaced compat code
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


--nextPart1627905.BKCDkfUhXO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 19 October 2014 19:59:41 Antonio Quartulli wrote:
> consume_skb() has to be re-defined only for kernels <2.6.30
> but the macro was accidentally placed right above any #ifdef
> block causing the function to be always redefined.
> 
> Fix this by moving the macro to the proper #ifdef block.
> 
> Introduced by: 15fb0fab51a3695738f65dfaab045e979fc89dce
> ("batman-adv add compat code for consume_skb")
> 
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision b609f26.

Thanks,
Marek
 
--nextPart1627905.BKCDkfUhXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUoNCpAAoJEFNVTo/uthzA1vYIAMVoXrHqzA9E7GkhESTJklDh
adCHldM8eldbODPvQtDNIJrPdxfn4krDPpXl1RW39z/qiVgaQxVWoN+zPc7g8Gar
JjCE1DkISj5OTc0r7N9ta4t2yzsqBxVZGRdpoI1eaHkPddePH1Ae6NYnPS6d6zl2
PNVcsfHhXvZcI9UDT1PiGXK221Y9dXmKkCyMh/0GXxGxHcUDHVeGsvFPsnw54nb+
FqBSruMqtOCFXP68xzR6iAy7IZolCptZV0IVm4aAmXiAEeLlkt88cKmDrKMVE+iT
S2AhM/byVyE0fUwmz/QzxxuXJQibu9ycDcCyRYQnfEzqcS8Rw3jrasPE4Uhmir0=
=oaiY
-----END PGP SIGNATURE-----

--nextPart1627905.BKCDkfUhXO--

