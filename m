Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  6 Jan 2010 07:24:38 +0100
Message-Id: <1262759078-16687-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: Update the README for
	mainline usage.
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
To: greg@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

The module now only compiles inside mainline, so remove the comments
about different versions of the kernel it can be used with. Also
update comments about building with debug enabled and how to use the
VIS data now that it no longer natively outputs dot or JSON.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/README |   50 +++++++++---------------------------
 1 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index 2bedcbe..7d666ad 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 13-12-2009]
+[state: 06-01-2010]
 
 BATMAN-ADV
 ----------
@@ -15,19 +15,6 @@ above B.A.T.M.A.N. Advanced, prominent examples are: IPv4, IPv6, DHCP, IPX.
 This is batman-advanced implemented as Linux kernel driver. It does not depend
 on any network (other) driver, and can be used on wifi as well as ethernet,
 vpn, etc ... (anything with ethernet-style layer 2).
-It compiles against and should work with Linux 2.6.20 - 2.6.32. Supporting older
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
@@ -73,16 +60,9 @@ When configured as server, you can get a topology snapshot of your mesh:
 
 # cat /proc/net/batman-adv/vis
 
-This output format is a graphviz formatted text file which can be
-processed with graphviz-tools like dot.
-The labels are similar/compatible to the ETX metric, 1.0 means perfect
-connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
-
-Alternatively, a JSON output format is available. The format can be set
-using by writing either "dot_draw" or "json" into the vis_format file.
-"dot_draw" is selected by default.
-
-echo "json" > /proc/net/batman-adv/vis_format
+The output is in a generic raw format. Use the batctl tool (See below)
+to convert this to other formats more suitable for graphing, eg
+graphviz dot, or JSON data-interchange format.
 
 In very mobile scenarios, you might want to adjust the originator
 interval to a lower value. This will make the mesh more responsive to
@@ -110,15 +90,11 @@ dmesg | grep batman-adv
 
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
 
@@ -147,12 +123,12 @@ to see the debug messages.
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
1.6.5.7

