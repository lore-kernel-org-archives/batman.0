Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:08:03 +0100
Message-Id: <20181114140804.18381-16-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: Move CRC16 dependency to
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The commit ced72933a5e8 ("batman-adv: use CRC32C instead of CRC16 in TT
code") switched the translation table code from crc16 to crc32c. The
(optional) bridge loop avoidance code is the only user of this function.

batman-adv should only select CRC16 when it is actually using it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 082e96060bc2..d6b94559f888 100644
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
2.11.0

