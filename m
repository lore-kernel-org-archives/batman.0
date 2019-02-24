Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 24 Feb 2019 17:51:13 +0100
Message-Id: <20190224165113.15726-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC openwrt-routing] batman-adv: Split batadv proto
 in meshif and hardif part
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
Cc: Sven Eckelmann <sven@narfation.org>, Matthias Schiffer <mschiffer@universe-factory.net>, openwrt-devel@lists.openwrt.org, Gui Iribarren <gui@altermundi.net>, Moritz Warning <moritzwarning@web.de>

batman-adv allows to configure three different objects:

* batadv hardif

  - network interface used by batadv meshif to transport the batman-adv
    packets
  - its master interface is set to the batadv meshif

* batadv (meshif/softif)

  - virtual interface that emulates a normal 802.3 interface on top
  - encapsulates traffic and forwards it via the batadv hardifs

* batadv vlan

  - potential VLAN ID on top of batadv meshif
  - allows filtering of traffic from specific VIDs

While batadv vlan objects were already represented as an own proto
"batadv_vlan", the batadv meshif could never be fully configured using
/etc/config/network. Instead, parts of its configuration were stored in
/etc/config/batman_adv and some in the interfaces with the "batadv" proto.

To increase the confusion, the "batadv" proto wasn't used to define the
batadv meshif but to identify batadv (slave) hardifs. The batman-adv
meshifs were also never created directly but only when a hardif was
configured. The actual modification of the configuration settings was then
applied using a hotplug script hack. The batadv meshif network interface
could therefore only be created when an hardif was available and not
manipulated with ifup/ifdown. Also `/etc/init.d/network reload` didn't
modify the batadv meshif interface configuration correctly.

The "batadv" is now renamed to "batadv_hardif" and a new "batadv" proto is
used to configure the main (meshif) network interface with all its
configuration.

A simple network configuration with WiFi & ethernet interfaces and static
IP on top of bat0 would look like:

  # batadv meshif bat0
  config interface 'bat0'
  	option proto 'batadv'
  	option routing_algo 'BATMAN_IV'
  	option aggregated_ogms 1
  	option ap_isolation 0
  	option bonding 0
  	option fragmentation 1
  	#option gw_bandwidth '10000/2000'
  	option gw_mode 'off'
  	#option gw_sel_class 20
  	option log_level 0
  	option orig_interval 1000
  	option bridge_loop_avoidance 1
  	option distributed_arp_table 1
  	option multicast_mode 1
  	option network_coding 0
  	option hop_penalty 30
  	option isolation_mark '0x00000000/0x00000000'

  # add *single* wifi-iface with network bat0_hardif_wlan as hardif to bat0
  config interface 'bat0_hardif_wlan'
  	option mtu '1536'
  	option proto 'batadv_hardif'
  	option master 'bat0'
  	# option ifname is filled out by the wifi-iface

  # add eth0 as hardif to bat0
  config interface 'bat0_hardif_eth0'
  	option proto 'batadv_hardif'
  	option master 'bat0'
  	option ifname 'eth0'
  	option mtu '1536'

  # configure IP on bat0
  config interface 'bat0_lan'
  	option ifname 'bat0'
  	option proto 'static'
  	option ipaddr '192.168.1.1'
  	option netmask '255.255.255.0'
  	option ip6assign '60'

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: openwrt-devel@lists.openwrt.org
Cc: Gui Iribarren <gui@altermundi.net>
Cc: Moritz Warning <moritzwarning@web.de>

Changes depend on https://github.com/openwrt-routing/packages/pull/451
---
 batman-adv/Makefile                           |   2 +-
 batman-adv/files/etc/config/batman-adv        |  20 ----
 .../files/etc/hotplug.d/net/99-batman-adv     |  12 --
 .../etc/uci-defaults/99-migrate-batadv_hardif |  97 +++++++++++++++
 batman-adv/files/lib/batman-adv/config.sh     |  69 -----------
 batman-adv/files/lib/netifd/proto/batadv.sh   | 112 +++++++++++++++---
 .../files/lib/netifd/proto/batadv_hardif.sh   |  40 +++++++
 7 files changed, 235 insertions(+), 117 deletions(-)
 delete mode 100644 batman-adv/files/etc/config/batman-adv
 delete mode 100644 batman-adv/files/etc/hotplug.d/net/99-batman-adv
 create mode 100755 batman-adv/files/etc/uci-defaults/99-migrate-batadv_hardif
 delete mode 100644 batman-adv/files/lib/batman-adv/config.sh
 create mode 100755 batman-adv/files/lib/netifd/proto/batadv_hardif.sh

diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index 82af6c7..b250888 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -10,7 +10,7 @@ include $(TOPDIR)/rules.mk
 PKG_NAME:=batman-adv
 
 PKG_VERSION:=2019.0
-PKG_RELEASE:=2
+PKG_RELEASE:=3
 PKG_HASH:=3e97d8a771cdbd7b2df42c52b88e071eaa58b5d28eb4e17a4b13b6698debbdc0
 
 PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
diff --git a/batman-adv/files/etc/config/batman-adv b/batman-adv/files/etc/config/batman-adv
deleted file mode 100644
index 21138cb..0000000
--- a/batman-adv/files/etc/config/batman-adv
+++ /dev/null
@@ -1,20 +0,0 @@
-
-config 'mesh' 'bat0'
-	#option 'aggregated_ogms' 1
-	#option 'ap_isolation' 0
-	#option 'bonding' 0
-	#option 'fragmentation' 1
-	#option 'gw_bandwidth' '10000/2000'
-	#option 'gw_mode' 'off'
-	#option 'gw_sel_class' 20
-	#option 'log_level' 0
-	#option 'orig_interval' 1000
-	#option 'bridge_loop_avoidance' 1
-	#option 'distributed_arp_table' 1
-	#option 'multicast_mode' 1
-	#option 'network_coding' 0
-	#option 'hop_penalty' 30
-	#option 'isolation_mark' '0x00000000/0x00000000'
-
-# yet another batX instance
-# config 'mesh' 'bat5'
diff --git a/batman-adv/files/etc/hotplug.d/net/99-batman-adv b/batman-adv/files/etc/hotplug.d/net/99-batman-adv
deleted file mode 100644
index f0c391f..0000000
--- a/batman-adv/files/etc/hotplug.d/net/99-batman-adv
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-
-. /lib/batman-adv/config.sh
-
-bat_load_module
-config_load batman-adv
-
-case "$ACTION" in
-	add)
-		[ -d /sys/class/net/$INTERFACE/mesh/ ] && bat_config "$INTERFACE"
-		;;
-esac
diff --git a/batman-adv/files/etc/uci-defaults/99-migrate-batadv_hardif b/batman-adv/files/etc/uci-defaults/99-migrate-batadv_hardif
new file mode 100755
index 0000000..156a33f
--- /dev/null
+++ b/batman-adv/files/etc/uci-defaults/99-migrate-batadv_hardif
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+# This UCI-Defaults script will split the batadv proto network interfaces
+# in batadv_hardif and batadv proto. The configuration options from
+# /etc/config/batman-adv will be moved to the latter.
+
+. /lib/functions.sh
+
+proto_batadv_to_batadv_hardif() {
+    local section="$1"
+    local proto
+    local mesh
+    local routing_algo
+
+    config_get proto "${section}" proto
+    config_get mesh "${section}" mesh
+    config_get routing_algo "${section}" routing_algo
+
+    if [ -z "$mesh" -o "${proto}" != "batadv" ]; then
+        continue
+    fi
+
+    uci set network."${section}".proto="batadv_hardif"
+    uci rename network."${section}".mesh="master"
+    uci delete network."${section}".routing_algo
+
+    # create new section or adjust existing one
+    uci set network."${mesh}"=interface
+    uci set network."${mesh}".proto=batadv
+    [ -n "${routing_algo}" ]  && uci set network."${mesh}".routing_algo="${routing_algo}"
+}
+
+mv_batadv_config_section() {
+    local section="$1"
+    local aggregated_ogms
+    local ap_isolation
+    local bonding
+    local bridge_loop_avoidance
+    local distributed_arp_table
+    local fragmentation
+    local gw_bandwidth
+    local gw_mode
+    local gw_sel_class
+    local hop_penalty
+    local isolation_mark
+    local log_level
+    local multicast_mode
+    local network_coding
+    local orig_interval
+
+    config_get aggregated_ogms "${section}" aggregated_ogms
+    config_get ap_isolation "${section}" ap_isolation
+    config_get bonding "${section}" bonding
+    config_get bridge_loop_avoidance "${section}" bridge_loop_avoidance
+    config_get distributed_arp_table "${section}" distributed_arp_table
+    config_get fragmentation "${section}" fragmentation
+    config_get gw_bandwidth "${section}" gw_bandwidth
+    config_get gw_mode "${section}" gw_mode
+    config_get gw_sel_class "${section}" gw_sel_class
+    config_get hop_penalty "${section}" hop_penalty
+    config_get isolation_mark "${section}" isolation_mark
+    config_get log_level "${section}" log_level
+    config_get multicast_mode "${section}" multicast_mode
+    config_get network_coding "${section}" network_coding
+    config_get orig_interval "${section}" orig_interval
+
+    # update section in case it exists
+    [ -n "${aggregated_ogms}" ]  && uci set network."${section}".aggregated_ogms="${aggregated_ogms}"
+    [ -n "${ap_isolation}" ]  && uci set network."${section}".ap_isolation="${ap_isolation}"
+    [ -n "${bonding}" ]  && uci set network."${section}".bonding="${bonding}"
+    [ -n "${bridge_loop_avoidance}" ]  && uci set network."${section}".bridge_loop_avoidance="${bridge_loop_avoidance}"
+    [ -n "${distributed_arp_table}" ]  && uci set network."${section}".distributed_arp_table="${distributed_arp_table}"
+    [ -n "${fragmentation}" ]  && uci set network."${section}".fragmentation="${fragmentation}"
+    [ -n "${gw_bandwidth}" ]  && uci set network."${section}".gw_bandwidth="${gw_bandwidth}"
+    [ -n "${gw_mode}" ]  && uci set network."${section}".gw_mode="${gw_mode}"
+    [ -n "${gw_sel_class}" ]  && uci set network."${section}".gw_sel_class="${gw_sel_class}"
+    [ -n "${hop_penalty}" ]  && uci set network."${section}".hop_penalty="${hop_penalty}"
+    [ -n "${isolation_mark}" ]  && uci set network."${section}".isolation_mark="${isolation_mark}"
+    [ -n "${log_level}" ]  && uci set network."${section}".log_level="${log_level}"
+    [ -n "${multicast_mode}" ]  && uci set network."${section}".multicast_mode="${multicast_mode}"
+    [ -n "${network_coding}" ]  && uci set network."${section}".network_coding="${network_coding}"
+    [ -n "${orig_interval}" ]  && uci set network."${section}".orig_interval="${orig_interval}"
+}
+
+if [ -f /etc/config/batman-adv ]; then
+    config_load network
+    config_foreach proto_batadv_to_batadv_hardif 'interface'
+    uci commit network
+
+    config_load batman-adv
+    config_foreach mv_batadv_config_section 'mesh'
+    uci commit batman-adv
+
+    rm -f /etc/config/batman-adv
+fi
+
+exit 0
diff --git a/batman-adv/files/lib/batman-adv/config.sh b/batman-adv/files/lib/batman-adv/config.sh
deleted file mode 100644
index 952f93e..0000000
--- a/batman-adv/files/lib/batman-adv/config.sh
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/bin/sh
-
-bat_load_module()
-{
-	[ -d "/sys/module/batman_adv/" ] && return
-
-	. /lib/functions.sh
-	load_modules /etc/modules.d/*-crc16 /etc/modules.d/*-crypto* /etc/modules.d/*-lib-crc* /etc/modules.d/*-batman-adv*
-}
-
-bat_config()
-{
-	local mesh="$1"
-	local aggregated_ogms ap_isolation bonding bridge_loop_avoidance distributed_arp_table fragmentation
-	local gw_bandwidth gw_mode gw_sel_class isolation_mark hop_penalty multicast_mode network_coding log_level
-	local orig_interval
-
-	config_get aggregated_ogms "$mesh" aggregated_ogms
-	config_get ap_isolation "$mesh" ap_isolation
-	config_get bonding "$mesh" bonding
-	config_get bridge_loop_avoidance "$mesh" bridge_loop_avoidance
-	config_get distributed_arp_table "$mesh" distributed_arp_table
-	config_get fragmentation "$mesh" fragmentation
-	config_get gw_bandwidth "$mesh" gw_bandwidth
-	config_get gw_mode "$mesh" gw_mode
-	config_get gw_sel_class "$mesh" gw_sel_class
-	config_get hop_penalty "$mesh" hop_penalty
-	config_get isolation_mark "$mesh" isolation_mark
-	config_get multicast_mode "$mesh" multicast_mode
-	config_get network_coding "$mesh" network_coding
-	config_get log_level "$mesh" log_level
-	config_get orig_interval "$mesh" orig_interval
-
-	[ ! -f "/sys/class/net/$mesh/mesh/orig_interval" ] && echo "batman-adv mesh $mesh does not exist - check your interface configuration" && return 1
-
-	[ -n "$aggregated_ogms" ] && batctl -m "$mesh" aggregation "$aggregated_ogms"
-	[ -n "$ap_isolation" ] && batctl -m "$mesh" ap_isolation "$ap_isolation"
-	[ -n "$bonding" ] && batctl -m "$mesh" bonding "$bonding"
-	[ -n "$bridge_loop_avoidance" ] &&  batctl -m "$mesh" bridge_loop_avoidance "$bridge_loop_avoidance" 2>&-
-	[ -n "$distributed_arp_table" ] && batctl -m "$mesh" distributed_arp_table "$distributed_arp_table" 2>&-
-	[ -n "$fragmentation" ] && batctl -m "$mesh" fragmentation "$fragmentation"
-
-	case "$gw_mode" in
-	server)
-		if [ -n "$gw_bandwidth" ]; then
-			batctl -m "$mesh" gw_mode "server" "$gw_bandwidth"
-		else
-			batctl -m "$mesh" gw_mode "server"
-		fi
-		;;
-	client)
-		if [ -n "$gw_sel_class" ]; then
-			batctl -m "$mesh" gw_mode "client" "$gw_sel_class"
-		else
-			batctl -m "$mesh" gw_mode "client"
-		fi
-		;;
-	*)
-		batctl -m "$mesh" gw_mode "off"
-		;;
-	esac
-
-	[ -n "$hop_penalty" ] && batctl -m "$mesh" hop_penalty "$hop_penalty"
-	[ -n "$isolation_mark" ] && batctl -m "$mesh" isolation_mark "$isolation_mark"
-	[ -n "$multicast_mode" ] && batctl -m "$mesh" multicast_mode "$multicast_mode" 2>&-
-	[ -n "$network_coding" ] && batctl -m "$mesh" network_coding "$network_coding" 2>&-
-	[ -n "$log_level" ] && batctl -m "$mesh" loglevel "$log_level" 2>&-
-	[ -n "$orig_interval" ] && batctl -m "$mesh" orig_interval "$orig_interval"
-}
diff --git a/batman-adv/files/lib/netifd/proto/batadv.sh b/batman-adv/files/lib/netifd/proto/batadv.sh
index 2233091..eb8153c 100755
--- a/batman-adv/files/lib/netifd/proto/batadv.sh
+++ b/batman-adv/files/lib/netifd/proto/batadv.sh
@@ -1,37 +1,119 @@
 #!/bin/sh
 
-. /lib/functions.sh
-. ../netifd-proto.sh
-init_proto "$@"
+[ -n "$INCLUDE_ONLY" ] || {
+	. /lib/functions.sh
+	. ../netifd-proto.sh
+	init_proto "$@"
+}
 
 proto_batadv_init_config() {
-	proto_config_add_string "mesh"
-	proto_config_add_string "routing_algo"
+	no_device=1
+	available=1
+
+	proto_config_add_boolean 'aggregated_ogms:bool'
+	proto_config_add_boolean 'ap_isolation:bool'
+	proto_config_add_boolean 'bonding:bool'
+	proto_config_add_boolean 'bridge_loop_avoidance:bool'
+	proto_config_add_boolean 'distributed_arp_table:bool'
+	proto_config_add_boolean 'fragmentation:bool'
+	proto_config_add_string 'gw_bandwidth'
+	proto_config_add_string 'gw_mode'
+	proto_config_add_int 'gw_sel_class'
+	proto_config_add_int 'hop_penalty'
+	proto_config_add_string 'isolation_mark'
+	proto_config_add_string 'log_level'
+	proto_config_add_boolean 'multicast_mode:bool'
+	proto_config_add_boolean 'network_coding:bool'
+	proto_config_add_int 'orig_interval'
+	proto_config_add_string 'routing_algo'
 }
 
 proto_batadv_setup() {
 	local config="$1"
-	local iface="$2"
+	local iface="$config"
+
+	local aggregated_ogms
+	local ap_isolation
+	local bonding
+	local bridge_loop_avoidance
+	local distributed_arp_table
+	local fragmentation
+	local gw_bandwidth
+	local gw_mode
+	local gw_sel_class
+	local hop_penalty
+	local isolation_mark
+	local log_level
+	local multicast_mode
+	local network_coding
+	local orig_interval
+	local routing_algo
+
+	json_get_vars aggregated_ogms
+	json_get_vars ap_isolation
+	json_get_vars bonding
+	json_get_vars bridge_loop_avoidance
+	json_get_vars distributed_arp_table
+	json_get_vars fragmentation
+	json_get_vars gw_bandwidth
+	json_get_vars gw_mode
+	json_get_vars gw_sel_class
+	json_get_vars hop_penalty
+	json_get_vars isolation_mark
+	json_get_vars log_level
+	json_get_vars multicast_mode
+	json_get_vars network_coding
+	json_get_vars orig_interval
+	json_get_vars routing_algo
 
-	local mesh routing_algo
-	json_get_vars mesh routing_algo
+	set_default routing_algo 'BATMAN_IV'
 
-	[ -n "$routing_algo" ] || routing_algo="BATMAN_IV"
 	batctl routing_algo "$routing_algo"
+	batctl -m "$iface" interface create
+
+	[ -n "$aggregated_ogms" ] && batctl -m "$iface" aggregation "$aggregated_ogms"
+	[ -n "$ap_isolation" ] && batctl -m "$iface" ap_isolation "$ap_isolation"
+	[ -n "$bonding" ] && batctl -m "$iface" bonding "$bonding"
+	[ -n "$bridge_loop_avoidance" ] &&  batctl -m "$iface" bridge_loop_avoidance "$bridge_loop_avoidance" 2>&-
+	[ -n "$distributed_arp_table" ] && batctl -m "$iface" distributed_arp_table "$distributed_arp_table" 2>&-
+	[ -n "$fragmentation" ] && batctl -m "$iface" fragmentation "$fragmentation"
+
+	case "$gw_mode" in
+	server)
+		if [ -n "$gw_bandwidth" ]; then
+			batctl -m "$iface" gw_mode "server" "$gw_bandwidth"
+		else
+			batctl -m "$iface" gw_mode "server"
+		fi
+		;;
+	client)
+		if [ -n "$gw_sel_class" ]; then
+			batctl -m "$iface" gw_mode "client" "$gw_sel_class"
+		else
+			batctl -m "$iface" gw_mode "client"
+		fi
+		;;
+	*)
+		batctl -m "$iface" gw_mode "off"
+		;;
+	esac
+
+	[ -n "$hop_penalty" ] && batctl -m "$iface" hop_penalty "$hop_penalty"
+	[ -n "$isolation_mark" ] && batctl -m "$iface" isolation_mark "$isolation_mark"
+	[ -n "$multicast_mode" ] && batctl -m "$iface" multicast_mode "$multicast_mode" 2>&-
+	[ -n "$network_coding" ] && batctl -m "$iface" network_coding "$network_coding" 2>&-
+	[ -n "$log_level" ] && batctl -m "$iface" loglevel "$log_level" 2>&-
+	[ -n "$orig_interval" ] && batctl -m "$iface" orig_interval "$orig_interval"
 
-	batctl -m "$mesh" interface add "$iface"
 	proto_init_update "$iface" 1
 	proto_send_update "$config"
 }
 
 proto_batadv_teardown() {
 	local config="$1"
-	local iface="$2"
-
-	local mesh
-	json_get_vars mesh
+	local iface="$config"
 
-	batctl -m "$mesh" interface del "$iface" || true
+	batctl -m "$iface" interface destroy
 }
 
 add_protocol batadv
diff --git a/batman-adv/files/lib/netifd/proto/batadv_hardif.sh b/batman-adv/files/lib/netifd/proto/batadv_hardif.sh
new file mode 100755
index 0000000..9283d2b
--- /dev/null
+++ b/batman-adv/files/lib/netifd/proto/batadv_hardif.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+[ -n "$INCLUDE_ONLY" ] || {
+	. /lib/functions.sh
+	. ../netifd-proto.sh
+	init_proto "$@"
+}
+
+proto_batadv_hardif_init_config() {
+	proto_config_add_string "master"
+}
+
+proto_batadv_hardif_setup() {
+	local config="$1"
+	local iface="$2"
+
+	local master
+
+	json_get_vars master
+
+	( proto_add_host_dependency "$config" '' "$master" )
+
+	batctl -m "$master" interface -M add "$iface"
+
+	proto_init_update "$iface" 1
+	proto_send_update "$config"
+}
+
+proto_batadv_hardif_teardown() {
+	local config="$1"
+	local iface="$2"
+
+	local master
+
+	json_get_vars master
+
+	batctl -m "$master" interface -M del "$iface" || true
+}
+
+add_protocol batadv_hardif
-- 
2.20.1

