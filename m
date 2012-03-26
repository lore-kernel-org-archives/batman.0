Return-Path: <hexiled@nixbits.net>
Message-ID: <4F70E2EF.4060009@nixbits.net>
Date: Mon, 26 Mar 2012 17:43:11 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
References: <201203261241.32890.lindner_marek@yahoo.de>
In-Reply-To: <201203261241.32890.lindner_marek@yahoo.de>
Content-Type: multipart/mixed; boundary="------------000705020407080306070302"
Subject: [B.A.T.M.A.N.] batman-adv load module patch
Reply-To: HeXileD@nixbits.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 

This is a multi-part message in MIME format.
--------------000705020407080306070302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have been trying to apply the patch which tries to fix the openwrt scripts in regards having batman-adv to bring up all it's attached  interfaces but something seems not to be working.

Patch

------------------------------------------------------------------------

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


------------------------------------------------------------------------
The patch should be working with my current revision:

URL: svn://svn.openwrt.org/openwrt/branches/backfire
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 31071
Node Kind: directory
Schedule: normal
Last Changed Author: jow
Last Changed Rev: 30898
Last Changed Date: 2012-03-11 22:09:16 -0400 (Sun, 11 Mar 2012)

As it seemed to be for 30313
https://dev.openwrt.org/browser/branches/packages_10.03.2/net/batman-adv/files/lib/batman-adv/config.sh

However it fails

Path:
OPENWRT/backfire/feeds/packages/net/batman-adv/files/etc/hotplug.d/net/99-batman-adv
------------------------------------------------------------------------

$ patch -p2 < batman-adv_load-module-when-needed.patch 99-batman-adv 
patching file 99-batman-adv
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 30.
Hunk #3 FAILED at 47.
3 out of 3 hunks FAILED -- saving rejects to file 99-batman-adv.rej
patching file 99-batman-adv
Hunk #1 FAILED at 26.
1 out of 1 hunk FAILED -- saving rejects to file 99-batman-adv.rej
patching file 99-batman-adv


$ patch -p1< batman-adv_load-module-when-needed.patch 
can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--- a/batman-adv/files/lib/batman-adv/config.sh        (revision 30804)
|+++ b/batman-adv/files/lib/batman-adv/config.sh        (working copy)
--------------------------
File to patch: 99-batman-adv
patching file 99-batman-adv
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 30.
Hunk #3 FAILED at 47.
3 out of 3 hunks FAILED -- saving rejects to file 99-batman-adv.rej
can't find file to patch at input line 42
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--- a/batman-adv/files/usr/sbin/batman-adv     (revision 30804)
|+++ b/batman-adv/files/usr/sbin/batman-adv     (working copy)


Changing the patch number and increasing it does not work.

------------------------------------------------------------------------

99-batman-adv.rej

$ cat 99-batman-adv.rej
--- batman-adv/files/lib/batman-adv/config.sh   (revision 30804)
+++ batman-adv/files/lib/batman-adv/config.sh   (working copy)
@@ -1,6 +1,15 @@
 #!/bin/sh
 
-bat_config(){
+bat_load_module()
+{
+       [ -d "/sys/module/batman_adv/" ] && return
+       
+       . /etc/functions.sh
+       load_modules /etc/modules.d/*-lib-crc16 /etc/modules.d/*-batman-adv     
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


------------------------------------------------------------------------

Solutions?


--------------000705020407080306070302
Content-Type: text/x-patch;
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


--------------000705020407080306070302--
