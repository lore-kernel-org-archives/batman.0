Return-Path: <moritzwarning@web.de>
Message-ID: <50C4B63F.60101@web.de>
Date: Sun, 09 Dec 2012 17:03:11 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
 <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
 <50C471C0.2060407@web.de> <201212092231.50649.lindner_marek@yahoo.de>
In-Reply-To: <201212092231.50649.lindner_marek@yahoo.de>
Content-Type: multipart/mixed; boundary="------------020009020101010803070203"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
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

This is a multi-part message in MIME format.
--------------020009020101010803070203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here you go. :)
It would be good idea if Gui had a look at it before it is applied.

On 12/09/2012 03:31 PM, Marek Lindner wrote:
> On Sunday, December 09, 2012 19:10:56 Moritz Warning wrote:
>> I have tried batman-adv-netifd-proto-batadv.patch along with some Makefile
>> adjustments to get it compile. Afaict it works.
> Thanks for testing! Do you mind sharing & explaining these changes ? Would be 
> a good idea to push the working variant, don't you think ?
>
> Cheers,
> Marek
>


--------------020009020101010803070203
Content-Type: text/x-patch;
 name="batman-adv-netifd-proto-batadv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="batman-adv-netifd-proto-batadv.patch"

From d37c189ef8d87e44d2d6a28bbae0c960147d2098 Mon Sep 17 00:00:00 2001
From: Moritz Warning <moritzwarning@web.de>
Date: Sun, 9 Dec 2012 16:57:04 +0100
Subject: [PATCH] batman-adv netifd proto batadv

---
 batman-adv-devel/Makefile                          |    4 +--
 batman-adv-devel/files/etc/config/batman-adv       |    1 -
 .../files/etc/hotplug.d/iface/99-batman-adv        |   12 -------
 .../files/etc/hotplug.d/net/99-batman-adv          |    3 --
 batman-adv-devel/files/lib/batman-adv/config.sh    |   34 --------------------
 batman-adv-devel/files/lib/netifd/proto/batadv.sh  |   30 +++++++++++++++++
 6 files changed, 32 insertions(+), 52 deletions(-)
 delete mode 100644 batman-adv-devel/files/etc/hotplug.d/iface/99-batman-adv
 create mode 100644 batman-adv-devel/files/lib/netifd/proto/batadv.sh

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index e80b49a..7bbb75e 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -113,11 +113,11 @@ define Build/Clean
 endef
 
 define KernelPackage/batman-adv-devel/install
-	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/net $(1)/etc/hotplug.d/iface $(1)/lib/batman-adv $(1)/usr/sbin
+	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/net $(1)/etc/hotplug.d/iface $(1)/lib/batman-adv $(1)/usr/sbin $(1)/lib/netifd/proto
 	$(INSTALL_DATA) ./files/etc/config/batman-adv $(1)/etc/config
 	$(INSTALL_DATA) ./files/lib/batman-adv/config.sh $(1)/lib/batman-adv
 	$(INSTALL_BIN) ./files/etc/hotplug.d/net/99-batman-adv $(1)/etc/hotplug.d/net
-	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/99-batman-adv $(1)/etc/hotplug.d/iface
+	$(INSTALL_BIN) ./files/lib/netifd/proto/batadv.sh $(1)/lib/netifd/proto
 	$(INSTALL_BIN) ./files/usr/sbin/batman-adv $(1)/usr/sbin
 	$(BATCTL_INSTALL)
 endef
diff --git a/batman-adv-devel/files/etc/config/batman-adv b/batman-adv-devel/files/etc/config/batman-adv
index 6ec9e03..6a62203 100644
--- a/batman-adv-devel/files/etc/config/batman-adv
+++ b/batman-adv-devel/files/etc/config/batman-adv
@@ -1,6 +1,5 @@
 
 config 'mesh' 'bat0'
-	option 'interfaces' 'mesh'
 	option 'aggregated_ogms'
 	option 'ap_isolation'
 	option 'bonding'
