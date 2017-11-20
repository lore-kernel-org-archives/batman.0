Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:23 +0100
Message-Id: <20171120210223.9002-3-sven@narfation.org>
In-Reply-To: <20171120210223.9002-1-sven@narfation.org>
References: <20171120210223.9002-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Convert README to
 reStructuredText
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

The current format of the file is not well defined. The reStructuredText
format (as used by other batman-adv related files) has the benefit that it
is similar easy to read and write. And it allows other tools to parse the
content of the file and convert it in a sensible way to a different file
format.

Multiple git repository web-based management software also can directly
render these files as properly formatted HTML output.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.license       |   2 -
 README => README.rst | 311 +++++++++++++++++++++++++++------------------------
 2 files changed, 164 insertions(+), 149 deletions(-)
 delete mode 100644 README.license
 rename README => README.rst (55%)

diff --git a/README.license b/README.license
deleted file mode 100644
index a55d70e..0000000
--- a/README.license
+++ /dev/null
@@ -1,2 +0,0 @@
-SPDX-License-Identifier: GPL-2.0
-License-Filename: LICENSES/preferred/GPL-2.0
diff --git a/README b/README.rst
similarity index 55%
rename from README
rename to README.rst
index 28f3dc9..d7446a3 100644
--- a/README
+++ b/README.rst
@@ -1,12 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================
 A.L.F.R.E.D - Almighty Lightweight Fact Remote Exchange Daemon
---------------------------------------------------------------
+==============================================================
+
+    "alfred is a user space daemon to efficiently[tm] flood the network with
+    useless data - like vis, weather data, network notes, etc"
+
+    - Marek Lindner, 2012
 
-"alfred is a user space daemon to efficiently[tm] flood the network with
- useless data - like vis, weather data, network notes, etc"
-   - Marek Lindner, 2012
 
 Introduction
-------------
+============
 
 alfred is a user space daemon for distributing arbitrary local information over
 the mesh/network in a decentralized fashion. This data can be anything which
@@ -24,47 +29,51 @@ information available from all alfred servers in the network. Alternatively,
 alfred can be configured to distribute the local information via IPv4 multicast.
 This is configured by setting the IPv4 multicast group address in the -4 option.
 
+
 Compilation
------------
+===========
 
 alfred depends on:
- * librt (usually part of libc)
- * IPv6 support in the kernel/host system
- * libnl-3 - support for netlink sockets
- * libnl-3-genl - support for generic netlink messages
+
+* librt (usually part of libc)
+* IPv6 support in the kernel/host system
+* libnl-3 - support for netlink sockets
+* libnl-3-genl - support for generic netlink messages
 
 and optionally:
- * libgps - if you want to distribute GPS information
- * libcap - if you want extra security by dropping unneeded privileges
 
-To compile alfred, simply type:
+* libgps - if you want to distribute GPS information
+* libcap - if you want extra security by dropping unneeded privileges
+
+To compile alfred, simply type::
 
- $ make
+  $ make
 
-This will compile alfred, batadv-vis & alfred-gpsd. To install, use
+This will compile alfred, batadv-vis & alfred-gpsd. To install, use::
 
- $ make install
+  $ make install
 
 (with the right privileges).
 
-If you don't want to compile batadv-vis, add the directive CONFIG_ALFRED_VIS=n:
+If you don't want to compile batadv-vis, add the directive CONFIG_ALFRED_VIS=n::
 
- $ make CONFIG_ALFRED_VIS=n
- $ make CONFIG_ALFRED_VIS=n install
+  $ make CONFIG_ALFRED_VIS=n
+  $ make CONFIG_ALFRED_VIS=n install
 
 If you don't want to compile alfred-gpsd, add the directive
-CONFIG_ALFRED_GPSD=n:
+CONFIG_ALFRED_GPSD=n::
+
+  $ make CONFIG_ALFRED_GPSD=n
+  $ make CONFIG_ALFRED_GPSD=n install
 
- $ make CONFIG_ALFRED_GPSD=n
- $ make CONFIG_ALFRED_GPSD=n install
+If don't want to compile with libcap to drop privileges, use::
 
