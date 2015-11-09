Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  9 Nov 2015 16:20:53 +0100
Message-Id: <1447082453-13117-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: increase BLA wait periods to
	6
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

If networks take a long time to come up, e.g. due to lossy links, then
the bridge loop avoidance wait time to suppress broadcasts may not wait
long enough and detect a backbone before the mesh is brought up.
Increasing the wait period further to 60 seconds makes this scenario
less likely.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 79e2052..dcca44b 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -109,7 +109,7 @@
 #define BATADV_MAX_AGGREGATION_MS 100
 
 #define BATADV_BLA_PERIOD_LENGTH	10000	/* 10 seconds */
-#define BATADV_BLA_BACKBONE_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 3)
+#define BATADV_BLA_BACKBONE_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 6)
 #define BATADV_BLA_CLAIM_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 10)
 #define BATADV_BLA_WAIT_PERIODS		3
 
-- 
2.6.2

