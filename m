Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 06 Jan 2016 23:52:35 +0800
Message-ID: <1846260.pI3VqTvhtB@voltaire>
In-Reply-To: <1451602863-23358-1-git-send-email-sven@narfation.org>
References: <1451602863-23358-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3979501.GEb9j9kSxn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: update copyright years for
	2016
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

--nextPart3979501.GEb9j9kSxn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, January 01, 2016 00:01:03 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile                               | 2 +-
>  compat-include/linux/atomic.h          | 2 +-
>  compat-include/linux/bug.h             | 2 +-
>  compat-include/linux/compiler.h        | 2 +-
>  compat-include/linux/etherdevice.h     | 2 +-
>  compat-include/linux/export.h          | 2 +-
>  compat-include/linux/if_ether.h        | 2 +-
>  compat-include/linux/if_vlan.h         | 2 +-
>  compat-include/linux/kconfig.h         | 2 +-
>  compat-include/linux/kernel.h          | 2 +-
>  compat-include/linux/list.h            | 2 +-
>  compat-include/linux/lockdep.h         | 2 +-
>  compat-include/linux/moduleparam.h     | 2 +-
>  compat-include/linux/net.h             | 2 +-
>  compat-include/linux/netdev_features.h | 2 +-
>  compat-include/linux/netdevice.h       | 2 +-
>  compat-include/linux/percpu.h          | 2 +-
>  compat-include/linux/printk.h          | 2 +-
>  compat-include/linux/random.h          | 2 +-
>  compat-include/linux/rculist.h         | 2 +-
>  compat-include/linux/rcupdate.h        | 2 +-
>  compat-include/linux/seq_file.h        | 2 +-
>  compat-include/linux/skbuff.h          | 2 +-
>  compat-include/linux/slab.h            | 2 +-
>  compat.h                               | 2 +-
>  net/batman-adv/Makefile                | 2 +-
>  net/batman-adv/bat_algo.h              | 2 +-
>  net/batman-adv/bat_iv_ogm.c            | 2 +-
>  net/batman-adv/bitarray.c              | 2 +-
>  net/batman-adv/bitarray.h              | 2 +-
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  net/batman-adv/bridge_loop_avoidance.h | 2 +-
>  net/batman-adv/debugfs.c               | 2 +-
>  net/batman-adv/debugfs.h               | 2 +-
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/distributed-arp-table.h | 2 +-
>  net/batman-adv/fragmentation.c         | 2 +-
>  net/batman-adv/fragmentation.h         | 2 +-
>  net/batman-adv/gateway_client.c        | 2 +-
>  net/batman-adv/gateway_client.h        | 2 +-
>  net/batman-adv/gateway_common.c        | 2 +-
>  net/batman-adv/gateway_common.h        | 2 +-
>  net/batman-adv/hard-interface.c        | 2 +-
>  net/batman-adv/hard-interface.h        | 2 +-
>  net/batman-adv/hash.c                  | 2 +-
>  net/batman-adv/hash.h                  | 2 +-
>  net/batman-adv/icmp_socket.c           | 2 +-
>  net/batman-adv/icmp_socket.h           | 2 +-
>  net/batman-adv/main.c                  | 2 +-
>  net/batman-adv/main.h                  | 2 +-
>  net/batman-adv/multicast.c             | 2 +-
>  net/batman-adv/multicast.h             | 2 +-
>  net/batman-adv/network-coding.c        | 2 +-
>  net/batman-adv/network-coding.h        | 2 +-
>  net/batman-adv/originator.c            | 2 +-
>  net/batman-adv/originator.h            | 2 +-
>  net/batman-adv/packet.h                | 2 +-
>  net/batman-adv/routing.c               | 2 +-
>  net/batman-adv/routing.h               | 2 +-
>  net/batman-adv/send.c                  | 2 +-
>  net/batman-adv/send.h                  | 2 +-
>  net/batman-adv/soft-interface.c        | 2 +-
>  net/batman-adv/soft-interface.h        | 2 +-
>  net/batman-adv/sysfs.c                 | 2 +-
>  net/batman-adv/sysfs.h                 | 2 +-
>  net/batman-adv/translation-table.c     | 2 +-
>  net/batman-adv/translation-table.h     | 2 +-
>  net/batman-adv/types.h                 | 2 +-
>  68 files changed, 68 insertions(+), 68 deletions(-)

Applied in revision ee0e93f.

Thanks,
Marek

--nextPart3979501.GEb9j9kSxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjThDAAoJEFNVTo/uthzAjC4IAKXRy46LoT5rcpG98TCW7EDD
j7biaoLsAlZE6HL3RbOin0D4Y3rH90Nbi9S0HEpJSJz4Sl/iwIlNPawYP4LZvx1B
2t+eUoCmjm9+gRLq7Oh2iLhQw/+mSQNvzU8jPgNoMeL2cevFTEoeRODuUsuZ0L6x
UJNdaD4DBt4RZVDhY0a6k3A6jwKlONu47xfz1x2EvSq7X2l+SjsQJS2PcTumZjuQ
Zsz5aSnYM+8SlcHlJt//q0AeJTUJTkH65Tx0XWg1MgkIcFNug7J8a56zfDZyt3CE
icjnkjMIlm1U3StrE2j8VPy13VxVrjQ9Z5K8eBRgOOuDVBBTVbI5LpfgCrrGMdY=
=Tg0P
-----END PGP SIGNATURE-----

--nextPart3979501.GEb9j9kSxn--

