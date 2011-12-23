Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Dec 2011 21:53:27 +0100
Message-Id: <1324673607-13741-2-git-send-email-sven@narfation.org>
In-Reply-To: <1324673607-13741-1-git-send-email-sven@narfation.org>
References: <1324673607-13741-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Split README in kernel and
	external part
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
To: b.a.t.m.a.n@lists.open-mesh.org

The README is shipped in a stripped down version as part of the kernel under
Documentation/networking/batman-adv.txt. The readme has to be manually merged
each time it gets prepared for submission to the networking subsystem
maintainer after the README was modified.

This extra work is reduced by splitting it in a README which contains the same
data as available in the kernel and README.external which contains the
information that only affect the external module.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README          |   28 +++-------------------------
 README.external |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 25 deletions(-)
 create mode 100644 README.external

diff --git a/README b/README
index 58d3473..01db663 100644
--- a/README
+++ b/README
@@ -15,26 +15,7 @@ are: IPv4, IPv6, DHCP, IPX.
 Batman advanced was implemented as a Linux kernel driver  to  re-
 duce the overhead to a minimum. It does not depend on any (other)
 network driver, and can be used on wifi as well as ethernet  lan,
-vpn,  etc ... (anything with ethernet-style layer 2). It compiles
-against and should work with Linux 2.6.29 -  3.2.   Supporting
-older versions is not planned, but it's probably easy to backport
-it.  If you work on a backport, feel free to contact us.  :-)
-
-
-COMPILE
--------
-
-To compile against your currently installed  kernel, just type:
-
-# make
-
-if you want to compile against some other kernel, use:
-
-# make KERNELPATH=/path/to/kernel
-
-if you wont to install this module:
-
-# sudo make install
+vpn,  etc ... (anything with ethernet-style layer 2).
 
 
 CONFIGURATION
@@ -89,6 +70,7 @@ folder:
 # ap_isolation      gw_bandwidth  hop_penalty
 # bonding           gw_mode       orig_interval
 
+
 There is a special folder for debugging information:
 
 #  ls /sys/kernel/debug/batman_adv/bat0/
@@ -204,11 +186,7 @@ When investigating problems with your mesh network  it  is  some-
 times  necessary  to see more detail debug messages. This must be
 enabled when compiling the batman-adv module. When building  bat-
 man-adv  as  part of kernel, use "make menuconfig" and enable the
-option "B.A.T.M.A.N. debugging". When compiling  outside  of  the
-kernel  tree it is necessary to enable  it using  the make option
-CONFIG_BATMAN_ADV_DEBUG=y
-
-# make CONFIG_BATMAN_ADV_DEBUG=y
+option "B.A.T.M.A.N. debugging".
 
 Those additional  debug messages can be accessed  using a special
 file in debugfs
diff --git a/README.external b/README.external
new file mode 100644
index 0000000..71104fa
--- /dev/null
+++ b/README.external
@@ -0,0 +1,45 @@
+BATMAN-ADV external module
+--------------------------
+
+The  batman-adv  module  is  shipped  as part of the Linux kernel
+and as external module. The external  module   allows   to    get
+new    features without  upgrading  to  a  newer  kernel  version
+and to get batman-adv specific bugfixes  for  kernels  that   are
+not   supported   anymore.  It compiles  against  and should work
+with Linux 2.6.29 -   3.2.   Supporting  older  versions  is  not
+planned,  but it's probably easy to backport it. If you work on a
+backport, feel free to contact us.  :-)
+
+COMPILE
+-------
+
+To compile against your currently installed  kernel, just type:
+
+# make
+
+if you want to compile against some other kernel, use:
+
+# make KERNELPATH=/path/to/kernel
+
+if you wont to install this module:
+
+# sudo make install
+
+CONFIGURATION
+-------------
+
+The     in-kernel    module    can    be    configured    through
+menuconfig.   When  compiling outside  of the kernel,  tree it is
+necessary  to  configure  it  using    the   make  options.  Each
+option  can be set to to y (enabled), n (disabled) or m (build as
+module).  Available  options  and  their    possible   values are
+(default marked with an "*")
+
+ * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
+
+e.g., debugging can be enabled by
+
+# make CONFIG_BATMAN_ADV_DEBUG=y
+
+Keep  in  mind  that  all  options  must  also  be added to "make
+install" call.
-- 
1.7.7.3

