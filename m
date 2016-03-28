Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:47:33 +0800
Message-ID: <8339685.Z4BTEJU6c5@voltaire>
In-Reply-To: <1457710579-4028-1-git-send-email-sven@narfation.org>
References: <1457710579-4028-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2943422.J4UkDqZhER";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: fix wrong names in
	kerneldoc
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2943422.J4UkDqZhER
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 11, 2016 16:36:19 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> [sven@narfation.org: Fix additional names]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - add 11 more name fixes for kernel-doc
> 
> Antonio wanted to resend this patch himself [1] but this didn't happen until
> now.
> 
> [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014624.html
> 
> 
>  net/batman-adv/bridge_loop_avoidance.c |  2 +-
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/icmp_socket.c           |  2 +-
>  net/batman-adv/main.h                  |  3 ++-
>  net/batman-adv/multicast.c             | 11 ++++++-----
>  net/batman-adv/originator.c            |  2 +-
>  net/batman-adv/packet.h                |  2 +-
>  net/batman-adv/soft-interface.c        |  2 +-
>  8 files changed, 14 insertions(+), 12 deletions(-)

Applied in revision a9ef3d7.

Thanks,
Marek

--nextPart2943422.J4UkDqZhER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+UQFAAoJEFNVTo/uthzAG0QH/iJphkMbO+Gq5TQnzMchuyBk
zFhZiGdjgKXsJfzsy5qu4uWVDNpyQU3I56a0qFsgXX7Flvb63Se6KQGOlDJk/pxW
mFu/AOc3ts9C6zjXm/gP1sTTEAln+eT5B+aCOivEUEFQNEEjDLSQGRq/Ksbbzylw
p/IBVNLt9sQ5uTUBZQ31hHZYdk4ciuqlYlIuJvTGrE7DrRwFMxAF1f3fqCmPFxye
fPrZU0PFjjDxaAF8gqt+LSbL+VK9f5/SDZa1ryH0MEGhgrymEUpGY1eIQVEtQZSN
wgm17bXuypdBinBIeRtQRBCEzNiyzOBcXhJNWsOIAgqwzRwKc8yregOSsEx29HI=
=5o2t
-----END PGP SIGNATURE-----

--nextPart2943422.J4UkDqZhER--

