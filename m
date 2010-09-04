Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:19 +0200
Message-Id: <1283644718-653-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/21] Staging: batman-adv: Remove CHANGELOG
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

The changelog is only generated on standalone releases. Thus it has no
real value for the in-kernel version of batman-adv.

Reported-by: Abraham Arce <abraham.arce.moreno@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/CHANGELOG |   63 ----------------------------------
 1 files changed, 0 insertions(+), 63 deletions(-)
 delete mode 100644 drivers/staging/batman-adv/CHANGELOG

diff --git a/drivers/staging/batman-adv/CHANGELOG b/drivers/staging/batman-adv/CHANGELOG
deleted file mode 100644
index 86450b4..0000000
--- a/drivers/staging/batman-adv/CHANGELOG
+++ /dev/null
@@ -1,63 +0,0 @@
-batman-adv 2010.0.0:
-
-* support latest kernels (2.6.21 - 2.6.35)
-* further code refactoring and cleaning for coding style
-* move from procfs based configuration to sysfs
-* reorganized sequence number handling
-* limit queue lengths for batman and broadcast packets
-* many bugs (endless loop and rogue packets on shutdown, wrong tcpdump output,
-  missing frees in error situations, sleeps in atomic contexts) squashed
-
- -- Fri, 18 Jun 2010 21:34:26 +0200
-
-batman-adv 0.2.1:
-
-* support latest kernels (2.6.20 - 2.6.33)
-* receive packets directly using skbs, remove old sockets and threads
-* fix various regressions in the vis server
-* don't disable interrupts while sending
-* replace internal logging mechanism with standard kernel logging
-* move vis formats into userland, one general format remains in the kernel
-* allow MAC address to be set, correctly initialize them
-* code refactoring and cleaning for coding style
-* many bugs (null pointers, locking, hash iterators) squashed
-
- -- Sun, 21 Mar 2010 20:46:47 +0100
-
-batman-adv 0.2:
-
-* support latest kernels (2.6.20 - 2.6.31)
-* temporary routing loops / TTL code bug / ghost entries in originator table fixed
-* internal packet queue for packet aggregation & transmission retry (ARQ)
-  for payload broadcasts added
-* interface detection converted to event based handling to avoid timers
-* major linux coding style adjustments applied
-* all kernel version compatibility functions has been moved to compat.h
-* use random ethernet address generator from the kernel
-* /sys/module/batman_adv/version to export kernel module version
-* vis: secondary interface export for dot draw format + JSON output format added
-* many bugs (alignment issues, race conditions, deadlocks, etc) squashed
-
- -- Sat, 07 Nov 2009 15:44:31 +0100
-
-batman-adv 0.1:
-
-* support latest kernels (2.6.20 - 2.6.28)
-* LOTS of cleanup: locking, stack usage, memory leaks
-* Change Ethertype from 0x0842 to 0x4305
-  unregistered at IEEE, if you want to sponsor an official Ethertype ($2500)
-  please contact us
-
- -- Sun, 28 Dec 2008 00:44:31 +0100
-
-batman-adv 0.1-beta:
-
-* layer 2 meshing based on BATMAN TQ algorithm in kernelland
-* operates on any ethernet like interface
-* supports IPv4, IPv6, DHCP, etc
-* is controlled via /proc/net/batman-adv/
-* bridging via brctl is supported
-* interface watchdog (interfaces can be (de)activated dynamically)
-* offers integrated vis server which meshes/syncs with other vis servers in range
-
- -- Mon, 05 May 2008 14:10:04 +0200
-- 
1.7.1

