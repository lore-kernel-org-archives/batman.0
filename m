Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 12 Oct 2010 12:45:46 +0200
Message-Id: <1286880346-21477-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add batman-adv sysfs ABI
	documentation
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
To: b.a.t.m.a.n@lists.open-mesh.org

The kernel requires to have all files in /sys documented and updated
when new files are added.

batman-adv has two important classes of files: one class for each mesh
device and one for a directory in all normal netdevice folders.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Following files needs to be documented:
 * fragmentation
 * gw_mode

 batman-adv/sysfs-class-net-batman-adv |   14 ++++++++++++++
 batman-adv/sysfs-class-net-mesh       |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 batman-adv/sysfs-class-net-batman-adv
 create mode 100644 batman-adv/sysfs-class-net-mesh

diff --git a/batman-adv/sysfs-class-net-batman-adv b/batman-adv/sysfs-class-net-batman-adv
new file mode 100644
index 0000000..38dd762
--- /dev/null
+++ b/batman-adv/sysfs-class-net-batman-adv
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
diff --git a/batman-adv/sysfs-class-net-mesh b/batman-adv/sysfs-class-net-mesh
new file mode 100644
index 0000000..5aa1912
--- /dev/null
+++ b/batman-adv/sysfs-class-net-mesh
@@ -0,0 +1,33 @@
+
+What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Indicates whether the batman protocol messages of the
+                mesh <mesh_iface> shall be aggregated or not.
+
+What:           /sys/class/net/<mesh_iface>/mesh/bonding
+Date:           June 2010
+Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Description:
+                Indicates whether the data traffic going through the
+                mesh will be sent using multiple interfaces at the
+                same time (if available).
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
+                to activate the collecting (server) mode.
-- 
1.7.2.3

