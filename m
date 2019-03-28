Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:41:45 +0100
Message-Id: <20190328154152.20552-6-sw@simonwunderlich.de>
In-Reply-To: <20190328154152.20552-1-sw@simonwunderlich.de>
References: <20190328154152.20552-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/12] batman-adv: ABI: Mark sysfs files as
 deprecated
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The sysfs files are replaced by the batadv generic netlink family. The old
sysfs configuration interface was frowned upon by other kernel developers.
But the files cannot be removed immediately because userspace tools might
still depend on it. Instead schedule for its removal in 2021.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/ABI/{testing => obsolete}/sysfs-class-net-batman-adv | 2 ++
 Documentation/ABI/{testing => obsolete}/sysfs-class-net-mesh       | 2 ++
 MAINTAINERS                                                        | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-batman-adv (92%)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-mesh (97%)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/obsolete/sysfs-class-net-batman-adv
similarity index 92%
rename from Documentation/ABI/testing/sysfs-class-net-batman-adv
rename to Documentation/ABI/obsolete/sysfs-class-net-batman-adv
index 898106849e27..5bdbc8d40256 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/obsolete/sysfs-class-net-batman-adv
@@ -1,3 +1,5 @@
+This ABI is deprecated and will be removed after 2021. It is
+replaced with the batadv generic netlink family.
 
 What:           /sys/class/net/<iface>/batman-adv/elp_interval
 Date:           Feb 2014
diff --git a/Documentation/ABI/testing/sysfs-class-net-mesh b/Documentation/ABI/obsolete/sysfs-class-net-mesh
similarity index 97%
rename from Documentation/ABI/testing/sysfs-class-net-mesh
rename to Documentation/ABI/obsolete/sysfs-class-net-mesh
index c2b956d44a95..04c1a2932507 100644
--- a/Documentation/ABI/testing/sysfs-class-net-mesh
+++ b/Documentation/ABI/obsolete/sysfs-class-net-mesh
@@ -1,3 +1,5 @@
+This ABI is deprecated and will be removed after 2021. It is
+replaced with the batadv generic netlink family.
 
 What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
 Date:           May 2010
diff --git a/MAINTAINERS b/MAINTAINERS
index f8ff9ae52c21..fce2919582fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2795,8 +2795,8 @@ L:	b.a.t.m.a.n@lists.open-mesh.org (moderated for non-subscribers)
 W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
-F:	Documentation/ABI/testing/sysfs-class-net-mesh
+F:	Documentation/ABI/obsolete/sysfs-class-net-batman-adv
+F:	Documentation/ABI/obsolete/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.rst
 F:	include/uapi/linux/batadv_packet.h
 F:	include/uapi/linux/batman_adv.h
-- 
2.11.0

