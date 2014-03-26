Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Mar 2014 15:46:24 +0100
Message-Id: <1395845184-15186-5-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
References: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maintv3 4/4] batman-adv: fix removing
	neigh_ifinfo
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

When an interface is removed separately, all neighbors need to be
checked if they have a neigh_ifinfo structure for that particular
interface. If that is the case, remove that ifinfo so any references to
a hard interface can be freed.

This is a regression introduced by
9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv: split tq
information in neigh_node struct")

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 originator.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/originator.c b/originator.c
index 47b0886..aa2468b 100644
--- a/originator.c
+++ b/originator.c
@@ -702,6 +702,47 @@ free_orig_node:
 }
 
 /**
+ * batadv_purge_neigh_ifinfo - purge obsolete ifinfo entries from neighbor
+ * @bat_priv: the bat priv with all the soft interface information
+ * @neigh_node: orig node which is to be checked
+ */
+static void
+batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
+			  struct batadv_neigh_node *neigh)
+{
+	struct batadv_neigh_ifinfo *neigh_ifinfo;
+	struct batadv_hard_iface *if_outgoing;
+	struct hlist_node *node_tmp;
+
+	spin_lock_bh(&neigh->ifinfo_lock);
+
+	/* for all ifinfo objects for this neighinator */
+	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
+				  &neigh->ifinfo_list, list) {
+		if_outgoing = neigh_ifinfo->if_outgoing;
+
+		/* always keep the default interface */
+		if (if_outgoing == BATADV_IF_DEFAULT)
+			continue;
+
+		/* don't purge if the interface is not (going) down */
+		if ((if_outgoing->if_status != BATADV_IF_INACTIVE) &&
+		    (if_outgoing->if_status != BATADV_IF_NOT_IN_USE) &&
+		    (if_outgoing->if_status != BATADV_IF_TO_BE_REMOVED))
+			continue;
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "neighbor/ifinfo purge: neighbor %pM, iface: %s\n",
+			   neigh->addr, if_outgoing->net_dev->name);
+
+		hlist_del_rcu(&neigh_ifinfo->list);
+		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
+	}
+
+	spin_unlock_bh(&neigh->ifinfo_lock);
+}
+
+/**
  * batadv_purge_orig_ifinfo - purge obsolete ifinfo entries from originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
@@ -800,6 +841,11 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&neigh_node->list);
 			batadv_neigh_node_free_ref(neigh_node);
+		} else {
+			/* only neccesary if not the whole neighbor is to be deleted,
+			 * but some interface has been removed.
+			 */
+			batadv_purge_neigh_ifinfo(bat_priv, neigh_node);
 		}
 	}
 
-- 
1.7.10.4

