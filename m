Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:20 +0200
Message-Id: <1283644718-653-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/21] Staging: batman-adv: Start new
	development cycle
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

Version 2010.1.0 of the extra kernel module was released and thus the
documentation should be updated and everything prepared for the the
upcoming patchset.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/README |   45 ++++++++++++++++++-------------------
 drivers/staging/batman-adv/main.h |    2 +-
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index 7192b7f..3a975fc 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 12-06-2010]
+[state: 04-09-2010]
 
 BATMAN-ADV
 ----------
@@ -67,15 +67,21 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregate_ogm   originators        transtable_global  vis_mode
-#  orig_interval   transtable_local   vis_data
+#  aggregated_ogms  bonding  orig_interval  vis_mode
+
+
+There is a special folder for debugging informations:
+
+#  ls /sys/kernel/debug/batman_adv/bat0/
+#  originators  socket  transtable_global  transtable_local
+#  vis_data
 
 
 Some of the files contain all sort of status information  regard-
 ing  the  mesh  network.  For  example, you can view the table of
 originators (mesh participants) with:
 
-# cat /sys/class/net/bat0/mesh/originators
+# cat /sys/kernel/debug/batman_adv/bat0/originators
 
 Other files allow to change batman's behaviour to better fit your
 requirements.  For instance, you can check the current originator
@@ -83,7 +89,7 @@ interval (value in milliseconds which determines how often batman
 sends its broadcast packets):
 
 # cat /sys/class/net/bat0/mesh/orig_interval
-# status: 1000
+# 1000
 
 and also change its value:
 
@@ -137,7 +143,7 @@ at least very similar) data.
 When  configured  as  server,  you can get a topology snapshot of
 your mesh:
 
-# cat /sys/class/net/bat0/mesh/vis_data
+# cat /sys/kernel/debug/batman_adv/bat0/vis_data
 
 This raw output is intended to be easily parsable and convertable
 with  other tools. Have a look at the batctl README if you want a
@@ -181,32 +187,25 @@ enabled when compiling the batman-adv module. When building  bat-
 man-adv  as  part of kernel, use "make menuconfig" and enable the
 option "B.A.T.M.A.N. debugging".
 
+Those additional  debug messages can be accessed  using a special
+file in debugfs
+
+# cat /sys/kernel/debug/batman_adv/bat0/log
+
 The additional debug output is by default disabled. It can be en-
-abled  either  at kernel modules load time or during run time. To
-enable debug output at module load time, add the module parameter
-debug=<value>.  <value> can take one of four values.
+abled  during run time. Following log_levels are defined:
 
 0 - All  debug  output  disabled
 1 - Enable messages related to routing / flooding / broadcasting
 2 - Enable route or hna added / changed / deleted
 3 - Enable all messages
 
-e.g.
+The debug output can be changed at runtime  using  the  file
+/sys/class/net/bat0/mesh/log_level. e.g.
 
-# modprobe batman-adv debug=2
+# echo 2 > /sys/class/net/bat0/mesh/log_level
 
-will load the module and enable debug messages for when routes or
-HNAs change.
-
-The debug output can also be changed at runtime  using  the  file
-/sys/module/batman-adv/parameters/debug. e.g.
-
-# echo 2 > /sys/module/batman-adv/parameters/debug
-
-enables debug messages for when routes or HNAs
-
-The  debug  output  is sent to the kernel logs. So try dmesg, lo-
-gread, etc to see the debug messages.
+will enable debug messages for when routes or HNAs change.
 
 
 BATCTL
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 8513261..9b30eef 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -30,7 +30,7 @@
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
-#define SOURCE_VERSION "maint"
+#define SOURCE_VERSION "next"
 
 
 /* B.A.T.M.A.N. parameters */
-- 
1.7.1

