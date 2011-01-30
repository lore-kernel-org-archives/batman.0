Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:18 +0100
Message-Id: <1296362366-3852-11-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 10/18] batman-adv: Purge timeouted entries in
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
 multicast.c  |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h  |    1 +
 originator.c |    2 +
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index b53825f..fefef41 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -860,6 +860,81 @@ free:
 	}
 }
 
+static void purge_mcast_nexthop_list(struct hlist_head *mcast_nexthop_list,
+				     int *num_nexthops,
+				     struct bat_priv *bat_priv)
+{
+	struct mcast_forw_nexthop_entry *nexthop_entry;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(nexthop_entry, node, node_tmp,
+				 mcast_nexthop_list, list) {
+		if (get_remaining_timeout(nexthop_entry, bat_priv))
+			continue;
+
+		hlist_del(&nexthop_entry->list);
+		kfree(nexthop_entry);
+		*num_nexthops = *num_nexthops - 1;
+	}
+}
+
+static void purge_mcast_if_list(struct hlist_head *mcast_if_list,
+				struct bat_priv *bat_priv)
+{
+	struct mcast_forw_if_entry *if_entry;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(if_entry, node, node_tmp, mcast_if_list,
+				  list) {
+		purge_mcast_nexthop_list(&if_entry->mcast_nexthop_list,
+					 &if_entry->num_nexthops,
+					 bat_priv);
+
+		if (!hlist_empty(&if_entry->mcast_nexthop_list))
+				continue;
+
+		hlist_del(&if_entry->list);
+		kfree(if_entry);
+	}
+}
+
+static void purge_mcast_orig_list(struct hlist_head *mcast_orig_list,
+				  struct bat_priv *bat_priv)
+{
+	struct mcast_forw_orig_entry *orig_entry;
+	struct hlist_node *node, *node_tmp;
+
+	hlist_for_each_entry_safe(orig_entry, node, node_tmp, mcast_orig_list,
+				  list) {
+		purge_mcast_if_list(&orig_entry->mcast_if_list, bat_priv);
+
+		if (!hlist_empty(&orig_entry->mcast_if_list))
+			continue;
+
+		hlist_del(&orig_entry->list);
+		kfree(orig_entry);
+	}
+}
+
+void purge_mcast_forw_table(struct bat_priv *bat_priv)
+{
+	struct mcast_forw_table_entry *table_entry;
+	struct hlist_node *node, *node_tmp;
+
+	spin_lock_bh(&bat_priv->mcast_forw_table_lock);
+	hlist_for_each_entry_safe(table_entry, node, node_tmp,
+				  &bat_priv->mcast_forw_table, list) {
+		purge_mcast_orig_list(&table_entry->mcast_orig_list, bat_priv);
+
+		if (!hlist_empty(&table_entry->mcast_orig_list))
+			continue;
+
+		hlist_del(&table_entry->list);
+		kfree(table_entry);
+	}
+	spin_unlock_bh(&bat_priv->mcast_forw_table_lock);
+}
+
 static void mcast_tracker_timer(struct work_struct *work)
 {
 	struct bat_priv *bat_priv = container_of(work, struct bat_priv,
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index 63d0e97..40f9da0 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -29,6 +29,7 @@ int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
 void mcast_tracker_reset(struct bat_priv *bat_priv);
 void route_mcast_tracker_packet(struct sk_buff *tracker_packet,
 				struct bat_priv *bat_priv);
+void purge_mcast_forw_table(struct bat_priv *bat_priv);
 int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 637d5f1..81b4865 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -30,6 +30,7 @@
 #include "hard-interface.h"
 #include "unicast.h"
 #include "soft-interface.h"
+#include "multicast.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -403,6 +404,7 @@ static void purge_orig(struct work_struct *work)
 	struct bat_priv *bat_priv =
 		container_of(delayed_work, struct bat_priv, orig_work);
 
+	purge_mcast_forw_table(bat_priv);
 	_purge_orig(bat_priv);
 	start_purge_timer(bat_priv);
 }
-- 
1.7.2.3

