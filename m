Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:10 +0800
Message-Id: <1452345621-15908-6-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 05/16] batman-adv: increase BLA wait periods
	to 6
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
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Simon Wunderlich <simon@open-mesh.com>

If networks take a long time to come up, e.g. due to lossy links, then
the bridge loop avoidance wait time to suppress broadcasts may not wait
long enough and detect a backbone before the mesh is brought up.
Increasing the wait period further to 60 seconds makes this scenario
less likely.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index da9f16c6829b..9dbd9107e7e1 100644
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
2.7.0

