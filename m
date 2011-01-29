Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 20:53:08 +0100
Message-Id: <1296330789-6561-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Merge batman-adv 2011.0.0
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/CHANGELOG |   13 +++++++++++++
 batman-adv/README    |   15 ++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/batman-adv/CHANGELOG b/batman-adv/CHANGELOG
index beff486..6265828 100644
--- a/batman-adv/CHANGELOG
+++ b/batman-adv/CHANGELOG
@@ -1,3 +1,16 @@
+batman-adv 2011.0.0:
+
+* support latest kernels (2.6.21 - 2.6.38)
+* conversion of reference counting to kref
+* allow merging and refragmentation of unicast packets during transfers
+* add softif bridge loop detection
+* make hop_penalty configurable through sysfs
+* reimplement most of the batman-adv hash functionality
+* support for optimized DHCP based gateway selection
+* cleanup of the sysfs code
+
+ -- Sat, 29 Jan 2011 20:08:05 +0100
+
 batman-adv 2010.2.0:
 
 * support latest kernels (2.6.21 - 2.6.37)
diff --git a/batman-adv/README b/batman-adv/README
index fb5b9ff..85e4518 100644
--- a/batman-adv/README
+++ b/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 21-11-2010]
+[state: 27-01-2011]
 
 BATMAN-ADV
 ----------
@@ -18,7 +18,7 @@ Batman advanced was implemented as a Linux kernel driver  to  re-
 duce the overhead to a minimum. It does not depend on any (other)
 network driver, and can be used on wifi as well as ethernet  lan,
 vpn,  etc ... (anything with ethernet-style layer 2). It compiles
-against and should work with Linux 2.6.21 -  2.6.37.   Supporting
+against and should work with Linux 2.6.21 -  2.6.38.   Supporting
 older versions is not planned, but it's probably easy to backport
 it.  If you work on a backport, feel free to contact us.  :-)
 
@@ -83,15 +83,16 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 #  ls  /sys/class/net/bat0/mesh/
-#  aggregated_ogms  bonding  fragmentation  orig_interval
-#  vis_mode
+#  aggregated_ogms  gw_bandwidth  hop_penalty
+#  bonding          gw_mode       orig_interval
+#  fragmentation    gw_sel_class  vis_mode
 
 
 There is a special folder for debugging informations:
 
 #  ls /sys/kernel/debug/batman_adv/bat0/
-#  originators  socket  transtable_global  transtable_local
-#  vis_data
+#  gateways     socket        transtable_global  vis_data
+#  originators  softif_neigh  transtable_local
 
 
 Some of the files contain all sort of status information  regard-
@@ -250,7 +251,7 @@ CONTACT
 Please send us comments, experiences, questions, anything :)
 
 IRC:            #batman   on   irc.freenode.org
-Mailing-list:   b.a.t.m.a.n@open-mesh.net (optional  subscription
+Mailing-list:   b.a.t.m.a.n@open-mesh.org (optional  subscription
           at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
 You can also contact the Authors:
-- 
1.7.2.3

