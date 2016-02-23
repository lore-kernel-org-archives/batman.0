Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:04 +0800
Message-Id: <1456207703-903-2-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 01/20] batman-adv: remove unused
	BATADV_BONDING_TQ_THRESHOLD constant
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

BATADV_BONDING_TQ_THRESHOLD is not used anymore since the implementation
of the bat_neigh_is_similar_or_better() API function.
Such function uses the more generic BATADV_TQ_SIMILARITY_THRESHOLD
constant.

Therefore, remove definition of the unused BATADV_BONDING_TQ_THRESHOLD
constant.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/main.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 32dfc9e578af..8c01f54c61f3 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -100,11 +100,6 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
-/* how much worse secondary interfaces may be to be considered as bonding
- * candidates
- */
-#define BATADV_BONDING_TQ_THRESHOLD	50
-
 /* should not be bigger than 512 bytes or change the size of
  * forw_packet->direct_link_flags
  */
-- 
2.7.1

