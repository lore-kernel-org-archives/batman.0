Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, 23 Nov 2012 11:00:47 -0300
Message-ID: <CAHD-aq+pkXDfaVXtvMtSV6OK-umobdvYrUMeVYkW1Rsh7uM7iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Boring bootlog at http://pastebin.com/59FEPttY

Proposed patch follows (against current batman-adv in openwrt 'packages' feed)

Signed-off-by: Gui Iribarren <gui@altermundi.net>

---
diff --git a/Makefile b/Makefile
index d12665e..e37467f 100644
--- a/Makefile
+++ b/Makefile
@@ -113,9 +113,10 @@ define KernelPackage/batman-adv/conffiles
 endef

 define KernelPackage/batman-adv/install
-    $(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/net
$(1)/lib/batman-adv $(1)/usr/sbin
+    $(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/iface
$(1)/etc/hotplug.d/net $(1)/lib/batman-adv $(1)/usr/sbin
     $(INSTALL_DATA) ./files/etc/config/batman-adv $(1)/etc/config
     $(INSTALL_DATA) ./files/lib/batman-adv/config.sh $(1)/lib/batman-adv
+    $(INSTALL_BIN) ./files/etc/hotplug.d/iface/99-batman-adv
$(1)/etc/hotplug.d/iface
     $(INSTALL_BIN) ./files/etc/hotplug.d/net/99-batman-adv
$(1)/etc/hotplug.d/net
     $(INSTALL_BIN) ./files/usr/sbin/batman-adv $(1)/usr/sbin
     $(BATCTL_INSTALL)
diff --git a/files/etc/hotplug.d/iface/99-batman-adv
b/files/etc/hotplug.d/iface/99-batman-adv
new file mode 100644
index 0000000..a4f4ed0
--- /dev/null
+++ b/files/etc/hotplug.d/iface/99-batman-adv
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+. /lib/batman-adv/config.sh
+
+bat_load_module
+config_load batman-adv
+
+case "$ACTION" in
+    ifup)
+        [ -d /sys/class/net/$DEVICE/batman_adv/ ] && config_foreach
bat_add_interface mesh "$DEVICE"
+        ;;
+    ifdown)
+        [ -d /sys/class/net/$DEVICE/batman_adv/ ] && config_foreach
bat_del_interface mesh "$DEVICE"
+        ;;
+esac
diff --git a/files/etc/hotplug.d/net/99-batman-adv
b/files/etc/hotplug.d/net/99-batman-adv
index 42d4c29..f0c391f 100644
--- a/files/etc/hotplug.d/net/99-batman-adv
+++ b/files/etc/hotplug.d/net/99-batman-adv
@@ -8,9 +8,5 @@ config_load batman-adv
 case "$ACTION" in
     add)
         [ -d /sys/class/net/$INTERFACE/mesh/ ] && bat_config "$INTERFACE"
-        [ -d /sys/class/net/$INTERFACE/batman_adv/ ] &&
config_foreach bat_add_interface mesh "$INTERFACE"
-        ;;
-    remove)
-        [ -d /sys/class/net/$INTERFACE/batman_adv/ ] &&
config_foreach bat_del_interface mesh "$INTERFACE"
         ;;
 esac
diff --git a/files/lib/batman-adv/config.sh b/files/lib/batman-adv/config.sh
index cb78867..646e953 100644
--- a/files/lib/batman-adv/config.sh
+++ b/files/lib/batman-adv/config.sh
@@ -50,7 +50,6 @@ bat_add_interface()
     local interface="$2"
     local interfaces

-    sleep 3s # some device (ath) is very lazy to start
     config_get interfaces $mesh interfaces
     for iface in $interfaces; do
         [ -f "/sys/class/net/$iface/batman_adv/mesh_iface" ] || {
