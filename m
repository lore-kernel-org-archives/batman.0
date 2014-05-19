Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 19 May 2014 10:52:01 +0200
Message-Id: <1400489521-22006-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: enable batadv_vlan
	protocol
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

This protocol can be used to change VLAN-specific settings
of a batman-adv soft-interface.
At the moment only ap_isolation is available, but new ones
can be easily added as soon as batman-adv get to support more.

Interface configuration example:

config interface 'bat0vlan1'
	option protocol 'batadv_vlan'
	option ifname 'bat0.1'
	option ap_isolation '1'

Cc: Bastian Bittorf <bittorf@bluebottle.com>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

**this patch has been tested only with the stable package in openwrt-routing**


 batman-adv-devel/Makefile                          |  1 +
 .../files/lib/netifd/proto/batadv_vlan.sh          | 29 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 batman-adv-devel/files/lib/netifd/proto/batadv_vlan.sh

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index e8b0881..76f5861 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -78,6 +78,7 @@ define KernelPackage/batman-adv-devel/install
 	$(INSTALL_DATA) ./files/lib/batman-adv/config.sh $(1)/lib/batman-adv
 	$(INSTALL_BIN) ./files/etc/hotplug.d/net/99-batman-adv $(1)/etc/hotplug.d/net
 	$(INSTALL_BIN) ./files/lib/netifd/proto/batadv.sh $(1)/lib/netifd/proto
+	$(INSTALL_BIN) ./files/lib/netifd/proto/batadv_vlan.sh $(1)/lib/netifd/proto
 endef
 
 $(eval $(call KernelPackage,batman-adv-devel))
diff --git a/batman-adv-devel/files/lib/netifd/proto/batadv_vlan.sh b/batman-adv-devel/files/lib/netifd/proto/batadv_vlan.sh
new file mode 100644
index 0000000..85002c3
--- /dev/null
+++ b/batman-adv-devel/files/lib/netifd/proto/batadv_vlan.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+. /lib/functions.sh
+. ../netifd-proto.sh
+init_proto "$@"
+
+proto_batadv_vlan_init_config() {
+	proto_config_add_string "ap_isolation"
+}
+
+proto_batadv_vlan_setup() {
+	local config="$1"
+	local iface="$2"
+
+	# VLAN specific variables
+	local device="${iface%.*}"
+	local vid="${iface#*.}"
+
+	# batadv_vlan options
+	local ap_isolation
+
+	json_get_vars ap_isolation
+
+	echo "$ap_isolation" > "/sys/class/net/${device}/mesh/vlan${vid}/ap_isolation"
+	proto_init_update "$iface" 1
+	proto_send_update "$config"
+}
+
+add_protocol batadv_vlan
-- 
1.8.5.5

