Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 22:43:26 +0200
Message-ID: <3501586.3dVhjbZHzy@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15631304.gpuOpFT0Vp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/4] batctl: Userspace batadv_icmp endpoints
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

--nextPart15631304.gpuOpFT0Vp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

The current endpoint for batadv_icmp* is implemented in the kernel module and 
can be accessed via debugfs. But the debugfs cannot be accessed from non-
default netns or when debugfs is disabled. Thus it has be possible to use it 
via the netlink infrastructure to make it compatible with future
setups.

The use of the socket file is completely removed and instead raw sockets with 
BPF filters are used to send/receive batadv_icmp_packet* directly. All 
information about interfaces and available originators are received via
rtnetlink and the batman-adv netlink.

The originators debugfs file is used when the batman-adv netlink commands are 
not available. The routing of batadv_icmp_packets is still done inside the 
kernel module.

The patchset is based on the netlink and rtnl patchset for batctl.

Kind regards,
	Sven

Sven Eckelmann (4):
  batctl: Replace list implementation with linux-like-list
  batctl: Use monotonic time source for icmp timing
  batctl: Add helper to generate instant random bytes
  batctl: Implement non-routing batadv_icmp in userspace

 Makefile      |   4 +-
 bisect_iv.c   |  40 ++-
 bisect_iv.h   |  10 +-
 functions.c   |  82 +++++-
 functions.h   |   2 +
 icmp_helper.c | 633 ++++++++++++++++++++++++++++++++++++++++++++
 icmp_helper.h |  58 ++++
 list-batman.c | 123 ---------
 list-batman.h | 120 ---------
 list.h        | 834 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c     | 178 ++++++++++++-
 netlink.h     |   3 +
 ping.c        |  42 +--
 tcpdump.c     |   7 +-
 tcpdump.h     |   2 +-
 traceroute.c  |  42 +--
 16 files changed, 1832 insertions(+), 348 deletions(-)
 create mode 100644 icmp_helper.c
 create mode 100644 icmp_helper.h
 delete mode 100644 list-batman.c
 delete mode 100644 list-batman.h
 create mode 100644 list.h
--nextPart15631304.gpuOpFT0Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXjpDuAAoJEF2HCgfBJntGmKsP/2Xd/LNljFslZJF36ExdVV/0
z5tqz6Hds8IdLtOEel92LWYtDJTQBWDR1MtG7H3vir8aI3N6r9vvGlbqP3O1kbyD
8i/VdxB4fbmeSxxlZ0rY3UjtNbO81MJRJ+uClI82qoYoc/9KC38X+iTGVKgtRUS+
lGyDcLqpyT+0PNU2JMDtTI+ocf9nc5NfvE/RPWL4mS1z1ILDvPbcjXYM3xbxQEF4
aykTHZ5YY7Fgq7KyBiDi2Zs76xvRwnf3flUYINo3/9qPIpr5jo7OFIq17PP8vD5H
8qiP25OgVOm5eD4yF5H6GGf5PbqQowYQT99VS/wTWTlNUHHDN3lnN+UWWM7nq9Se
+cMABCwrFtVkDFwzXbGHQrPdWgmoVenxqZXubDqUi+veyVXG78HGb+nxXhsusgj8
fQXRpkISmDgLPGd2WarK4dJMXupTh96gItlG7meKpLdtknrqu1lqcG5hQNHuaov/
futIahv37OQt+uYJlDiV8kENzSISae7avRjL06NHIQlDUjnLeGE0hgRSUsQrvklG
FZ4qdxhmZFDizGp0zr0ANeyTZt9B+DPcnGkIkKIqw/mlV12rOBjG/93F56jETeXa
FA9ZUT/7lGmplH3QcJRwj5mhWDYNYFfByJ7Q36fYjS+B9HQiCRIxW4Y20IWOzrPV
6vmmhma07haynlpB1jQ3
=07J+
-----END PGP SIGNATURE-----

--nextPart15631304.gpuOpFT0Vp--