-If don't want to compile with libcap to drop privileges, use:
+  $ make CONFIG_ALFRED_CAPABILITIES=n
+  $ make CONFIG_ALFRED_CAPABILITIES=n install
 
- $ make CONFIG_ALFRED_CAPABILITIES=n
- $ make CONFIG_ALFRED_CAPABILITIES=n install
 
 Usage
------
+=====
 
 First, alfred must run as daemon (server) in background to be used. This can
 either be done by some init-scripts from your distribution (if you have
@@ -97,14 +106,14 @@ having all nodes in master mode is possible (for maximum decentrality and
 overhead).
 
 To put it together, let us start alfred in master mode on our bridge br0
-(assuming that this bridge includes the batman interface bat0):
+(assuming that this bridge includes the batman interface bat0)::
 
- $ alfred -i br0 -m
+  $ alfred -i br0 -m
 
 Now that the server is running, let us input some data. This can be done by
-using the alfred binary in client mode from the command line:
+using the alfred binary in client mode from the command line::
 
- $ cat /etc/hostname | alfred -s 64
+  $ cat /etc/hostname | alfred -s 64
 
 This will set the hostname as data for datatype 64. Note that 0 - 63 are
 reserved (please send us an e-mail if you want to register a datatype), and can
@@ -113,12 +122,13 @@ to assign a version to your data which can be filtered by other alfred users.
 Skipping the parameter entirely has the same effect as setting the parameter
 to 0 ('-V 0').
 
-After the hostname has been set on a few alfred hosts, the can be retrieved again:
+After the hostname has been set on a few alfred hosts, the can be retrieved
+again::
 
- $ alfred -r 64
-{ "fe:f1:00:00:01:01", "OpenWRT-node-1\x0a" },
-{ "fe:f1:00:00:02:01", "OpenWRT-node-2\x0a" },
-{ "fe:f1:00:00:03:01", "OpenWRT-node-3\x0a" },
+  $ alfred -r 64
+  { "fe:f1:00:00:01:01", "OpenWRT-node-1\x0a" },
+  { "fe:f1:00:00:02:01", "OpenWRT-node-2\x0a" },
+  { "fe:f1:00:00:03:01", "OpenWRT-node-3\x0a" },
 
 Note that the information must be periodically written again to alfred, otherwise
 it will timeout and alfred will forget about it (after 10 minutes).
@@ -129,8 +139,9 @@ unix sockets (client connects and talks to servers). On the other hand, "slaves"
 and "masters" are the roles alfred can take over in the network between different
 machines (slaves send information to masters).
 
+
 Vis
----
+===
 
 batadv-vis can be used to visualize your batman-adv mesh network. It read the
 neighbor information and local client table and distributes this information via
@@ -139,98 +150,100 @@ the whole picture of the network.
 
 batadv-vis, similar to to alfred, combines server (daemon) and client
 functionality in the 'batadv-vis' binary. The batadv-vis server must be started
-to let batadv-vis work:
+to let batadv-vis work::
 
- $ batadv-vis -i bat0 -s
+  $ batadv-vis -i bat0 -s
 
 This server will read the neighbor and client information from batman-adv every
 10 seconds and set it in alfred via unix socket. Obviously, the alfred server
 must run too to get this information set.
 
-To get a graphviz-compatible vis output, simply type:
- $ batadv-vis
-digraph {
-        subgraph "cluster_fe:f0:00:00:04:01" {
-                "fe:f0:00:00:04:01"
-        }
-        "fe:f0:00:00:04:01" -> "fe:f0:00:00:05:01" [label="1.000"]
-        "fe:f0:00:00:04:01" -> "fe:f0:00:00:03:01" [label="1.004"]
-        "fe:f0:00:00:04:01" -> "00:00:43:05:00:04" [label="TT"]
-        "fe:f0:00:00:04:01" -> "fe:f1:00:00:04:01" [label="TT"]
-        subgraph "cluster_fe:f0:00:00:02:01" {
-                "fe:f0:00:00:02:01"
-        }
-        "fe:f0:00:00:02:01" -> "fe:f0:00:00:03:01" [label="1.000"]
-        "fe:f0:00:00:02:01" -> "fe:f0:00:00:01:01" [label="1.008"]
-        "fe:f0:00:00:02:01" -> "fe:f0:00:00:08:01" [label="1.000"]
-        "fe:f0:00:00:02:01" -> "fe:f1:00:00:02:01" [label="TT"]
-        "fe:f0:00:00:02:01" -> "00:00:43:05:00:02" [label="TT"]
-        subgraph "cluster_fe:f0:00:00:08:01" {
-                "fe:f0:00:00:08:01"
-        }
-[...]
-}
-
-For a json line formatted output, use:
-
- $ batadv-vis -f json
-{ "primary" : "fe:f0:00:00:04:01" }
-{ "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:05:01", "label" : "1.000" }
-{ "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.008" }
-{ "router" : "fe:f0:00:00:04:01", "gateway" : "00:00:43:05:00:04", "label" : "TT" }
-{ "router" : "fe:f0:00:00:04:01", "gateway" : "fe:f1:00:00:04:01", "label" : "TT" }
-{ "primary" : "fe:f0:00:00:02:01" }
-{ "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.000" }
-{ "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:01:01", "label" : "1.016" }
-{ "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:08:01", "label" : "1.000" }
-{ "router" : "fe:f0:00:00:02:01", "gateway" : "fe:f1:00:00:02:01", "label" : "TT" }
-{ "router" : "fe:f0:00:00:02:01", "gateway" : "00:00:43:05:00:02", "label" : "TT" }
-{ "primary" : "fe:f0:00:00:08:01" }
-[...]
-
-and for output where the complete document is json, use:
-
- $ batadv-vis -f jsondoc
-{
-  "source_version" : "2013.3.0-14-gcd34783",
-  "algorithm" : 4,
-  "vis" : [
-    { "primary" : "fe:f0:00:00:04:01",
-      "neighbors" : [
-         { "router" : "fe:f0:00:00:04:01",
-           "neighbor" : "fe:f0:00:00:05:01",
-           "metric" : "1.000" },
-         { "router" : "fe:f0:00:00:04:01",
-           "neighbor" : "fe:f0:00:00:03:01",
-           "metric" : "1.008" }
-      ],
-      "clients" : [
-         "00:00:43:05:00:04",
-         "fe:f1:00:00:04:01"
-      ]
-    },
-    { "primary" : "fe:f0:00:00:02:01",
-      "neighbors" : [
-         { "router" : "fe:f0:00:00:02:01",
-           "neighbor" : "fe:f0:00:00:03:01",
-  	 "metric" : "1.000" },
-         { "router" : "fe:f0:00:00:02:01",
-           "neighbor" : "fe:f0:00:00:01:01",
-           "metric" : "1.016" },
-         { "router" : "fe:f0:00:00:02:01",
-           "neighbor" : "fe:f0:00:00:08:01",
-           "metric" : "1.000" }
-      ],
-      "clients" : [
-        "fe:f1:00:00:02:01",
-        "00:00:43:05:00:02"
-      ]
-    },
-    { "primary" : "fe:f0:00:00:08:01",
-[...]
+To get a graphviz-compatible vis output, simply type::
+
+  $ batadv-vis
+  digraph {
+          subgraph "cluster_fe:f0:00:00:04:01" {
+                  "fe:f0:00:00:04:01"
+          }
+          "fe:f0:00:00:04:01" -> "fe:f0:00:00:05:01" [label="1.000"]
+          "fe:f0:00:00:04:01" -> "fe:f0:00:00:03:01" [label="1.004"]
+          "fe:f0:00:00:04:01" -> "00:00:43:05:00:04" [label="TT"]
+          "fe:f0:00:00:04:01" -> "fe:f1:00:00:04:01" [label="TT"]
+          subgraph "cluster_fe:f0:00:00:02:01" {
+                  "fe:f0:00:00:02:01"
+          }
+          "fe:f0:00:00:02:01" -> "fe:f0:00:00:03:01" [label="1.000"]
+          "fe:f0:00:00:02:01" -> "fe:f0:00:00:01:01" [label="1.008"]
+          "fe:f0:00:00:02:01" -> "fe:f0:00:00:08:01" [label="1.000"]
+          "fe:f0:00:00:02:01" -> "fe:f1:00:00:02:01" [label="TT"]
+          "fe:f0:00:00:02:01" -> "00:00:43:05:00:02" [label="TT"]
+          subgraph "cluster_fe:f0:00:00:08:01" {
+                  "fe:f0:00:00:08:01"
+          }
+  [...]
+  }
+
+For a json line formatted output, use::
+
+  $ batadv-vis -f json
+  { "primary" : "fe:f0:00:00:04:01" }
+  { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:05:01", "label" : "1.000" }
+  { "router" : "fe:f0:00:00:04:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.008" }
+  { "router" : "fe:f0:00:00:04:01", "gateway" : "00:00:43:05:00:04", "label" : "TT" }
+  { "router" : "fe:f0:00:00:04:01", "gateway" : "fe:f1:00:00:04:01", "label" : "TT" }
+  { "primary" : "fe:f0:00:00:02:01" }
+  { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:03:01", "label" : "1.000" }
+  { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:01:01", "label" : "1.016" }
+  { "router" : "fe:f0:00:00:02:01", "neighbor" : "fe:f0:00:00:08:01", "label" : "1.000" }
+  { "router" : "fe:f0:00:00:02:01", "gateway" : "fe:f1:00:00:02:01", "label" : "TT" }
+  { "router" : "fe:f0:00:00:02:01", "gateway" : "00:00:43:05:00:02", "label" : "TT" }
+  { "primary" : "fe:f0:00:00:08:01" }
+  [...]
+
+and for output where the complete document is json, use::
+
+  $ batadv-vis -f jsondoc
+  {
+    "source_version" : "2013.3.0-14-gcd34783",
+    "algorithm" : 4,
+    "vis" : [
+      { "primary" : "fe:f0:00:00:04:01",
+        "neighbors" : [
+           { "router" : "fe:f0:00:00:04:01",
+             "neighbor" : "fe:f0:00:00:05:01",
+             "metric" : "1.000" },
+           { "router" : "fe:f0:00:00:04:01",
+             "neighbor" : "fe:f0:00:00:03:01",
+             "metric" : "1.008" }
+        ],
+        "clients" : [
+           "00:00:43:05:00:04",
+           "fe:f1:00:00:04:01"
+        ]
+      },
+      { "primary" : "fe:f0:00:00:02:01",
+        "neighbors" : [
+           { "router" : "fe:f0:00:00:02:01",
+             "neighbor" : "fe:f0:00:00:03:01",
+             "metric" : "1.000" },
+           { "router" : "fe:f0:00:00:02:01",
+             "neighbor" : "fe:f0:00:00:01:01",
+             "metric" : "1.016" },
+           { "router" : "fe:f0:00:00:02:01",
+             "neighbor" : "fe:f0:00:00:08:01",
+             "metric" : "1.000" }
+        ],
+        "clients" : [
+          "fe:f1:00:00:02:01",
+          "00:00:43:05:00:02"
+        ]
+      },
+      { "primary" : "fe:f0:00:00:08:01",
+  [...]
+
 
 Alfred-gpsd
------------
+===========
 
 Alfred-gpsd can be used to distibute GPS location information about
 your batman-adv mesh network. This information could be, for example,
@@ -242,31 +255,32 @@ on the command line, which is useful for static nodes without a GPS.
 Alfred-gpsd, similar to to alfred, combines server (daemon) and client
 functionality in the 'alfred-gpsd' binary. The alfred-gpsd server must
 be started to distribute location information. When retrieving
-location information from gpsd, it should be started with:
+location information from gpsd, it should be started with::
 
- $ alfred-gpsd -s
+  $ alfred-gpsd -s
 
-For a static location, use:
+For a static location, use::
 
- $ alfred-gpsd -s -l 48.858222,2.2945,358
+  $ alfred-gpsd -s -l 48.858222,2.2945,358
 
 This server will set the location in alfred via unix
 socket. Obviously, the alfred server must run too to get this
 information set. When using gpsd, it updates alfred every 2
 seconds. With a static location, the update it made every 5 minutes.
 
-To get JSON formatted output, use:
+To get JSON formatted output, use::
 
- $ alfred-gpsd
-[
-  { "source" : "f6:00:48:13:d3:1e", "tpv" : {"class":"TPV","tag":"RMC","device":"/dev/ttyACM0","mode":3,"time":"2013-10-01T10:43:20.000Z","ept":0.005,"lat":52.575485000,"lon":-1.339716667,"alt":122.500,"epx":10.199,"epy":15.720,"epv":31.050,"track":0.0000,"speed":0.010,"climb":0.000,"eps":31.44} },
-  { "source" : "8e:4c:77:b3:65:b4", "tpv" : {"class":"TPV","device":"command line","time":"2013-10-01T10:43:05.129Z","lat":48.858222,"lon":2.2945,"alt":358.000000,"mode":3} }
-]
+  $ alfred-gpsd
+  [
+    { "source" : "f6:00:48:13:d3:1e", "tpv" : {"class":"TPV","tag":"RMC","device":"/dev/ttyACM0","mode":3,"time":"2013-10-01T10:43:20.000Z","ept":0.005,"lat":52.575485000,"lon":-1.339716667,"alt":122.500,"epx":10.199,"epy":15.720,"epv":31.050,"track":0.0000,"speed":0.010,"climb":0.000,"eps":31.44} },
+    { "source" : "8e:4c:77:b3:65:b4", "tpv" : {"class":"TPV","device":"command line","time":"2013-10-01T10:43:05.129Z","lat":48.858222,"lon":2.2945,"alt":358.000000,"mode":3} }
+  ]
 
 See gpsd_json(5) for documentation of the tpv object.
 
+
 Running alfred as non-root user
--------------------------------
+===============================
 
 Alfred currently requires special capabilities and access rights to work
 correctly. The user root is normally the only user having these
@@ -274,25 +288,26 @@ capabilities/rights on a standard Linux system.
 
 Operations requiring special capabilities:
 
- * bind to device
- * creating the unix socket
- * accessing the debugfs filesystem
+* bind to device
+* creating the unix socket
+* accessing the debugfs filesystem
 
 The first operation can still be executed when the admin grants the special
 capability CAP_NET_RAW+CAP_NET_ADMIN to anyone executing the alfred binary.
 The unix socket can also be moved using the parameter '-u' to a different
-directory which can be accessed by the user.
+directory which can be accessed by the user::
 
- $ sudo setcap cap_net_admin,cap_net_raw+ep alfred
- $ ./alfred -u alfred.sock -i eth0
+  $ sudo setcap cap_net_admin,cap_net_raw+ep alfred
+  $ ./alfred -u alfred.sock -i eth0
 
 The user running alfred must still be in a group which is allowed to access
 /sys/kernel/debugfs to correctly choose best neighbors for communication.
 It is possible (but not recommended) to disable the neighbor
 selection/prioritization using the parameter '-b none'.
 
+
 License
--------
+=======
 
 alfred, batadv-vis and alfred-gpsd are licensed under the terms of version 2
 of the GNU General Public License (GPL). Please see the LICENSE file.
@@ -303,23 +318,25 @@ programs to include this header file (e.g. for communicating with alfred via
 unix sockets) without enforcing the restrions of the GPL license on this third
 party program.
 
+
 Contact
--------
+=======
 
 As alfred was developed to help on batman-adv, we share communication channels.
 Please send us comments, experiences, questions, anything :)
 
-IRC:            #batman   on   irc.freenode.org
-Mailing-list:   b.a.t.m.a.n@lists.open-mesh.org (optional  subscription
-                at https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
+IRC:
+  #batman on irc.freenode.org
+Mailing-list:
+  b.a.t.m.a.n@open-mesh.org (optional subscription at
+  https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n)
 
-If you have test reports/patches/ideas, please read the wiki for further instruction
-on how to contribute:
+If you have test reports/patches/ideas, please read the wiki for further
+instruction on how to contribute:
 
 https://www.open-mesh.org/projects/open-mesh/wiki/Contribute
 
 You can also contact the Authors:
 
-Simon Wunderlich <sw@simonwunderlich.de>
-Sven Eckelmann <sven@open-mesh.com>
-
+* Marek Lindner <mareklindner@neomailbox.ch>
+* Simon Wunderlich <sw@simonwunderlich.de>
-- 
2.11.0

