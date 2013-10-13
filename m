Return-Path: <gui@altermundi.net>
Message-ID: <525B1838.4070900@altermundi.net>
Date: Mon, 14 Oct 2013 00:01:28 +0200
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Add a lightweight framework for
 running facter scripts that feed data into alfred every 5 minutes
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


Alfred expects to be fed data periodically, but there's currently no easy
way to do that from scripts, prompting people to write whole C programs
to accomplish tasks that could easily be scripted.
Provide a really simple framework to run scripts every 5 minutes, using a
cronjob, when alfred is started by the init.d script.

Signed-off-by: Gui Iribarren <gui@altermundi.net>
---
 alfred/files/alfred.config |    1 +
 alfred/files/alfred.init   |   26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/alfred/files/alfred.config b/alfred/files/alfred.config
index b8fa9b2..9d3fff6 100644
--- a/alfred/files/alfred.config
+++ b/alfred/files/alfred.config
@@ -3,5 +3,6 @@ config 'alfred' 'alfred'
 	option mode 'master'
 	option batmanif 'bat0'
 	option start_vis '1'
+	option run_facters '1'
 # REMOVE THIS LINE TO ENABLE ALFRED
 	option disabled '1'
diff --git a/alfred/files/alfred.init b/alfred/files/alfred.init
index 56818d8..e52a7bd 100755
--- a/alfred/files/alfred.init
+++ b/alfred/files/alfred.init
@@ -11,6 +11,7 @@ START=99
 STOP=99
 alfred_args=""
 vis_args=""
+facters_dir="/etc/alfred"
 pid_file_alfred="/var/run/alfred.pid"
 pid_file_vis="/var/run/vis.pid"
 enable=0
@@ -48,6 +49,8 @@ alfred_start()
                 append vis_args "-i $batmanif -s"
         fi
 
+	config_get_bool run_facters "$section" run_facters 0
+
 	return 0
 }
 
@@ -63,12 +66,20 @@ start()
 	SERVICE_PID_FILE="$pid_file_alfred"
 	service_start /usr/sbin/alfred ${alfred_args}
 
-        if [ "$vis_enable" = "0" ]; then
-                exit 0
-        fi
-        echo "${initscript}: starting vis"
-	SERVICE_PID_FILE="$pid_file_vis"
-        service_start /usr/sbin/vis ${vis_args}
+	if [ "$vis_enable" = "1" ]; then
+		echo "${initscript}: starting vis"
+		SERVICE_PID_FILE="$pid_file_vis"
+		service_start /usr/sbin/vis ${vis_args}
+	fi
+
+	if [ "$run_facters" = "1" ]; then
+		( for file in $facters_dir/* ; do [ -x $file ] && $file ; done )
+		if ! ( grep -q "for file in $facters_dir/\* ; do " /etc/crontabs/root 2>/dev/null ) ; then
+			echo "*/5 * * * * ( for file in $facters_dir/* ; do [ -x \$file ] && \$file ; done )" >> /etc/crontabs/root
+			/etc/init.d/cron enable
+			/etc/init.d/cron restart
+		fi
+	fi
 }
 
 stop()
@@ -77,5 +88,6 @@ stop()
 	service_stop /usr/sbin/alfred
 	SERVICE_PID_FILE="$pid_file_vis"
 	[ -x /usr/sbin/vis ] && service_stop /usr/sbin/vis
-
+	sed "\|for file in $facters_dir/\* ; do |d" -i /etc/crontabs/root
+	/etc/init.d/cron restart
 }
-- 
1.7.10.4
