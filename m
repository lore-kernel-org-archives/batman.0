Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  1 May 2010 15:10:07 +0200
Message-Id: <1272719410-406-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-1-git-send-email-andrew@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Update README to match
	mainline README.
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
To: lindner_marek@yahoo.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 README |   35 +++++++++--------------------------
 1 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/README b/README
index 4c2a6c6..e2a7271 100644
--- a/README
+++ b/README
@@ -15,19 +15,6 @@ above B.A.T.M.A.N. Advanced, prominent examples are: IPv4, IPv6, DHCP, IPX.
 This is batman-advanced implemented as Linux kernel driver. It does not depend
 on any network (other) driver, and can be used on wifi as well as ethernet,
 vpn, etc ... (anything with ethernet-style layer 2).
-It compiles against and should work with Linux 2.6.20 - 2.6.33. Supporting older
-versions is not planned, but it's probably easy to backport it. If you work on a
-backport, feel free to contact us.  :-)
-
-COMPILE
--------
-To compile against your currently installed kernel, just type:
-
-# make
-
-if you want to compile against some other kernel, use:
-
-# make KERNELPATH=/path/to/kernel
 
 USAGE
 -----
@@ -123,15 +110,11 @@ dmesg | grep batman-adv
 
 When investigating problems with your mesh network it is sometimes
 necessary to see more detail debug messages. This must be enabled when
-compiling the batman-adv module. When building batman-adv as part of
-kernel, use "make menuconfig" and enable the option
-"B.A.T.M.A.N. debugging". When compiling outside of the kernel tree it
-is necessary to edit the file Makefile.kbuild and uncomment the line
-
-#EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
+compiling the batman-adv module. Use "make menuconfig" and enable the
+option "B.A.T.M.A.N. debugging".
 
 The additional debug output is by default disabled. It can be enabled
-either at kernel modules load time or during run time. To enable debug
+either at kernel module load time or during run time. To enable debug
 output at module load time, add the module parameter debug=<value>.
 <value> can take one of four values.
 
@@ -160,12 +143,12 @@ to see the debug messages.
 BATCTL
 ------
 
-B.A.T.M.A.N.  advanced  operates on layer 2 and thus all hosts partici-
-pating in the virtual switch are completely transparent for all  proto-
-cols above layer 2. Therefore the common diagnosis tools do not work as
-expected. To overcome these problems batctl was created. At the  moment
-the  batctl contains ping, traceroute, tcpdump and interfaces to the
-kernel module settings.
+B.A.T.M.A.N.  advanced operates on layer 2 and thus all hosts
+participating in the virtual switch are completely transparent for all
+protocols above layer 2. Therefore the common diagnosis tools do not
+work as expected. To overcome these problems batctl was created. At
+the moment the batctl contains ping, traceroute, tcpdump and
+interfaces to the kernel module settings.
 
 For more information, please see the manpage (man batctl).
 
-- 
1.7.1

