Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Aug 2017 16:23:17 +0200
Message-Id: <20170802142322.13376-2-sw@simonwunderlich.de>
In-Reply-To: <20170802142322.13376-1-sw@simonwunderlich.de>
References: <20170802142322.13376-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: Start new development cycle
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 2be8f1f46529..05cc7637c064 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -24,7 +24,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2017.2"
+#define BATADV_SOURCE_VERSION "2017.3"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.11.0

