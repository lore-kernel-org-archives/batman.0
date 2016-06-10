Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 23:00:56 +0200
Message-Id: <1465592459-9474-2-git-send-email-sven@narfation.org>
In-Reply-To: <1465592459-9474-1-git-send-email-sven@narfation.org>
References: <1465592459-9474-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 2/5] batman-adv: Use rtnl link in device
	creation example
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

The standard kernel API to add new virtual interfaces and attach other
interfaces to it is rtnl-link. batman-adv supports it since v3.10. This
functionality should be used instead of the legacy batman-adv-only sysfs
interface.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v4:
 - rebase on top of current master
v3:
 - rebased on top of current master to fix conflicts with newest patches
v2:
 - rebased on top of current master to fix conflicts with newest patches
---
 Documentation/networking/batman-adv.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 1b5e7a7..8a8d3d9 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -43,10 +43,15 @@ new interfaces to verify the compatibility. There is no  need  to
 reload the module if you plug your USB wifi adapter into your ma-
 chine after batman advanced was initially loaded.
 
-To activate a  given  interface  simply  write  "bat0"  into  its
-"mesh_iface" file inside the batman_adv subfolder:
+The batman-adv soft-interface can be created using  the  iproute2
+tool "ip"
 
-# echo bat0 > /sys/class/net/eth0/batman_adv/mesh_iface
+# ip link add name bat0 type batadv
+
+To  activate a  given  interface  simply  attach it to the "bat0"
+interface
+
+# ip link set dev eth0 master bat0
 
 Repeat  this step for all interfaces you wish to add.  Now batman
 starts using/broadcasting on this/these interface(s).
@@ -56,10 +61,10 @@ By reading the "iface_status" file you can check its status:
 # cat /sys/class/net/eth0/batman_adv/iface_status
 # active
 
-To deactivate an interface you have  to  write  "none"  into  its
-"mesh_iface" file:
+To  deactivate  an  interface  you  have   to  detach it from the
+"bat0" interface:
 
-# echo none > /sys/class/net/eth0/batman_adv/mesh_iface
+# ip link set dev eth0 nomaster
 
 
 All  mesh  wide  settings  can be found in batman's own interface
-- 
2.8.1

