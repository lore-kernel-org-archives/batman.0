Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 22:26:43 +0800
Message-Id: <1322317612-7770-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
References: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: update internal version
	number
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

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 964ad4d..86354e0 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -28,7 +28,7 @@
 #define DRIVER_DEVICE "batman-adv"
 
 #ifndef SOURCE_VERSION
-#define SOURCE_VERSION "2011.4.0"
+#define SOURCE_VERSION "2012.0.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
1.7.5.4

