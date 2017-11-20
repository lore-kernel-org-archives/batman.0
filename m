Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:17 +0100
Message-Id: <20171120210217.8941-4-sven@narfation.org>
In-Reply-To: <20171120210217.8941-1-sven@narfation.org>
References: <20171120210217.8941-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Convert README to
 reStructuredText
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

The current format of the file is not well defined. The reStructuredText
format (as used by other batman-adv related files) has the benefit that it
is similar easy to read and write. And it allows other tools to parse the
content of the file and convert it in a sensible way to a different file
format.

Multiple git repository web-based management software also can directly
render these files as properly formatted HTML output.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external         | 51 ------------------------------------------
 README.external.license |  2 --
 README.external.rst     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 53 deletions(-)
 delete mode 100644 README.external
 delete mode 100644 README.external.license
 create mode 100644 README.external.rst

diff --git a/README.external b/README.external
deleted file mode 100644
index 03f08ad1..00000000
--- a/README.external
+++ /dev/null
@@ -1,51 +0,0 @@
-BATMAN-ADV external module
---------------------------
-
-The  batman-adv  module  is  shipped  as part of the Linux kernel
-and as external module. The external  module   allows   to    get
-new    features without  upgrading  to  a  newer  kernel  version
-and to get batman-adv specific bugfixes  for  kernels  that   are
-not   supported   anymore.  It compiles  against  and should work
-with Linux 3.2 -  4.14.  Supporting   older   versions   is   not
-planned,  but it's probably easy to backport it. If you work on a
-backport, feel free to contact us.  :-)
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
-if you want to install this module:
-
-# sudo make install
-
-CONFIGURATION
--------------
-
-The     in-kernel    module    can    be    configured    through
-menuconfig.   When  compiling outside  of the kernel tree,  it is
-necessary  to  configure  it  using    the   make  options.  Each
-option  can be set to to y (enabled), n (disabled) or m (build as
-module).  Available  options  and  their    possible   values are
-(default marked with an "*")
-
- * CONFIG_BATMAN_ADV_DEBUGFS=[y*|n] (B.A.T.M.A.N. debugfs entries)
- * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
- * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
- * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
- * CONFIG_BATMAN_ADV_MCAST=[y*|n] (B.A.T.M.A.N. multicast optimizations)
- * CONFIG_BATMAN_ADV_NC=[y|n*] (B.A.T.M.A.N. Network Coding)
- * CONFIG_BATMAN_ADV_BATMAN_V=[y|n*] (B.A.T.M.A.N. V routing algorithm)
-
-e.g., debugging can be enabled by
-
-# make CONFIG_BATMAN_ADV_DEBUG=y
-
-Keep  in  mind  that  all  options  must  also  be added to "make
-install" call.
diff --git a/README.external.license b/README.external.license
deleted file mode 100644
index a55d70ee..00000000
--- a/README.external.license
+++ /dev/null
@@ -1,2 +0,0 @@
-SPDX-License-Identifier: GPL-2.0
-License-Filename: LICENSES/preferred/GPL-2.0
diff --git a/README.external.rst b/README.external.rst
new file mode 100644
index 00000000..40a00452
--- /dev/null
+++ b/README.external.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+BATMAN-ADV external module
+==========================
+
+Introduction
+============
+
+The  batman-adv  module  is  shipped  as part of the Linux kernel
+and as external module. The external  module   allows   to    get
+new    features without  upgrading  to  a  newer  kernel  version
+and to get batman-adv specific bugfixes  for  kernels  that   are
+not   supported   anymore.  It compiles  against  and should work
+with Linux 3.2 -  4.14.  Supporting   older   versions   is   not
+planned,  but it's probably easy to backport it. If you work on a
+backport, feel free to contact us.  :-)
+
+
+COMPILE
+=======
+
+To compile against your currently installed  kernel, just type::
+
+  # make
+
+if you want to compile against some other kernel, use::
+
+  # make KERNELPATH=/path/to/kernel
+
+if you want to install this module::
+
+  # sudo make install
+
+
+CONFIGURATION
+=============
+
+The     in-kernel    module    can    be    configured    through
+menuconfig.   When  compiling outside  of the kernel tree,  it is
+necessary  to  configure  it  using    the   make  options.  Each
+option  can be set to to y (enabled), n (disabled) or m (build as
+module).  Available  options  and  their    possible   values are
+(default marked with an "*")
+
+ * ``CONFIG_BATMAN_ADV_DEBUGFS=[y*|n]`` (B.A.T.M.A.N. debugfs entries)
+ * ``CONFIG_BATMAN_ADV_DEBUG=[y|n*]`` (B.A.T.M.A.N. debugging)
+ * ``CONFIG_BATMAN_ADV_BLA=[y*|n]`` (B.A.T.M.A.N. bridge loop avoidance)
+ * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
+ * ``CONFIG_BATMAN_ADV_MCAST=[y*|n]`` (B.A.T.M.A.N. multicast optimizations)
+ * ``CONFIG_BATMAN_ADV_NC=[y|n*]`` (B.A.T.M.A.N. Network Coding)
+ * ``CONFIG_BATMAN_ADV_BATMAN_V=[y|n*]`` (B.A.T.M.A.N. V routing algorithm)
+
+e.g., debugging can be enabled by::
+
+  # make CONFIG_BATMAN_ADV_DEBUG=y
+
+Keep  in  mind  that  all  options  must  also  be added to ``make install``
+call.
-- 
2.11.0

