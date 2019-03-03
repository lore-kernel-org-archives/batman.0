Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 18:02:56 +0100
Message-Id: <20190303170259.31798-3-sven@narfation.org>
In-Reply-To: <20190303170259.31798-1-sven@narfation.org>
References: <20190303170259.31798-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Drop documentation about
 sysfs files
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

The sysfs files will be marked as deprecated in the near future. They
are already replaced by the batadv generic netlink family. The
documentation should not advertise its usage anymore and instead
promote the generic netlink family and a userspace tool to access it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.rst | 91 +++++++------------------
 1 file changed, 24 insertions(+), 67 deletions(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 1b9ff47c..18020943 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -27,24 +27,8 @@ Load the batman-adv module into your kernel::
   $ insmod batman-adv.ko
 
 The module is now waiting for activation. You must add some interfaces on which
-batman can operate. After loading the module batman advanced will scan your
-systems interfaces to search for compatible interfaces. Once found, it will
-create subfolders in the ``/sys`` directories of each supported interface,
-e.g.::
-
-  $ ls /sys/class/net/eth0/batman_adv/
-  elp_interval iface_status mesh_iface throughput_override
-
-If an interface does not have the ``batman_adv`` subfolder, it probably is not
-supported. Not supported interfaces are: loopback, non-ethernet and batman's
-own interfaces.
-
-Note: After the module was loaded it will continuously watch for new
-interfaces to verify the compatibility. There is no need to reload the module
-if you plug your USB wifi adapter into your machine after batman advanced was
-initially loaded.
-
-The batman-adv soft-interface can be created using the iproute2 tool ``ip``::
+batman-adv can operate. The batman-adv soft-interface can be created using the
+iproute2 tool ``ip``::
 
   $ ip link add name bat0 type batadv
 
@@ -52,38 +36,37 @@ To activate a given interface simply attach it to the ``bat0`` interface::
 
   $ ip link set dev eth0 master bat0
 
-Repeat this step for all interfaces you wish to add. Now batman starts
+Repeat this step for all interfaces you wish to add. Now batman-adv starts
 using/broadcasting on this/these interface(s).
 
-By reading the "iface_status" file you can check its status::
-
-  $ cat /sys/class/net/eth0/batman_adv/iface_status
-  active
-
 To deactivate an interface you have to detach it from the "bat0" interface::
 
   $ ip link set dev eth0 nomaster
 
+The same can also be done using the batctl interface subcommand::
+
+  batctl -m bat0 interface create
+  batctl -m bat0 interface add -M eth0
+
+To detach eth0 and destroy bat0::
 
-All mesh wide settings can be found in batman's own interface folder::
+  batctl -m bat0 interface del -M eth0
+  batctl -m bat0 interface destroy
 
-  $ ls /sys/class/net/bat0/mesh/
-  aggregated_ogms       fragmentation isolation_mark routing_algo
-  ap_isolation          gw_bandwidth  log_level      vlan0
-  bonding               gw_mode       multicast_mode
-  bridge_loop_avoidance gw_sel_class  network_coding
-  distributed_arp_table hop_penalty   orig_interval
+There are additional settings for each batadv mesh interface, vlan and hardif
+which can be modified using batctl. Detailed information about this can be found
+in its manual.
 
-Some files allow to change batman-adv's behaviour to better fit your
-requirements. For instance, you can check the current originator interval (value
-in milliseconds which determines how often batman sends its broadcast packets)::
+For instance, you can check the current originator interval (value
+in milliseconds which determines how often batman-adv sends its broadcast
+packets)::
 
-  $ cat /sys/class/net/bat0/mesh/orig_interval
+  $ batctl -M bat0 orig_interval
   1000
 
 and also change its value::
 
-  $ echo 3000 > /sys/class/net/bat0/mesh/orig_interval
+  $ batctl -M bat0 orig_interval 3000
 
 In very mobile scenarios, you might want to adjust the originator interval to a
 lower value. This will make the mesh more responsive to topology changes, but
@@ -142,37 +125,11 @@ Those additional debug messages can be accessed using the perf infrastructure::
   $ trace-cmd stream -e batadv:batadv_dbg
 
 The additional debug output is by default disabled. It can be enabled during
-run time. Following log_levels are defined:
-
-.. flat-table::
-
-   * - 0
-     - All debug output disabled
-   * - 1
-     - Enable messages related to routing / flooding / broadcasting
-   * - 2
-     - Enable messages related to route added / changed / deleted
-   * - 4
-     - Enable messages related to translation table operations
-   * - 8
-     - Enable messages related to bridge loop avoidance
-   * - 16
-     - Enable messages related to DAT, ARP snooping and parsing
-   * - 32
-     - Enable messages related to network coding
-   * - 64
-     - Enable messages related to multicast
-   * - 128
-     - Enable messages related to throughput meter
-   * - 255
-     - Enable all messages
-
-The debug output can be changed at runtime using the file
-``/sys/class/net/bat0/mesh/log_level``. e.g.::
-
-  $ echo 6 > /sys/class/net/bat0/mesh/log_level
-
-will enable debug messages for when routes change.
+run time::
+
+  $ batctl -m bat0 loglevel routes tt
+
+will enable debug messages for when routes and translation table entries change.
 
 Counters for different types of packets entering and leaving the batman-adv
 module are available through ethtool::
-- 
2.20.1

