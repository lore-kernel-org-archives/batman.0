Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 28 Oct 2015 10:58:00 +0100
Message-Id: <1446026280-21289-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Change ifconfig examples to
	iproute2
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: fixed "NodeA" in NodeB block

 Documentation/networking/batman-adv.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 58e4904..ff23b75 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -115,14 +115,17 @@ The "bat0" interface can be used like any  other  regular  inter-
 face.  It needs an IP address which can be either statically con-
 figured or dynamically (by using DHCP or similar services):
 
-# NodeA: ifconfig bat0 192.168.0.1
-# NodeB: ifconfig bat0 192.168.0.2
+# NodeA: ip link set up dev bat0
+# NodeA: ip addr add 192.168.0.1/24 dev bat0
+
+# NodeB: ip link set up dev bat0
+# NodeB: ip addr add 192.168.0.2/24 dev bat0
 # NodeB: ping 192.168.0.1
 
 Note:  In  order to avoid problems remove all IP addresses previ-
 ously assigned to interfaces now used by batman advanced, e.g.
 
-# ifconfig eth0 0.0.0.0
+# ip addr flush dev eth0
 
 
 LOGGING/DEBUGGING
-- 
2.6.2

