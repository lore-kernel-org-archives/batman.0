Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:22 +0100
Message-Id: <1291761150-29818-12-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 12/20] batman-adv: Purge timeouted entries in
	mcast forw table
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

With this commit, the multicast forwarding table, which has been
previously filled up due to multicast tracker packets, will now be
checked frequently (once per second) for timeouted entries. If so these
entries get removed from the table.

Note, that a more frequent check interval is not necessary, as multicast
data will not only be forwarded if an entry exists, but also if that one
might not have timeouted yet.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c  |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h  |    1 +
 originator.c |    2 ++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/multicast.c b/multicast.c
index edfe7e2..2b1bfde 100644
--- a/multicast.c
+++ b/multicast.c
@@ -821,6 +821,57 @@ out:
 	rcu_read_unlock();
 }
 
+void purge_mcast_forw_table(struct bat_priv *bat_priv)
+{
+	unsigned long flags;
+	struct mcast_forw_table_entry *table_entry, *tmp_table_entry;
+	struct mcast_forw_orig_entry *orig_entry, *tmp_orig_entry;
+	struct mcast_forw_if_entry *if_entry, *tmp_if_entry;
+	struct mcast_forw_nexthop_entry *nexthop_entry, *tmp_nexthop_entry;
+
+	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
+	list_for_each_entry_safe(table_entry, tmp_table_entry,
+				 &bat_priv->mcast_forw_table, list) {
+		list_for_each_entry_safe(orig_entry, tmp_orig_entry,
+					 &table_entry->mcast_orig_list, list) {
+			list_for_each_entry_safe(if_entry, tmp_if_entry,
+					    &orig_entry->mcast_if_list, list) {
+				list_for_each_entry_safe(nexthop_entry,
+						tmp_nexthop_entry,
+						&if_entry->mcast_nexthop_list,
+						list) {
+					if (get_remaining_timeout(
+					    nexthop_entry, bat_priv))
+						continue;
+
+					list_del(&nexthop_entry->list);
+					kfree(nexthop_entry);
+					if_entry->num_nexthops--;
+				}
+
+				if (!list_empty(&if_entry->mcast_nexthop_list))
+					continue;
+
+				list_del(&if_entry->list);
+				kfree(if_entry);
+			}
+
+			if (!list_empty(&orig_entry->mcast_if_list))
+				continue;
+
+			list_del(&orig_entry->list);
+			kfree(orig_entry);
+		}
+
+		if (!list_empty(&table_entry->mcast_orig_list))
+			continue;
+
+		list_del(&table_entry->list);
+		kfree(table_entry);
+	}
+	spin_unlock_irqrestore(&bat_priv->mcast_forw_table_lock, flags);
+}
+
 static void mcast_tracker_timer(struct work_struct *work)
 {
 	struct bat_priv *bat_priv = container_of(work, struct bat_priv,
diff --git a/multicast.h b/multicast.h
index 0bd0590..7312afa 100644
--- a/multicast.h
+++ b/multicast.h
@@ -30,6 +30,7 @@ void mcast_tracker_reset(struct bat_priv *bat_priv);
 void route_mcast_tracker_packet(
 			struct mcast_tracker_packet *tracker_packet,
 			int tracker_packet_len, struct bat_priv *bat_priv);
+void purge_mcast_forw_table(struct bat_priv *bat_priv);
 int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
diff --git a/originator.c b/originator.c
index 900d5fc..39ce8d5 100644
--- a/originator.c
+++ b/originator.c
@@ -30,6 +30,7 @@
 #include "hard-interface.h"
 #include "unicast.h"
 #include "soft-interface.h"
+#include "multicast.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -311,6 +312,7 @@ static void purge_orig(struct work_struct *work)
 	struct bat_priv *bat_priv =
 		container_of(delayed_work, struct bat_priv, orig_work);
 
+	purge_mcast_forw_table(bat_priv);
 	_purge_orig(bat_priv);
 	start_purge_timer(bat_priv);
 }
-- 
1.7.1

