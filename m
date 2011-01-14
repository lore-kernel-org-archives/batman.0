Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 14 Jan 2011 01:59:48 +0100
Message-Id: <1294966794-17780-6-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 05/11] batman-adv: Purge outdated ndp
	neighbours
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

If no new packet has been received from a neighbour for a while, then
delete it from memory.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 ndp.c        |   28 ++++++++++++++++++++++++++++
 ndp.h        |    1 +
 originator.c |    2 ++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/batman-adv/ndp.c b/batman-adv/ndp.c
index 90712b6..5be2639 100644
--- a/batman-adv/ndp.c
+++ b/batman-adv/ndp.c
@@ -22,6 +22,7 @@
 #include "main.h"
 #include "send.h"
 #include "ndp.h"
+#include "hard-interface.h"
 #include "originator.h"
 
 /* when do we schedule our own neighbor discovery packet to be sent */
@@ -221,6 +222,33 @@ static struct neigh_node *ndp_create_neighbor(uint8_t my_tq, uint32_t seqno,
 	return neigh_node;
 }
 
+void ndp_purge_neighbors(void)
+{
+	struct neigh_node *neigh_node;
+	struct hlist_node *node, *node_tmp;
+	struct batman_if *batman_if;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->if_status != IF_ACTIVE)
+			continue;
+
+		spin_lock_bh(&batman_if->neigh_list_lock);
+		hlist_for_each_entry_safe(neigh_node, node, node_tmp,
+					  &batman_if->neigh_list, list) {
+			if (time_before(jiffies, neigh_node->last_valid +
+					msecs_to_jiffies(PURGE_TIMEOUT *
+							 1000)))
+				continue;
+
+			hlist_del(&neigh_node->list);
+			kfree(neigh_node);
+		}
+		spin_unlock_bh(&batman_if->neigh_list_lock);
+	}
+	rcu_read_unlock();
+}
+
 int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
 			struct batman_if *batman_if, uint8_t *neigh_addr)
 {
diff --git a/batman-adv/ndp.h b/batman-adv/ndp.h
index 2496c3f..a828362 100644
--- a/batman-adv/ndp.h
+++ b/batman-adv/ndp.h
@@ -29,6 +29,7 @@ int ndp_init(struct batman_if *batman_if);
 void ndp_free(struct batman_if *batman_if);
 uint8_t ndp_fetch_tq(struct batman_packet_ndp *packet,
 		 uint8_t *my_if_addr);
+void ndp_purge_neighbors(void);
 int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
 			struct batman_if *batman_if, uint8_t *neigh_addr);
 
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index c043bf8..e98add5 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -22,6 +22,7 @@
 /* increase the reference counter for this originator */
 
 #include "main.h"
+#include "ndp.h"
 #include "originator.h"
 #include "hash.h"
 #include "translation-table.h"
@@ -334,6 +335,7 @@ static void purge_orig(struct work_struct *work)
 		container_of(delayed_work, struct bat_priv, orig_work);
 
 	_purge_orig(bat_priv);
+	ndp_purge_neighbors();
 	start_purge_timer(bat_priv);
 }
 
-- 
1.7.1

