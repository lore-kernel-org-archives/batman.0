Return-Path: <rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] net: batman-adv: types.h: delete duplicated words
Date: Sun, 19 Jul 2020 11:08:11 -0700
Message-Id: <20200719180811.11964-1-rdunlap@infradead.org>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Delete the doubled word "time" in a comment.
Delete the doubled word "address" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
---
 net/batman-adv/types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/net/batman-adv/types.h
+++ linux-next-20200717/net/batman-adv/types.h
@@ -1492,7 +1492,7 @@ struct batadv_tp_vars {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
-	/** @last_recv_time: time time (jiffies) a msg was received */
+	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
 
 	/** @refcount: number of context where the object is used */
@@ -1996,7 +1996,7 @@ struct batadv_tt_change_node {
  */
 struct batadv_tt_req_node {
 	/**
-	 * @addr: mac address address of the originator this request was sent to
+	 * @addr: mac address of the originator this request was sent to
 	 */
 	u8 addr[ETH_ALEN];
 
