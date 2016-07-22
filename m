Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:20:21 +0800
Message-ID: <3302974.2EJeEjFU03@voltaire>
In-Reply-To: <1468654280-10200-1-git-send-email-sven@narfation.org>
References: <1468654280-10200-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1547952.ABqnm3e3aS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Allow to disable debugfs
	support
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

--nextPart1547952.ABqnm3e3aS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, July 16, 2016 09:31:20 Sven Eckelmann wrote:
> The files provided by batman-adv via debugfs are currently converted to
> netlink. Tools which are not yet converted to use the netlink interface may
> still rely on the old debugfs files. But systems which already upgraded
> their tools can save some space by disabling this feature. The default
> configuration of batman-adv on amd64 can reduce the size of the module by
> around 11% when this feature is disabled.
> 
>     $ size net/batman-adv/batman-adv.ko*
>        text    data     bss     dec     hex filename
>      150507   10395    4160  165062   284c6 net/batman-adv/batman-adv.ko.y
>      137106    7099    2112  146317   23b8d net/batman-adv/batman-adv.ko.n
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - remove bogus "Before:" line in commit message
> 
>  Makefile                               |  3 +++
>  README.external                        |  1 +
>  compat.h                               |  5 +++++
>  gen-compat-autoconf.sh                 |  1 +
>  net/batman-adv/Kconfig                 | 15 +++++++++++++--
>  net/batman-adv/Makefile                |  4 ++--
>  net/batman-adv/bat_algo.c              |  2 ++
>  net/batman-adv/bat_iv_ogm.c            | 12 ++++++++++++
>  net/batman-adv/bat_v.c                 | 12 ++++++++++++
>  net/batman-adv/bridge_loop_avoidance.c |  4 ++++
>  net/batman-adv/debugfs.h               |  2 +-
>  net/batman-adv/distributed-arp-table.c |  2 ++
>  net/batman-adv/gateway_client.c        |  2 ++
>  net/batman-adv/icmp_socket.h           | 18 +++++++++++++++++-
>  net/batman-adv/main.c                  |  2 ++
>  net/batman-adv/multicast.c             |  2 ++
>  net/batman-adv/network-coding.c        |  2 ++
>  net/batman-adv/originator.c            |  4 ++++
>  net/batman-adv/translation-table.c     |  4 ++++
>  net/batman-adv/types.h                 |  6 ++++++
>  20 files changed, 97 insertions(+), 6 deletions(-)

Applied in revision 4f47cce.

Thanks,
Marek

--nextPart1547952.ABqnm3e3aS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkeVVAAoJEFNVTo/uthzAuswH/2JyPhdlykfXMcZFiA0/HBFB
6UyzQDyVFlUuPoF6HKuvkNWXNfUxAQkNspBKoEXmNULQSRVSUfYeANkUAJfSq4Pl
mI7/BjKFlmw8JOSzXmA77QABFcDu5xwRGbdutgFEb7oLEvZ0OoB0JrE6fY5M+vDn
fs04vXR4xK4Mgh6N+Ob9v49ylbD9Rp7+wJILUkxzTqnDaV6J7eDSu3lDQHefb6Bo
S74thtc6zf09TbuU7zt/Cgwp1mz7KfT1ObPT5Krg+HkJQ8H9YtUHDarKImInANcV
i6DL4FR7zW1fPCT8LPirL/2pSn2isQISSU+irdhEBmn7eAtaMCc+JiEmdUMI4ew=
=pMTt
-----END PGP SIGNATURE-----

--nextPart1547952.ABqnm3e3aS--

