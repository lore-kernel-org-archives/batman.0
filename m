Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  4 Nov 2010 18:21:04 +0100
Message-Id: <1288891265-16035-7-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011041820.44518.lindner_marek@yahoo.de>
References: <201011041820.44518.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] batman-adv: document gateway sysfs ABI
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/sysfs-class-net-mesh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/batman-adv/sysfs-class-net-mesh b/batman-adv/sysfs-class-net-mesh
index bd20e14..748fe17 100644
--- a/batman-adv/sysfs-class-net-mesh
+++ b/batman-adv/sysfs-class-net-mesh
@@ -22,6 +22,27 @@ Description:
                 mesh will be fragmented or silently discarded if the
                 packet size exceeds the outgoing interface MTU.
 
+What:           /sys/class/net/<mesh_iface>/mesh/gw_bandwidth
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the bandwidth which is propagated by this
+                node if gw_mode was set to 'server'.
+
+What:           /sys/class/net/<mesh_iface>/mesh/gw_mode
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the state of the gateway features. Can be
+                either 'off', 'client' or 'server'.
+
+What:           /sys/class/net/<mesh_iface>/mesh/gw_sel_class
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the selection criteria this node will use
+                to choose a gateway if gw_mode was set to 'client'.
+
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
-- 
1.7.1

