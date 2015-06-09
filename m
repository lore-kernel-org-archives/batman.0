Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 09 Jun 2015 22:25:58 +0800
Message-ID: <3182681.oEdO8Enil5@voltaire>
In-Reply-To: <1432658067-14370-1-git-send-email-sven@narfation.org>
References: <1432658067-14370-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1825574.smAUXDKahB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Replace C99 int types
	with kernel type
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


--nextPart1825574.smAUXDKahB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 26, 2015 18:34:26 Sven Eckelmann wrote:
> (s|u)(8|16|32|64) are the preferred types in the kernel. The use of the
> standard C99 types u?int(8|16|32|64)_t are objected by some people and even
> checkpatch now warns about using them.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat-include/linux/kernel.h          |   2 +-
>  compat-include/linux/percpu.h          |   2 +-
>  net/batman-adv/bat_iv_ogm.c            |  94 +++++++-------
>  net/batman-adv/bitarray.c              |   6 +-
>  net/batman-adv/bitarray.h              |  10 +-
>  net/batman-adv/bridge_loop_avoidance.c |  72 ++++++-----
>  net/batman-adv/bridge_loop_avoidance.h |   5 +-
>  net/batman-adv/distributed-arp-table.c |  59 +++++----
>  net/batman-adv/distributed-arp-table.h |   8 +-
>  net/batman-adv/fragmentation.c         |  10 +-
>  net/batman-adv/gateway_client.c        |  16 +--
>  net/batman-adv/gateway_client.h        |   2 +-
>  net/batman-adv/gateway_common.c        |  11 +-
>  net/batman-adv/hash.c                  |   6 +-
>  net/batman-adv/hash.h                  |  12 +-
>  net/batman-adv/icmp_socket.c           |   2 +-
>  net/batman-adv/main.c                  |  69 +++++-----
>  net/batman-adv/main.h                  |  48 ++++---
>  net/batman-adv/multicast.c             |  16 +--
>  net/batman-adv/network-coding.c        |  44 ++++---
>  net/batman-adv/originator.c            |  15 ++-
>  net/batman-adv/originator.h            |  11 +-
>  net/batman-adv/packet.h                | 204 +++++++++++++++---------------
> net/batman-adv/routing.c               |  24 ++--
>  net/batman-adv/routing.h               |   2 +-
>  net/batman-adv/send.c                  |   8 +-
>  net/batman-adv/send.h                  |   8 +-
>  net/batman-adv/soft-interface.c        |  26 ++--
>  net/batman-adv/sysfs.c                 |   4 +-
>  net/batman-adv/translation-table.c     | 224
> ++++++++++++++++-----------------
> net/batman-adv/translation-table.h     |  29 +++--
>  net/batman-adv/types.h                 | 109 ++++++++--------
>  32 files changed, 568 insertions(+), 590 deletions(-)

Applied in revision dc0e68b.

Thanks,
Marek

--nextPart1825574.smAUXDKahB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVdvd6AAoJEFNVTo/uthzA8DIIAJzZPjRxAGaX62030MOFyT67
tyTkKfI/hM6A9JEuXZtCICsP7h09YmgqNG8wWa6gKEFLcMTe78Grr4lfdiawku88
Cg2pf6tJWnj0xK9IVFCr2+BzDOEIcAmn0DirbIIeTcFXmms0wHLERlsfwZHxT3zP
gdFQ+I49XsddX7oRZi6zhs0IX/M+jFkj4XhUqkHMsrbR9bJj/05lpw8Wx6zv7uGI
+xiEo7gWfynxy97O8AnMwD+JRYfm21KBz8QzcOaS1xuXvPaALSHFFeCJmTum8fue
KcHoHNyzemLsXz37torIEye2UXBJ6CNY+7Nu7VnTXz7JqHx2G6KUfjB3PlZXA/M=
=LSyA
-----END PGP SIGNATURE-----

--nextPart1825574.smAUXDKahB--

