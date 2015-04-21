Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 14:48:56 +0200
Message-Id: <1429620536-13149-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Document multicast compile
	time option
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

The README.external lists all options which can be enabled/disabled during
compile time. The CONFIG_BATMAN_ADV_MCAST option wasn't document in this
list.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: Remove the wrong Makefile change which slipped into the patch

 README.external | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.external b/README.external
index e3b533d..f068273 100644
--- a/README.external
+++ b/README.external
@@ -38,6 +38,7 @@ module).  Available  options  and  their    possible   values are
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
+ * CONFIG_BATMAN_ADV_MCAST=[y*|n] (B.A.T.M.A.N. multicast optimizations)
  * CONFIG_BATMAN_ADV_NC=[y|n*] (B.A.T.M.A.N. Network Coding)
 
 e.g., debugging can be enabled by
-- 
2.1.4

