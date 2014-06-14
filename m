Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Jun 2014 09:58:25 +0800
Message-ID: <1917973.ys7ndg4BNi@diderot>
In-Reply-To: <1402651634-30966-1-git-send-email-antonio@meshcoding.com>
References: <1402651634-30966-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3302197.4jKEChVbdH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: add __pskb_copy_fclone and
	pskb_copy_for_clone
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


--nextPart3302197.4jKEChVbdH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 13 June 2014 11:27:14 Antonio Quartulli wrote:
> From: Octavian Purdila <octavian.purdila@intel.com>
> 
> There are several instances where a pskb_copy or __pskb_copy is
> immediately followed by an skb_clone.
> 
> Add a couple of new functions to allow the copy skb to be allocated
> from the fclone cache and thus speed up subsequent skb_clone calls.
> 
> Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <antonio@meshcoding.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Arvid Brodin <arvid.brodin@alten.se>
> Cc: Patrick McHardy <kaber@trash.net>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
> Cc: Lauro Ramos Venancio <lauro.venancio@openbossa.org>
> Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Jon Maloy <jon.maloy@ericsson.com>
> Cc: Allan Stephens <allan.stephens@windriver.com>
> Cc: Andrew Hendry <andrew.hendry@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Christoph Paasch <christoph.paasch@uclouvain.be>
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  compat.h                | 6 ++++++
>  distributed-arp-table.c | 2 +-
>  network-coding.c        | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Applied in revision 8c12d63.

Thanks,
Marek

--nextPart3302197.4jKEChVbdH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTm6xBAAoJEFNVTo/uthzAha8IAKGoPOY9TCPGxO4l5SFhiARb
rYai/kcVQN+7SPfUzMuDyum6rv//z3d0ZFI+wUBD2rDiWCA4kT8TFd6hsqywttaC
wSd1IcpCEap6390w8UqYjxcj3cdGkIRUDfzSg5oCnX9U4LtLk00JfvlJRwUIKBA9
GNbBCWWKHdD9Lkr9OOin3xPlOUoNJ9KfHQfG6wy05wjeYVhOgQ6E2je76t2LvGD/
+RiuVarMPgD8+2xTQPIF8qhT8nWVZ5rLih5NY7Cuk0sb0lTqItLhAx8Kcp5kc97h
uYht8R+oRcuke+LntT2kZXLcdL8aBuIge9PMrISu8+ykgEq+KhSN7tTqmREi0LE=
=GYB6
-----END PGP SIGNATURE-----

--nextPart3302197.4jKEChVbdH--

