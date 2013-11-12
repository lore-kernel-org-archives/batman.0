Return-Path: <gui@altermundi.net>
Message-ID: <5282816E.9070109@altermundi.net>
Date: Tue, 12 Nov 2013 20:28:46 +0100
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <525B189E.1080105@altermundi.net>
 <201310141952.34222.sw@simonwunderlich.de>
In-Reply-To: <201310141952.34222.sw@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCHv2] alfred: optionally bundle a lua script for
 generating a bat-hosts
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
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

Provide a lua script that uses alfred to propagate and collect all
interface mac + names, then generate a /tmp/bat-hosts file.
If there's already a (probably hand-made) /etc/bat-hosts it won't overwrite it,
but if there's none, it will symlink /etc/bat-hosts -> /tmp/bat-hosts

Signed-off-by: Gui Iribarren <gui@altermundi.net>
Thanks-to: Joshua Head <joshua.head@outlook.com>
---

ChangeLog v2: make the script selectable through menuconfig, disabled by default

 alfred/Config.in           |    9 ++++
 alfred/Makefile            |    3 ++
 alfred/files/bat-hosts.lua |  107 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 alfred/files/bat-hosts.lua

diff --git a/alfred/Config.in b/alfred/Config.in
index 1791949..97f9ea2 100644
--- a/alfred/Config.in
+++ b/alfred/Config.in
@@ -1,3 +1,6 @@
+config ALFRED_NEEDS_lua
+	bool
+
 config ALFRED_NEEDS_libgps
 	bool
 
@@ -6,6 +9,12 @@ config PACKAGE_ALFRED_VIS
 	depends on PACKAGE_alfred
 	default y
 
+config PACKAGE_ALFRED_BATHOSTS
+	bool "enable autogeneration of /etc/bat-hosts"
+	depends on PACKAGE_alfred
+	select ALFRED_NEEDS_lua
+	default n
+
 config PACKAGE_ALFRED_GPSD
 	bool "enable gpsd service for alfred"
 	depends on PACKAGE_alfred
diff --git a/alfred/Makefile b/alfred/Makefile
index 67be82f..b6d8255 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -28,6 +28,7 @@ define Package/alfred
   CATEGORY:=Network
   TITLE:=A.L.F.R.E.D. - Almighty Lightweight Fact Remote Exchange Daemon
   DEPENDS:= +libc +IPV6:kmod-ipv6 +librt \
+	  +ALFRED_NEEDS_lua:lua \
 	  +ALFRED_NEEDS_libgps:libgps
 endef
 
@@ -77,6 +78,8 @@ define Package/alfred/install
 	$(INSTALL_BIN) ./files/alfred.init $(1)/etc/init.d/alfred
 	$(INSTALL_DIR) $(1)/etc/config
 	$(INSTALL_DATA) ./files/alfred.config $(1)/etc/config/alfred
+	$(INSTALL_DIR) $(1)/etc/alfred
+	[ "x$(CONFIG_PACKAGE_ALFRED_BATHOSTS)" == "xy" ] && $(INSTALL_BIN) ./files/bat-hosts.lua $(1)/etc/alfred/bat-hosts.lua ; true
 endef
 
 $(eval $(call BuildPackage,alfred))
diff --git a/alfred/files/bat-hosts.lua b/alfred/files/bat-hosts.lua
new file mode 100644
index 0000000..8648caf
--- /dev/null
+++ b/alfred/files/bat-hosts.lua
@@ -0,0 +1,107 @@
+#!/usr/bin/lua
+
+local type_id = 64 -- bat-hosts
+
+function get_hostname()
+  local hostfile = io.open("/proc/sys/kernel/hostname", "r")
+  local ret_string = hostfile:read()
+  hostfile:close()
+  return ret_string
+end
+
+function get_interfaces_names()
+  local ret = {}
+
+  for name in io.popen("ls -1 /sys/class/net/"):lines() do
+    table.insert(ret, name)
+  end
+
+  return ret
+end
+
+function get_interface_address(name)
+  local addressfile = io.open("/sys/class/net/"..name.."/address", "r")
+  local ret_string = addressfile:read()
+  addressfile:close()
+  return ret_string
+end
+
+
+local function generate_bat_hosts()
+-- get hostname and interface macs/names
+-- then return a table containing valid bat-hosts lines
+  local n, i
+  local ifaces, ret = {}, {}
+
+  local hostname = get_hostname()
+
+  for n, i in ipairs(get_interfaces_names()) do
+    local address = get_interface_address(i)
+    if not ifaces[address] then ifaces[address] = i end
+  end
+
+  for mac, iname in pairs(ifaces) do
+    if mac:match("^%x%x:%x%x:%x%x:%x%x:%x%x:%x%x$") and not mac:match("00:00:00:00:00:00") then
+      table.insert(ret, mac.." "..hostname.."_"..iname.."\n")
+    end
+  end
+
+  return ret
+end
+
+local function publish_bat_hosts()
+-- pass a raw chunk of data to alfred
+  local fd = io.popen("alfred -s " .. type_id, "w")
+  if fd then
+    local ret = generate_bat_hosts()
+    if ret then
+      fd:write(table.concat(ret))
+    end
+    fd:close()
+  end
+end
+
+local function write_bat_hosts(rows)
+  local content = { "### /tmp/bat-hosts generated by alfred-bat-hosts\n",
+                    "### /!\\ This file is overwritten every 5 minutes /!\\\n",
+                    "### (To keep manual changes, replace /etc/bat-hosts symlink with a static file)\n" }
+
+  -- merge the chunks from all nodes, de-escaping newlines
+  for _, row in ipairs(rows) do
+    local node, value = unpack(row)
+    table.insert(content, "# Node ".. node .. "\n")
+    table.insert(content, value:gsub("\x0a", "\n") .. "\n")
+  end
+
+  -- write parsed content down to disk
+  local fd = io.open("/tmp/bat-hosts", "w")
+  if fd then
+    fd:write(table.concat(content))
+    fd:close()
+  end
+
+  -- try to make a symlink in /etc pointing to /tmp,
+  -- if it exists, ln will do nothing.
+  os.execute("ln -ns /tmp/bat-hosts /etc/bat-hosts 2>/dev/null")
+end
+
+local function receive_bat_hosts()
+-- read raw chunks from alfred, convert them to a nested table and call write_bat_hosts
+  local fd = io.popen("alfred -r " .. type_id)
+    --[[ this command returns something like
+    { "54:e6:fc:b9:cb:37", "00:11:22:33:44:55 ham_wlan0\x0a00:22:33:22:33:22 ham_eth0\x0a" },
+    { "90:f6:52:bb:ec:57", "00:22:33:22:33:23 spam\x0a" },
+    ]]--
+
+  if fd then
+    local output = fd:read("*a")
+    if output then
+      assert(loadstring("rows = {" .. output .. "}"))()
+      write_bat_hosts(rows)
+    end
+    fd:close()
+  end
+end
+
+publish_bat_hosts()
+receive_bat_hosts()
-- 
1.7.10.4
