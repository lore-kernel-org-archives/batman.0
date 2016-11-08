Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue,  8 Nov 2016 17:45:14 +0100
Message-Id: <20161108164526.7518-6-sw@simonwunderlich.de>
In-Reply-To: <20161108164526.7518-1-sw@simonwunderlich.de>
References: <20161108164526.7518-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/17] batman-adv: Remove unnecessary lockdep
	in batadv_mcast_mla_list_free
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@c0d3.blue>

batadv_mcast_mla_list_free() just frees some leftovers of a local feast
in batadv_mcast_mla_update(). No lockdep needed as it has nothing to do
with bat_priv->mcast.mla_list.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 13661f4..45757fa 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -231,19 +231,15 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 
 /**
  * batadv_mcast_mla_list_free - free a list of multicast addresses
- * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: the list to free
  *
  * Removes and frees all items in the given mcast_list.
  */
-static void batadv_mcast_mla_list_free(struct batadv_priv *bat_priv,
-				       struct hlist_head *mcast_list)
+static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
-	lockdep_assert_held(&bat_priv->tt.commit_lock);
-
 	hlist_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
 		hlist_del(&mcast_entry->list);
 		kfree(mcast_entry);
@@ -560,7 +556,7 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
 
 out:
-	batadv_mcast_mla_list_free(bat_priv, &mcast_list);
+	batadv_mcast_mla_list_free(&mcast_list);
 }
 
 /**
-- 
2.10.1

