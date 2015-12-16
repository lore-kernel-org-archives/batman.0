Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 17 Dec 2015 00:20:32 +0100
Message-Id: <1450308032-17634-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next] batman-adv: update email address
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

From: Antonio Quartulli <antonio@meshcoding.com>

My personal email address has changed. Update it in the doc files

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 Documentation/ABI/testing/sysfs-class-net-mesh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-mesh b/Documentation/ABI/testing/sysfs-class-net-mesh
index c464062..c2b956d 100644
--- a/Documentation/ABI/testing/sysfs-class-net-mesh
+++ b/Documentation/ABI/testing/sysfs-class-net-mesh
@@ -8,7 +8,7 @@ Description:
 
 What:           /sys/class/net/<mesh_iface>/mesh/<vlan_subdir>/ap_isolation
 Date:           May 2011
-Contact:        Antonio Quartulli <antonio@meshcoding.com>
+Contact:        Antonio Quartulli <a@unstable.cc>
 Description:
                 Indicates whether the data traffic going from a
                 wireless client to another wireless client will be
@@ -70,7 +70,7 @@ Description:
 
 What:		/sys/class/net/<mesh_iface>/mesh/isolation_mark
 Date:		Nov 2013
-Contact:	Antonio Quartulli <antonio@meshcoding.com>
+Contact:	Antonio Quartulli <a@unstable.cc>
 Description:
 		Defines the isolation mark (and its bitmask) which
 		is used to classify clients as "isolated" by the
-- 
2.6.4

