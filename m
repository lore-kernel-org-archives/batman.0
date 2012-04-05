Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 Apr 2012 12:38:48 +0200
Message-Id: <1333622342-6128-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1333622342-6128-1-git-send-email-ordex@autistici.org>
References: <1333622342-6128-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/16] batman-adv: clean up Kconfig
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/Kconfig |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 2b68d06..a04d28f 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -7,19 +7,18 @@ config BATMAN_ADV
 	depends on NET
 	select CRC16
         default n
-	---help---
+	help
+          B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
+          a routing protocol for multi-hop ad-hoc mesh networks. The
+          networks may be wired or wireless. See
+          http://www.open-mesh.org/ for more information and user space
+          tools.
 
-        B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
-        a routing protocol for multi-hop ad-hoc mesh networks. The
-        networks may be wired or wireless. See
-        http://www.open-mesh.org/ for more information and user space
-        tools.
 
 config BATMAN_ADV_DEBUG
 	bool "B.A.T.M.A.N. debugging"
-	depends on BATMAN_ADV != n
-	---help---
-
+	depends on BATMAN_ADV
+	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables compilation of support for
 	  outputting debugging information to the kernel log. The
-- 
1.7.9.4

