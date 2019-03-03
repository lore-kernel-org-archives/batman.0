Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 18:02:55 +0100
Message-Id: <20190303170259.31798-2-sven@narfation.org>
In-Reply-To: <20190303170259.31798-1-sven@narfation.org>
References: <20190303170259.31798-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Drop documentation about
 debugfs files
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

The debugfs files were marked as deprecated by commit fee04b6f72cf
("batman-adv: Mark debugfs functionality as deprecated"). The documentation
should not advertise its usage anymore and instead promote the generic
netlink family and a userspace tool to access it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.rst | 29 ++++++++-----------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 245fb6c0..1b9ff47c 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -74,23 +74,9 @@ All mesh wide settings can be found in batman's own interface folder::
   bridge_loop_avoidance gw_sel_class  network_coding
   distributed_arp_table hop_penalty   orig_interval
 
-There is a special folder for debugging information::
-
-  $ ls /sys/kernel/debug/batman_adv/bat0/
-  bla_backbone_table log         neighbors         transtable_local
-  bla_claim_table    mcast_flags originators
-  dat_cache          nc          socket
-  gateways           nc_nodes    transtable_global
-
-Some of the files contain all sort of status information regarding the mesh
-network. For example, you can view the table of originators (mesh
-participants) with::
-
-  $ cat /sys/kernel/debug/batman_adv/bat0/originators
-
-Other files allow to change batman's behaviour to better fit your requirements.
-For instance, you can check the current originator interval (value in
-milliseconds which determines how often batman sends its broadcast packets)::
+Some files allow to change batman-adv's behaviour to better fit your
+requirements. For instance, you can check the current originator interval (value
+in milliseconds which determines how often batman sends its broadcast packets)::
 
   $ cat /sys/class/net/bat0/mesh/orig_interval
   1000
@@ -103,6 +89,10 @@ In very mobile scenarios, you might want to adjust the originator interval to a
 lower value. This will make the mesh more responsive to topology changes, but
 will also increase the overhead.
 
+Information about the current state can be accessed via the batadv generic
+netlink family. batctl provides human readable version via its debug tables
+subcommands.
+
 
 Usage
 =====
@@ -147,10 +137,9 @@ batman-adv module. When building batman-adv as part of kernel, use "make
 menuconfig" and enable the option ``B.A.T.M.A.N. debugging``
 (``CONFIG_BATMAN_ADV_DEBUG=y``).
 
-Those additional debug messages can be accessed using a special file in
-debugfs::
+Those additional debug messages can be accessed using the perf infrastructure::
 
-  $ cat /sys/kernel/debug/batman_adv/bat0/log
+  $ trace-cmd stream -e batadv:batadv_dbg
 
 The additional debug output is by default disabled. It can be enabled during
 run time. Following log_levels are defined:
-- 
2.20.1

