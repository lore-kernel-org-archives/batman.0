Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 21 Oct 2012 17:02:25 +0800
Message-Id: <1350810145-26632-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BPATCH=5D_batman-adv=3A_sysfs_document?=
	=?utf-8?q?ation_should_keep_alphabetical_order?=
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 sysfs-class-net-batman-adv |   11 ++++++-----
 sysfs-class-net-mesh       |   40 ++++++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index 38dd762..bdc0070 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -1,4 +1,10 @@
 
+What:           /sys/class/net/<iface>/batman-adv/iface_status
+Date:           May 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Indicates the status of <iface> as it is seen by batman.
+
 What:           /sys/class/net/<iface>/batman-adv/mesh_iface
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
@@ -7,8 +13,3 @@ Description:
                 displays the batman mesh interface this <iface>
                 currently is associated with.
 
-What:           /sys/class/net/<iface>/batman-adv/iface_status
-Date:           May 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
-Description:
-                Indicates the status of <iface> as it is seen by batman.
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index c81fe89..bc41da6 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -6,6 +6,14 @@ Description:
                 Indicates whether the batman protocol messages of the
                 mesh <mesh_iface> shall be aggregated or not.
 
+What:           /sys/class/net/<mesh_iface>/mesh/ap_isolation
+Date:           May 2011
+Contact:        Antonio Quartulli <ordex@autistici.org>
+Description:
+                Indicates whether the data traffic going from a
+                wireless client to another wireless client will be
+                silently dropped.
+
 What:           /sys/class/net/<mesh_iface>/mesh/bonding
 Date:           June 2010
 Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
@@ -31,14 +39,6 @@ Description:
                 mesh will be fragmented or silently discarded if the
                 packet size exceeds the outgoing interface MTU.
 
-What:		/sys/class/net/<mesh_iface>/mesh/ap_isolation
-Date:		May 2011
-Contact:	Antonio Quartulli <ordex@autistici.org>
-Description:
-		Indicates whether the data traffic going from a
-		wireless client to another wireless client will be
-		silently dropped.
-
 What:           /sys/class/net/<mesh_iface>/mesh/gw_bandwidth
 Date:           October 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
@@ -60,6 +60,13 @@ Description:
                 Defines the selection criteria this node will use
                 to choose a gateway if gw_mode was set to 'client'.
 
+What:           /sys/class/net/<mesh_iface>/mesh/hop_penalty
+Date:           Oct 2010
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                Defines the penalty which will be applied to an
+                originator message's tq-field on every hop.
+
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
@@ -67,19 +74,12 @@ Description:
                 Defines the interval in milliseconds in which batman
                 sends its protocol messages.
 
-What:           /sys/class/net/<mesh_iface>/mesh/hop_penalty
-Date:           Oct 2010
-Contact:        Linus Lüssing <linus.luessing@web.de>
-Description:
-		Defines the penalty which will be applied to an
-		originator message's tq-field on every hop.
-
-What:		/sys/class/net/<mesh_iface>/mesh/routing_algo
-Date:		Dec 2011
-Contact:	Marek Lindner <lindner_marek@yahoo.de>
+What:           /sys/class/net/<mesh_iface>/mesh/routing_algo
+Date:           Dec 2011
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
 Description:
-		Defines the routing procotol this mesh instance
-		uses to find the optimal paths through the mesh.
+                Defines the routing procotol this mesh instance
+                uses to find the optimal paths through the mesh.
 
 What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
 Date:           May 2010
-- 
1.7.10.4

