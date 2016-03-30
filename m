Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Mar 2016 14:19:32 +0200
Message-Id: <1459340372-6971-2-git-send-email-sven@narfation.org>
In-Reply-To: <1459340372-6971-1-git-send-email-sven@narfation.org>
References: <1459340372-6971-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Don't re-broadcast packets on
	non-wifi devices
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

It is not necessary to re-broadcast a received broadcast packet on the
rx-device when it is a standard ethernet device. The link medium already
takes care of transporting it to all participants in the broadcast domain.

The re-broadcast on other devices is still necessary to allow the broadcast
packet to be received by devices which are using a different link medium.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index aad4a3a..ddad99d 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -96,7 +96,7 @@
 #define BATADV_LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
 /* number of packets to send for broadcasts on different interface types */
-#define BATADV_NUM_BCASTS_SAMEIF 1
+#define BATADV_NUM_BCASTS_SAMEIF 0
 #define BATADV_NUM_BCASTS_OTHERIF 1
 #define BATADV_NUM_BCASTS_WIRELESS 3
 #define BATADV_NUM_BCASTS_MAX 3
-- 
2.8.0.rc3

