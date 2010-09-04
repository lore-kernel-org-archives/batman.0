Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  4 Sep 2010 14:30:45 +0200
Message-Id: <1283603445-5980-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Merge batman-adv 2010.1.0
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/CHANGELOG |   16 ++++++++++++++++
 batman-adv/README    |   47 +++++++++++++++++++++++------------------------
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/batman-adv/CHANGELOG b/batman-adv/CHANGELOG
index 86450b4..67bfc6e 100644
--- a/batman-adv/CHANGELOG
+++ b/batman-adv/CHANGELOG
@@ -1,3 +1,19 @@
+batman-adv 2010.1.0:
+
+* support latest kernels (2.6.21 - 2.6.36)
+* further cleanup of coding style
+* recording of routes for batman icmp messages
+* move of complex sysfs files to debugfs
+* change output of all sysfs files to single-value-only
+* reintroduce virtual file for the debug log
+* bonding and alternating added
+* add ttl to broadcasts
+* change all sequence numbers to 32 bit
+* show last-seen in originator table
+* many bugs (rounding issues, locking, netdev event handler, ...) squashed
+
+ -- Sat, 04 Sep 2010 13:56:38 +0200
+
 batman-adv 2010.0.0:
 
 * support latest kernels (2.6.21 - 2.6.35)
diff --git a/batman-adv/README b/batman-adv/README
index 24b062b..ecef96d 100644
--- a/batman-adv/README
+++ b/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 12-06-2010]
+[state: 04-09-2010]
 
 BATMAN-ADV
 ----------
@@ -18,7 +18,7 @@ Batman advanced was implemented as a Linux kernel driver  to  re-
 duce the overhead to a minimum. It does not depend on any (other)
 network driver, and can be used on wifi as well as ethernet  lan,
 vpn,  etc ... (anything with ethernet-style layer 2). It compiles
-against and should work with Linux 2.6.21 -  2.6.35.   Supporting
+against and should work with Linux 2.6.21 -  2.6.36.   Supporting
 older versions is not planned, but it's probably easy to backport
 it.  If you work on a backport, feel free to contact us.  :-)
 
@@ -83,15 +83,21 @@ All  mesh  wide  settings  can be found in batman's own interface
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
@@ -99,7 +105,7 @@ interval (value in milliseconds which determines how often batman
 sends its broadcast packets):
 
 # cat /sys/class/net/bat0/mesh/orig_interval
-# status: 1000
+# 1000
 
 and also change its value:
 
@@ -153,7 +159,7 @@ at least very similar) data.
 When  configured  as  server,  you can get a topology snapshot of
 your mesh:
 
-# cat /sys/class/net/bat0/mesh/vis_data
+# cat /sys/kernel/debug/batman_adv/bat0/vis_data
 
 This raw output is intended to be easily parsable and convertable
 with  other tools. Have a look at the batctl README if you want a
@@ -201,32 +207,25 @@ uncomment the line
 
 #EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
 
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
-
-# modprobe batman-adv debug=2
-
-will load the module and enable debug messages for when routes or
-HNAs change.
-
-The debug output can also be changed at runtime  using  the  file
-/sys/module/batman-adv/parameters/debug. e.g.
-
-# echo 2 > /sys/module/batman-adv/parameters/debug
+The debug output can be changed at runtime  using  the  file
+/sys/class/net/bat0/mesh/log_level. e.g.
 
-enables debug messages for when routes or HNAs
+# echo 2 > /sys/class/net/bat0/mesh/log_level
 
-The  debug  output  is sent to the kernel logs. So try dmesg, lo-
-gread, etc to see the debug messages.
+will enable debug messages for when routes or HNAs change.
 
 
 BATCTL
-- 
1.7.1

