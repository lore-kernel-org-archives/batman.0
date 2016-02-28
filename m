Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 08:33:06 +0800
Message-ID: <13742891.BYD5Djd9JL@voltaire>
In-Reply-To: <1456171359-19330-1-git-send-email-sven@narfation.org>
References: <1456171359-19330-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2103101.NZMhGvLV6s";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use bool as return type for
	boolean functions
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
Cc: Nicholas Krause <xerofoify@gmail.com>

--nextPart2103101.NZMhGvLV6s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 22, 2016 21:02:39 Sven Eckelmann wrote:
> It is easier to understand that the returned value of a specific function
> doesn't have to be 0 when the functions was successful when the actual
> return type is bool. This is especially true when all surrounding functions
> with return type int use negative values to return the error code.
> 
> Reported-by: Nicholas Krause <xerofoify@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c            |  23 ++---
>  net/batman-adv/bitarray.c              |  16 +--
>  net/batman-adv/bitarray.h              |  14 +--
>  net/batman-adv/bridge_loop_avoidance.c | 175
> +++++++++++++++++---------------- net/batman-adv/bridge_loop_avoidance.h
> |  43 ++++----
>  net/batman-adv/debugfs.c               |   2 +-
>  net/batman-adv/distributed-arp-table.c |   6 +-
>  net/batman-adv/hard-interface.c        |  15 ++-
>  net/batman-adv/hash.h                  |   6 +-
>  net/batman-adv/main.h                  |   2 +-
>  net/batman-adv/network-coding.c        |  12 +--
>  net/batman-adv/originator.c            |   4 +-
>  net/batman-adv/originator.h            |   2 +-
>  net/batman-adv/routing.c               |  37 +++----
>  net/batman-adv/routing.h               |   6 +-
>  net/batman-adv/soft-interface.c        |   6 +-
>  net/batman-adv/soft-interface.h        |   2 +-
>  net/batman-adv/translation-table.c     |  31 +++---
>  18 files changed, 203 insertions(+), 199 deletions(-)

Applied in revision d58a135.

Thanks,
Marek

--nextPart2103101.NZMhGvLV6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0kBCAAoJEFNVTo/uthzAodYIAKyVSd3VRPrnzqqTZKo5IoBb
2z+SHfbn/HsE5773GGEmQU5v39QqE7mddT6TmjrgoErZ8QztAXnHwTEVKfZuh3tc
ROrT/FGvuLHuXNsNBDdpSPwvwz17hAWn/vhB5IhjroMTKJa0NTuitVwYTxOGVxrA
7w/h3YMTamNfLwrJJCpmNYwfFbf4UwaBXfM7Of6b8df8yCgfqPmmMnK0KK28HDku
oysx05HSIILjJG5P4kbJAw5S3aq4YZhmVwoGyQbcDUpdgxWBv5hhzFOLgeKsN6o2
h25aUClat8N6bD12jnr8cI4OVl8h/g313J9jZZ1x/TmCqhqWrDY8c81+hmVzz/o=
=6r2O
-----END PGP SIGNATURE-----

--nextPart2103101.NZMhGvLV6s--