diff --git a/batman-adv-devel/files/etc/hotplug.d/iface/99-batman-adv b/batman-adv-devel/files/etc/hotplug.d/iface/99-batman-adv
deleted file mode 100644
index 9206c42..0000000
--- a/batman-adv-devel/files/etc/hotplug.d/iface/99-batman-adv
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
-        ifup)
-                [ -d /sys/class/net/$DEVICE/batman_adv/ ] && config_foreach bat_add_interface mesh "$DEVICE"
-                ;;
-esac
diff --git a/batman-adv-devel/files/etc/hotplug.d/net/99-batman-adv b/batman-adv-devel/files/etc/hotplug.d/net/99-batman-adv
index 47132c1..f0c391f 100644
--- a/batman-adv-devel/files/etc/hotplug.d/net/99-batman-adv
+++ b/batman-adv-devel/files/etc/hotplug.d/net/99-batman-adv
@@ -9,7 +9,4 @@ case "$ACTION" in
 	add)
 		[ -d /sys/class/net/$INTERFACE/mesh/ ] && bat_config "$INTERFACE"
 		;;
-	remove)
-		[ -d /sys/class/net/$INTERFACE/batman_adv/ ] && config_foreach bat_del_interface mesh "$INTERFACE"
-		;;
 esac
diff --git a/batman-adv-devel/files/lib/batman-adv/config.sh b/batman-adv-devel/files/lib/batman-adv/config.sh
index 5260c01..ae102e9 100644
--- a/batman-adv-devel/files/lib/batman-adv/config.sh
+++ b/batman-adv-devel/files/lib/batman-adv/config.sh
@@ -44,37 +44,3 @@ bat_config()
 	[ -n "$orig_interval" ] && echo $orig_interval > /sys/class/net/$mesh/mesh/orig_interval
 	[ -n "$vis_mode" ] && echo $vis_mode > /sys/class/net/$mesh/mesh/vis_mode
 }
-
-bat_add_interface()
-{
-	local mesh="$1"
-	local interface="$2"
-	local interfaces
-
-	config_get interfaces $mesh interfaces
-	for iface in $interfaces; do
-		[ -f "/sys/class/net/$iface/batman_adv/mesh_iface" ] || {
-			iface=$(uci -q -P/var/state get network.$iface.ifname)
-			[ -f "/sys/class/net/$iface/batman_adv/mesh_iface" ] || continue
-		}
-	
-		[ "$iface" = "$interface" ] && echo $mesh > /sys/class/net/$iface/batman_adv/mesh_iface
-	done
-}
-
-bat_del_interface()
-{
-	local mesh="$1"
-	local interface="$2"
-	local interfaces
-
-	config_get interfaces $mesh interfaces
-	for iface in $interfaces; do
-		[ -f "/sys/class/net/$iface/batman_adv/mesh_iface" ] || {
-			iface=$(uci -q -P/var/state get network.$iface.ifname)
-			[ -f "/sys/class/net/$iface/batman_adv/mesh_iface" ] || continue
-		}
-
-		[ "$iface" = "$interface" ] && echo none > /sys/class/net/$iface/batman_adv/mesh_iface
-	done
-}
diff --git a/batman-adv-devel/files/lib/netifd/proto/batadv.sh b/batman-adv-devel/files/lib/netifd/proto/batadv.sh
new file mode 100644
index 0000000..632a209
--- /dev/null
+++ b/batman-adv-devel/files/lib/netifd/proto/batadv.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+. /lib/functions.sh
+. ../netifd-proto.sh
+init_proto "$@"
+
+proto_batadv_init_config() {
+	proto_config_add_string "mesh"
+}
+
+proto_batadv_setup() {
+	local config="$1"
+	local iface="$2"
+
+	local mesh
+	json_get_vars mesh
+
+	echo "$mesh" > "/sys/class/net/$iface/batman_adv/mesh_iface"
+	proto_init_update "$iface" 1
+	proto_send_update "$config"
+}
+
+proto_batadv_teardown() {
+	local config="$1"
+	local iface="$2"
+
+	echo "none" > "/sys/class/net/$iface/batman_adv/mesh_iface" || true
+}
+
+add_protocol batadv
-- 
1.7.10.4


--------------020009020101010803070203--
