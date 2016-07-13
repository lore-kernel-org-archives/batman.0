Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 Jul 2016 17:29:35 +0200
Message-ID: <35819279.yt4EnXKmx6@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16882499.gtkxEW1JNn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/7] batctl: rtnetlink interface manipulation
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

--nextPart16882499.gtkxEW1JNn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

the sysfs file mesh_iface to add/remove interfaces to/from a batman-adv
soft-interface was downgraded in batman-adv master to a second-class citizen.
This was done because it has conceptional problems (for example locking of 
sysfs vs. locking of the network core code). The only direct way to modify 
interfaces is rtnetlink which is used by different tools like iproute2 (ip 
link, ip addr, ...) or netifd. sysfs still exists but has to use workers which 
delay the actual add/del to a later point.

This patchset now moves batctl to rtnetlink instead of the sysfs-file 
mesh_iface. This should work fine since this is supported by batman-adv (in 
Linux) since Linux v3.10 (batman-adv v2013.2).

This patchset also introduces two new interface subcommands called "new" and 
"destroy". "new" can be used to create a batman-adv interface without any 
interface attached. This is helpful when the interfaces should be configured 
independently of the first attached interface. The command "destroy" can be 
used to destroy a batman-adv interface without going through all attached 
interfaces and delete them manually.

It is now also possible to tell batctl to not automatically create a
batman-adv interface when an interface is attached. But more important is this 
option to disable the automatic removal of a batman-adv interface when all 
attached interfaces were removed. This is useful when a number of interfaces 
should be added/removed without accidentally loosing the current configuration 
of the interface. Of course, we should also accept the related patch for 
batman-adv [1].

I've also added two patches with some minor cleanup because it was dealing 
with code in the same file with similar context.

This patchset is build on top of the netlink patchset currently waiting to be 
applied.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/16499/


Sven Eckelmann (7):
  batctl: Use rtnl to query list of softif devices
  batctl: Add command to create/destroy batman-adv interface
  batctl: Use rtnl to add/remove interfaces
  batctl: Parse interface arguments relative to last parsed option
  batctl: Allow to disable automatic interface new/destroy
  batctl: Move interface command to extra file
  batctl: Move check_mesh_iface* to functions.c

 Makefile     |   1 +
 functions.c  | 181 +++++++++++++++++++++++
 functions.h  |  10 +-
 interface.c  | 457 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 interface.h  |  29 ++++
 main.c       |   1 +
 man/batctl.8 |   7 +-
 sys.c        | 215 +---------------------------
 sys.h        |   3 -
 9 files changed, 690 insertions(+), 214 deletions(-)
 create mode 100644 interface.c
 create mode 100644 interface.h

-- 
2.8.1


--nextPart16882499.gtkxEW1JNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXhl5fAAoJEF2HCgfBJntGcP8P/2UZoSP1z1FShGl8dT2K9QIU
bg4h6CCtJiVl2Rx3HM2NckJNHVpCCsAdqzwN2u4uYGYcTsG3PDy46C2/w34iREZR
kZNERGz4cqmWCuuRD0iaEbUCh3x4W/GYG35048fqlVUjjIuak8rdSBV9zTf58zMO
ercTUPKp9kHp0KiisCq1LMeO30sM4ymRiBQru+Bwp+4BUG/oswpSr5hdcSuACc2+
IX8qwy+KRY6GjIPl1qbRhAVX96ZqCNJjR8oz5SvxAN+0+xzJOtvvZP8StB/b0Lpy
gAjjRd54KWat04n3WGpwuFj8w5psYNmpINuKIo6LW7LNgvmwKEwDuOWFhpgThneB
m7uN1JbpjOi+dBkVkiGt/EMimCGTVVb1wcxdmlLT3iwZF1Qpbi+FxnVTD3F5LpBW
2/Vm4VHaJPhjjVKBfKcg1PEFpfkfXYQ6CM4JJ/Cwwq8yeYqZI2o7In6g6Kg1x7Pd
+X1Z9TnqOmHi7z/xmghWpcMgSNY/gtRbtTauZHGTVlgPZQWJVk+kqpv8Sc84t9Ax
wJqHKGvRm8BRfw2Qj3gXrAWiQlSLh1vH0JP870WDnygxVCUmoc2ISIQdNgJf+tsE
g/aJplc1QAdlbbs0hlNhYxSPyB5cc/D+xYrDt80tAx8z9geFV40Ti2rsrGgrTA2m
SadcVgQ6LzrOCs0T6RC7
=pztz
-----END PGP SIGNATURE-----

--nextPart16882499.gtkxEW1JNn--

