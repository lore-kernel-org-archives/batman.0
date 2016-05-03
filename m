Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 03 May 2016 10:59:07 +0200
Message-ID: <1894217.a7ufKNXfSr@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2013910.jjdKmsElY8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [v3] Add throughput meter support
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

--nextPart2013910.jjdKmsElY8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here is the third version of the throughput meter support. It is just a
rebased version of the patchset with two little bugfixes. Both problems were
detected and reported by Antonio:

 * batctl didn't check if the test_time is > 0 before doing a division
 * batman-adv wasn't returning an error to batctl when dst was not reachable


I am currently unsure how we should proceed regarding the ICMP packet type
used to communicate to the userspace ([PATCH 2/3]). Andrew+Matthias already
prepared a netlink patchset which looks quite good and which should be
tested+applied. The consequence for this patchset would be that patch 2 should
be completely dropped and instead the tp_meter should become its own command
in the netlink interface of batman-adv. Any opinions about that (order in
which patches should be applied/netlink interface should be handled) by the
Simon, Antonio, Marek, Matthias or Andrew?


Antonio Quartulli (4):
      batman-adv: return netdev status in the TX path
      batman-adv: use another ICMP packet when sending command from userspace
      batman-adv: throughput meter implementation
      batctl: introduce throughput meter support

 net/batman-adv/Makefile         |    1 +
 net/batman-adv/fragmentation.c  |   41 +-
 net/batman-adv/fragmentation.h  |    6 +-
 net/batman-adv/icmp_socket.c    |  225 +++---
 net/batman-adv/icmp_socket.h    |    5 +-
 net/batman-adv/main.c           |    6 +-
 net/batman-adv/main.h           |   24 +-
 net/batman-adv/packet.h         |  120 ++++
 net/batman-adv/routing.c        |   33 +-
 net/batman-adv/send.c           |   25 +-
 net/batman-adv/soft-interface.c |    2 +
 net/batman-adv/tp_meter.c       | 1453 +++++++++++++++++++++++++++++++++++++++
 net/batman-adv/tp_meter.h       |   34 +
 net/batman-adv/types.h          |  113 +++
 14 files changed, 1944 insertions(+), 144 deletions(-)

 Makefile     |   2 +-
 main.c       |   6 ++
 main.h       |   1 +
 man/batctl.8 |  24 +++++-
 packet.h     | 120 ++++++++++++++++++++++++++++++
 tcpdump.c    |  14 +++-
 tp_meter.c   | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tp_meter.h   |  22 ++++++
 8 files changed, 421 insertions(+), 4 deletions(-)


Kind regards,
	Sven
--nextPart2013910.jjdKmsElY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKGhbAAoJEF2HCgfBJntGYKgQAIcDaILzNsjj3aLOXdyXfF1x
k5c5bnqveEebWgFMa2en89rU0O+CuiWP2of3ukM5+qNpNH/0WbuJVvtB8dozOM6e
5jnYX7aL1amzoVdalCHP76q/P3pX2AczelYKFW/E5Hpv2GGg0g3pf01Ai+k7z+Uq
5pdEdWFqRN5bTZUIsa1Y7Pu6w14hZYgZdltnYckfjec69fnVeNvEJG0sHwLUvyZI
xi1fBtNuOwB+DxdIYScQxBSWGsrPNCrEVNPjrzMtvAn7B53+z5A6SJzIgDock7yv
wON62oht7NjRtnmEv/3BtRWqj96v+hD8DCCmylTOXVdGUkBoVSyYQxw9+iLLLxvJ
AeCorPCzjd05l/D4w9uh+FGievrXIlYVg2vmZcXK9fGlppvnuUrwILxOBM58Vkr+
9ku54+b80sEv53RVYgOO5p8E5+1YbiBZZK1lQUBo+ereqnSRVuQc8G7ypnwI8+/w
moz8aNXgtIeAZq/P5W1YwnA5TPwGBFlFD53Cg94tyLo2UeofwbJu0E8zHOWUqzlq
L0uyJ8SpmEaIe1Bqqz//Y+qFz43EIMIKyHM7nvPaX9djL9nKvHSHq6U2ZITFxNeX
GPUR2KMs+YslZkvqJNjiwUPHSvpM+gG9WpFWbKnV6+rXA6uFmpqtn2dXw+7TioeS
3XDQ0EQnLm+xx7K9xrWU
=lI50
-----END PGP SIGNATURE-----

--nextPart2013910.jjdKmsElY8--

