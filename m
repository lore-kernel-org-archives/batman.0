Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 18 Jun 2015 06:47:19 +0200
Message-Id: <1434602839-4468-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix compile error on
 deactivated MCAST feature
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

Some members of "struct batadv_orig_node" are not available if compiling
without the multicast optimizations feature.

Fix this by moving their initialization into the right #ifdef's.

Fixes: 7f220ed1f063 ("batman-adv: Fix potential synchronization issues in mcast tvlv handler")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 originator.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/originator.c b/originator.c
index a2ba182..a5276db 100644
--- a/originator.c
+++ b/originator.c
@@ -658,15 +658,11 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->vlan_list);
 	INIT_HLIST_HEAD(&orig_node->ifinfo_list);
-	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
-	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
-	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
 	spin_lock_init(&orig_node->tt_lock);
 	spin_lock_init(&orig_node->vlan_list_lock);
-	spin_lock_init(&orig_node->mcast_handler_lock);
 
 	batadv_nc_init_orig(orig_node);
 
@@ -682,8 +678,13 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->last_seen = jiffies;
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
+
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	orig_node->mcast_flags = BATADV_NO_FLAGS;
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
+	spin_lock_init(&orig_node->mcast_handler_lock);
 #endif
 
 	/* create a vlan object for the "untagged" LAN */
-- 
1.7.10.4

