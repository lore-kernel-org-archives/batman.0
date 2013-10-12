Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 12 Oct 2013 22:10:03 +0800
Message-Id: <1381587003-3538-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: update email address for Marek
	Lindner
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 README                     |  2 +-
 main.h                     |  2 +-
 sysfs-class-net-batman-adv |  4 ++--
 sysfs-class-net-mesh       | 12 ++++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/README b/README
index 89ace66..89490be 100644
--- a/README
+++ b/README
@@ -199,5 +199,5 @@ Mailing-list:   b.a.t.m.a.n@open-mesh.org (optional  subscription
 
 You can also contact the Authors:
 
-Marek  Lindner  <lindner_marek@yahoo.de>
+Marek  Lindner  <mareklindner@neomailbox.ch>
 Simon  Wunderlich  <sw@simonwunderlich.de>
diff --git a/main.h b/main.h
index ff39e46..811f5f8 100644
--- a/main.h
+++ b/main.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-#define BATADV_DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
+#define BATADV_DRIVER_AUTHOR "Marek Lindner <mareklindner@neomailbox.ch>, " \
 			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index bdc0070..7f34a95 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -1,13 +1,13 @@
 
 What:           /sys/class/net/<iface>/batman-adv/iface_status
 Date:           May 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Indicates the status of <iface> as it is seen by batman.
 
 What:           /sys/class/net/<iface>/batman-adv/mesh_iface
 Date:           May 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 The /sys/class/net/<iface>/batman-adv/mesh_iface file
                 displays the batman mesh interface this <iface>
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index 7982a31..0baa657 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -1,7 +1,7 @@
 
 What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
 Date:           May 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Indicates whether the batman protocol messages of the
                 mesh <mesh_iface> shall be aggregated or not.
@@ -42,21 +42,21 @@ Description:
 
 What:           /sys/class/net/<mesh_iface>/mesh/gw_bandwidth
 Date:           October 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Defines the bandwidth which is propagated by this
                 node if gw_mode was set to 'server'.
 
 What:           /sys/class/net/<mesh_iface>/mesh/gw_mode
 Date:           October 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Defines the state of the gateway features. Can be
                 either 'off', 'client' or 'server'.
 
 What:           /sys/class/net/<mesh_iface>/mesh/gw_sel_class
 Date:           October 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Defines the selection criteria this node will use
                 to choose a gateway if gw_mode was set to 'client'.
@@ -78,14 +78,14 @@ Description:
 
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Defines the interval in milliseconds in which batman
                 sends its protocol messages.
 
 What:           /sys/class/net/<mesh_iface>/mesh/routing_algo
 Date:           Dec 2011
-Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Contact:        Marek Lindner <mareklindner@neomailbox.ch>
 Description:
                 Defines the routing procotol this mesh instance
                 uses to find the optimal paths through the mesh.
-- 
1.8.4.rc3

