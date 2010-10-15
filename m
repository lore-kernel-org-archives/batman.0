Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 15 Oct 2010 17:56:12 +0200
Message-Id: <1287158172-15920-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201010151749.01120.lindner_marek@yahoo.de>
References: <201010151749.01120.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: document fragmentation sysfs API
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
 batman-adv/sysfs-class-net-mesh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/batman-adv/sysfs-class-net-mesh b/batman-adv/sysfs-class-net-mesh
index 5aa1912..b4cdb60 100644
--- a/batman-adv/sysfs-class-net-mesh
+++ b/batman-adv/sysfs-class-net-mesh
@@ -14,6 +14,14 @@ Description:
                 mesh will be sent using multiple interfaces at the
                 same time (if available).
 
+What:           /sys/class/net/<mesh_iface>/mesh/fragmentation
+Date:           October 2010
+Contact:        Andreas Langer <an.langer@gmx.de>
+Description:
+                Indicates whether the data traffic going through the
+                mesh will be fragmented or silently discarded if the
+                packet size exceeds the outgoing interface MTU.
+
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
-- 
1.7.1

