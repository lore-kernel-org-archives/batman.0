Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/3] batman-adv: Fix order of kernel doc in batadv_priv
Date: Thu,  8 Apr 2021 13:53:59 +0200
Message-Id: <20210408115401.16988-2-sw@simonwunderlich.de>
In-Reply-To: <20210408115401.16988-1-sw@simonwunderlich.de>
References: <20210408115401.16988-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

During the inlining process of kerneldoc in commit 8b84cc4fb556
("batman-adv: Use inline kernel-doc for enum/struct"), some comments were
placed at the wrong struct members. Fixing this by reordering the comments.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7c0b475cc22a..2be5d4a712c5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1659,19 +1659,19 @@ struct batadv_priv {
 	/** @tp_list: list of tp sessions */
 	struct hlist_head tp_list;
 
-	/** @tp_num: number of currently active tp sessions */
+	/** @orig_hash: hash table containing mesh participants (orig nodes) */
 	struct batadv_hashtable *orig_hash;
 
-	/** @orig_hash: hash table containing mesh participants (orig nodes) */
+	/** @forw_bat_list_lock: lock protecting forw_bat_list */
 	spinlock_t forw_bat_list_lock;
 
-	/** @forw_bat_list_lock: lock protecting forw_bat_list */
+	/** @forw_bcast_list_lock: lock protecting forw_bcast_list */
 	spinlock_t forw_bcast_list_lock;
 
-	/** @forw_bcast_list_lock: lock protecting forw_bcast_list */
+	/** @tp_list_lock: spinlock protecting @tp_list */
 	spinlock_t tp_list_lock;
 
-	/** @tp_list_lock: spinlock protecting @tp_list */
+	/** @tp_num: number of currently active tp sessions */
 	atomic_t tp_num;
 
 	/** @orig_work: work queue callback item for orig node purging */
-- 
2.20.1

