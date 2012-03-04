Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Mar 2012 03:15:22 +0800
References: <1807712.xKAsDcUsSn@g10h4cklab>
	<201202121350.22380.lindner_marek@yahoo.de>
In-Reply-To: <201202121350.22380.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L97UPQoLZZ8Xkg/"
Message-Id: <201203050315.23089.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman openwrt
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
To: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--Boundary-00=_L97UPQoLZZ8Xkg/
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sunday, February 12, 2012 13:50:21 Marek Lindner wrote:
> On Saturday, February 11, 2012 08:36:22 Gioacchino Mazzurco wrote:
> > After upgrading to latest batman version on openwt batman stopped adding
> > ethernet or bridge interfaces at start...
> > 
> > it add only wireless interfaces
> 
> Last night we got to the bottom of this. The new hotplug based system is at
> the core of the issue: The Ethernet driver on the device is compiled into
> the kernel, thus loaded before the batman-adv kernel module is loaded. As
> a result the "interface add" event is triggered before batman-adv is
> active and the device can't be added to the batman-adv mesh.

Attached to this mail you'll find a patch for the hotplug scripts. Jow 
suggested to simply load the kernel module when it is not loaded. Could you 
test the patch and let me know whether it fixes your problem ?

Regards,
Marek


--Boundary-00=_L97UPQoLZZ8Xkg/
Content-Type: text/x-patch;
  charset="UTF-8";
  name="batman-adv_load-module-when-needed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="batman-adv_load-module-when-needed.patch"

--- a/batman-adv/files/lib/batman-adv/config.sh	(revision 30804)
+++ b/batman-adv/files/lib/batman-adv/config.sh	(working copy)
@@ -1,6 +1,15 @@
 #!/bin/sh
 
-bat_config(){
+bat_load_module()
+{
+	[ -d "/sys/module/batman_adv/" ] && return
+	
+	. /etc/functions.sh
+	load_modules /etc/modules.d/*-lib-crc16 /etc/modules.d/*-batman-adv	
+}
+
+bat_config()
+{
 	local mesh="$1"
 	local aggregated_ogms bonding fragmentation gw_bandwidth gw_mode gw_sel_class log_level orig_interval hop_penalty vis_mode
 
@@ -30,7 +39,8 @@
 	
 }
 
-bat_add_interface(){
+bat_add_interface()
+{
 	local mesh="$1"
 	local interface="$2"
 	local interfaces
@@ -47,7 +57,8 @@
 	done
 }
 
-bat_del_interface(){
+bat_del_interface()
+{
 	local mesh="$1"
 	local interface="$2"
 	local interfaces
--- a/batman-adv/files/usr/sbin/batman-adv	(revision 30804)
+++ b/batman-adv/files/usr/sbin/batman-adv	(working copy)
@@ -26,6 +26,7 @@
 
 # can also be used with "batman-adv start bat0"
 start() {
+	bat_load_module
 	config_load batman-adv
 
 	if [ -n "$1" ]; then
--- a/batman-adv/files/etc/hotplug.d/net/99-batman-adv	(revision 30804)
+++ b/batman-adv/files/etc/hotplug.d/net/99-batman-adv	(working copy)
@@ -2,6 +2,7 @@
 
 . /lib/batman-adv/config.sh
 
+bat_load_module
 config_load batman-adv
 
 case "$ACTION" in

--Boundary-00=_L97UPQoLZZ8Xkg/--
