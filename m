Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 16:17:13 +0200
Message-Id: <1274537833-2512-10-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221616.46785.sven.eckelmann@gmx.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] Documentation: ABI: Add information
	about batman-adv sysfs entries
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
To: gregkh@suse.de
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Add documents about new sysfs entries in
 * /sys/class/net/<iface>/batman-adv/mesh_iface
 * /sys/class/net/<mesh_iface>/mesh/vis_mode

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 .../ABI/testing/sysfs-class-net-batman-adv         |   14 ++++++++++
 Documentation/ABI/testing/sysfs-class-net-mesh     |   27 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-batman-adv
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-mesh

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
new file mode 100644
index 0000000..38dd762
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -0,0 +1,14 @@
+
+What:           /sys/class/net/<iface>/batman-adv/mesh_iface
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                The /sys/class/net/<iface>/batman-adv/mesh_iface file
+                displays the batman mesh interface this <iface>
+                currently is associated with.
+
+What:           /sys/class/net/<iface>/batman-adv/iface_status
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Indicates the status of <iface> as it is seen by batman.
diff --git a/Documentation/ABI/testing/sysfs-class-net-mesh b/Documentation/ABI/testing/sysfs-class-net-mesh
new file mode 100644
index 0000000..0d96c9d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-mesh
@@ -0,0 +1,27 @@
+
+What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Indicates whether the batman protocol messages of the
+                mesh <mesh_iface> shall be aggregated or not.
+
+What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the interval in milliseconds in which batman
+                sends its protocol messages.
+
+What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Each batman node only maintains information about its
+                own local neighborhood, therefore generating graphs
+                showing the topology of the entire mesh is not easily
+                feasible without having a central instance to collect
+                the local topologies from all nodes. This file allows
+                to activate the collecting (server) mode. Once
+                activated the topology can be retrieved by reading
+                the vis_data file.
-- 
1.7.1

