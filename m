Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Oct 2018 11:30:32 +0200
Message-Id: <20181021093032.19928-6-sven@narfation.org>
In-Reply-To: <20181021093032.19928-1-sven@narfation.org>
References: <20181021093032.19928-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Fix description for
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
To: b.a.t.m.a.n@lists.open-mesh.org

The debug messages of batman-adv are not printed to the kernel log at all
but can be stored (depending on the compile setting) in the tracing buffer
or the batadv specific log buffer. There is also no debug module parameter
but a batadv netdev specific log_level setting to enable/disable different
classes of debug messages at runtime.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 7b0e1fcd..082e9606 100644
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
2.19.1

