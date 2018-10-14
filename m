Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 14 Oct 2018 17:16:14 +0200
Message-Id: <20181014151614.9494-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Move CRC16 dependency to
 BATMAN_ADV_BLA
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

The commit c5e7a06a2961 ("batman-adv: use CRC32C instead of CRC16 in TT
code") switched the translation table code from crc16 to crc32c. The
(optional) bridge loop avoidance code is the only user of this function.

batman-adv should only select CRC16 when it is actually using it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f75816f5..449ab2e5 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -22,7 +22,6 @@
 config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
 	depends on NET
-	select CRC16
 	select LIBCRC32C
 	help
           B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
@@ -48,6 +47,7 @@ config BATMAN_ADV_BATMAN_V
 config BATMAN_ADV_BLA
 	bool "Bridge Loop Avoidance"
 	depends on BATMAN_ADV && INET
+	select CRC16
 	default y
 	help
 	  This option enables BLA (Bridge Loop Avoidance), a mechanism
-- 
2.19.1

