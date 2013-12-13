Return-Path: <gui@altermundi.net>
Message-ID: <52AB5A76.9040900@altermundi.net>
Date: Fri, 13 Dec 2013 16:05:26 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <52AB5A13.2050709@altermundi.net>
In-Reply-To: <52AB5A13.2050709@altermundi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: workaround race condition when
 batmanif is not ready at boot time
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

Wait up to 30 seconds during init.d script on boot, so that batmanif can
come up. If the timeout is reached, the init.d script refuses to start
alfred and related daemons.

This prevents an alfred crash when it would start during early boot, before
batmanif is available. Instead, alfred is started as soon as batmanif appears,
if that happens during the 30-second window.

Signed-off-by: Gui Iribarren <gui@altermundi.net>
---
 alfred/Makefile          |  2 +-
 alfred/files/alfred.init | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/alfred/Makefile b/alfred/Makefile
index b9c2c33..c8e73c2 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -12,7 +12,7 @@ include $(TOPDIR)/rules.mk
 #
 PKG_NAME:=alfred
 PKG_VERSION:=2013.4.0
-PKG_RELEASE:=2
+PKG_RELEASE:=3
 PKG_MD5SUM:=3891697e127b1037cfc9349fd96e9993
 
 PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
diff --git a/alfred/files/alfred.init b/alfred/files/alfred.init
index b678d4c..b777b53 100755
--- a/alfred/files/alfred.init
+++ b/alfred/files/alfred.init
@@ -16,6 +16,7 @@ pid_file_alfred="/var/run/alfred.pid"
 pid_file_vis="/var/run/batadv-vis.pid"
 enable=0
 vis_enable=0
+batmanif=""
 SERVICE_DAEMONIZE=1
 SERVICE_WRITE_PID=1
 
@@ -23,7 +24,7 @@ alfred_start()
 {
 	local args=""
 	local section="$1"
-	local disabled interface mode batmanif
+	local disabled interface mode
 
 	# check if section is disabled
 	config_get_bool disabled "$section" disabled 0
@@ -62,6 +63,21 @@ start()
 	if [ "$enable" = "0" ]; then
 		exit 0
 	fi
+
+	mesh_dir="/sys/class/net/$batmanif/mesh/"
+	if ! [ -d "$mesh_dir" ] ; then
+		timeout=30
+		echo "${initscript}: waiting $timeout secs for $batmanif interface..."
+		for i in $(seq $timeout); do
+			sleep 1
+			[ -d "$mesh_dir" ] && break
+			if [ $i == $timeout ] ; then
+				echo "${initscript}: $batmanif not detected, alfred not starting."
+				exit 1
+			fi
+		done
+	fi
+
 	echo "${initscript}: starting alfred"
 	SERVICE_PID_FILE="$pid_file_alfred"
 	service_start /usr/sbin/alfred ${alfred_args}
-- 
1.8.4.rc3
