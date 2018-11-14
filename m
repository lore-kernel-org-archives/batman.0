Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:54 +0100
Message-Id: <20181114140804.18381-7-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: Fix description for
 BATMAN_ADV_DEBUG
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

The debug messages of batman-adv are not printed to the kernel log at all
but can be stored (depending on the compile setting) in the tracing buffer
or the batadv specific log buffer. There is also no debug module parameter
but a batadv netdev specific log_level setting to enable/disable different
classes of debug messages at runtime.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 7b0e1fcddfa7..082e96060bc2 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -104,8 +104,9 @@ config BATMAN_ADV_DEBUG
 	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables compilation of support for
-	  outputting debugging information to the kernel log. The
-	  output is controlled via the module parameter debug.
+	  outputting debugging information to the debugfs log or tracing
+	  buffer. The output is controlled via the batadv netdev specific
+	  log_level setting.
 
 config BATMAN_ADV_TRACING
 	bool "B.A.T.M.A.N. tracing support"
-- 
2.11.0

