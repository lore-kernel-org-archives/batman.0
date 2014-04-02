Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  2 Apr 2014 14:40:02 +0200
Message-Id: <1396442402-13847-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH openwrt-routing-feed] batman-adv: add support
	for the isolation_mark option
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

With the introduction of the Extended Isolation component[1]
a new option is required by batman-adv: the isolation_mark.
This patch adds support for it in the configuration file

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Extended-isolation

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 batman-adv/files/lib/batman-adv/config.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/batman-adv/files/lib/batman-adv/config.sh b/batman-adv/files/lib/batman-adv/config.sh
index 471c1f2..3b735d5 100644
--- a/batman-adv/files/lib/batman-adv/config.sh
+++ b/batman-adv/files/lib/batman-adv/config.sh
@@ -12,7 +12,7 @@ bat_config()
 {
 	local mesh="$1"
 	local aggregated_ogms ap_isolation bonding bridge_loop_avoidance distributed_arp_table fragmentation
-	local gw_bandwidth gw_mode gw_sel_class hop_penalty network_coding log_level orig_interval vis_mode
+	local gw_bandwidth gw_mode gw_sel_class hop_penalty isolation_mark network_coding log_level orig_interval vis_mode
 
 	config_get aggregated_ogms "$mesh" aggregated_ogms
 	config_get ap_isolation "$mesh" ap_isolation
@@ -24,6 +24,7 @@ bat_config()
 	config_get gw_mode "$mesh" gw_mode
 	config_get gw_sel_class "$mesh" gw_sel_class
 	config_get hop_penalty "$mesh" hop_penalty
+	config_get isolation_mark "$mesh" isolation_mark
 	config_get network_coding "$mesh" network_coding
 	config_get log_level "$mesh" log_level
 	config_get orig_interval "$mesh" orig_interval
@@ -41,6 +42,7 @@ bat_config()
 	[ -n "$gw_mode" ] && echo $gw_mode > /sys/class/net/$mesh/mesh/gw_mode
 	[ -n "$gw_sel_class" ] && echo $gw_sel_class > /sys/class/net/$mesh/mesh/gw_sel_class
 	[ -n "$hop_penalty" ] && echo $hop_penalty > /sys/class/net/$mesh/mesh/hop_penalty
+	[ -n "$isolation_mark" ] && echo $isolation_mark > /sys/class/net/$mesh/mesh/isolation_mark
 	[ -n "$network_coding" ] && echo $network_coding > /sys/class/net/$mesh/mesh/network_coding 2>&-
 	[ -n "$log_level" ] && echo $log_level > /sys/class/net/$mesh/mesh/log_level 2>&-
 	[ -n "$orig_interval" ] && echo $orig_interval > /sys/class/net/$mesh/mesh/orig_interval
-- 
1.8.3.2

