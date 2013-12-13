Return-Path: <gui@altermundi.net>
Message-ID: <52AB5A13.2050709@altermundi.net>
Date: Fri, 13 Dec 2013 16:03:47 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: fix batadv-vis invocation in
	init.d script
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

broken (wouldn't start, failing silently) since the following commit:
 * "renamed vis to batadv-vis to avoid collisions with other vis binaries"
which renamed only some instances of the "vis" command

Signed-off-by: Gui Iribarren <gui@altermundi.net>
---
 alfred/Makefile          |  2 +-
 alfred/files/alfred.init | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/alfred/Makefile b/alfred/Makefile
index ffc8026..b9c2c33 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -12,7 +12,7 @@ include $(TOPDIR)/rules.mk
 #
 PKG_NAME:=alfred
 PKG_VERSION:=2013.4.0
-PKG_RELEASE:=1
+PKG_RELEASE:=2
 PKG_MD5SUM:=3891697e127b1037cfc9349fd96e9993
 
 PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
diff --git a/alfred/files/alfred.init b/alfred/files/alfred.init
index e52a7bd..b678d4c 100755
--- a/alfred/files/alfred.init
+++ b/alfred/files/alfred.init
@@ -13,7 +13,7 @@ alfred_args=""
 vis_args=""
 facters_dir="/etc/alfred"
 pid_file_alfred="/var/run/alfred.pid"
-pid_file_vis="/var/run/vis.pid"
+pid_file_vis="/var/run/batadv-vis.pid"
 enable=0
 vis_enable=0
 SERVICE_DAEMONIZE=1
@@ -44,7 +44,7 @@ alfred_start()
 	enable=1
 
         config_get_bool start_vis "$section" start_vis 0
-        if [ "$start_vis" = 1 ] && [ -x /usr/sbin/vis ]; then
+        if [ "$start_vis" = 1 ] && [ -x /usr/sbin/batadv-vis ]; then
                 vis_enable=1
                 append vis_args "-i $batmanif -s"
         fi
@@ -67,9 +67,9 @@ start()
 	service_start /usr/sbin/alfred ${alfred_args}
 
 	if [ "$vis_enable" = "1" ]; then
-		echo "${initscript}: starting vis"
+		echo "${initscript}: starting batadv-vis"
 		SERVICE_PID_FILE="$pid_file_vis"
-		service_start /usr/sbin/vis ${vis_args}
+		service_start /usr/sbin/batadv-vis ${vis_args}
 	fi
 
 	if [ "$run_facters" = "1" ]; then
@@ -87,7 +87,7 @@ stop()
 	SERVICE_PID_FILE="$pid_file_alfred"
 	service_stop /usr/sbin/alfred
 	SERVICE_PID_FILE="$pid_file_vis"
-	[ -x /usr/sbin/vis ] && service_stop /usr/sbin/vis
+	[ -x /usr/sbin/batadv-vis ] && service_stop /usr/sbin/batadv-vis
 	sed "\|for file in $facters_dir/\* ; do |d" -i /etc/crontabs/root
 	/etc/init.d/cron restart
 }
-- 
1.8.4.rc3
