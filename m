Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] batman-adv: mcast: fix multicast tt/tvlv worker locking
Date: Thu,  9 May 2019 15:28:15 +0200
Message-Id: <20190509132815.3723-3-sw@simonwunderlich.de>
In-Reply-To: <20190509132815.3723-1-sw@simonwunderlich.de>
References: <20190509132815.3723-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Syzbot has reported some issues with the locking assumptions made for
the multicast tt/tvlv worker: It was able to trigger the WARN_ON() in
batadv_mcast_mla_tt_retract() and batadv_mcast_mla_tt_add().
While hard/not reproduceable for us so far it seems that the
delayed_work_pending() we use might not be quite safe from reordering.

Therefore this patch adds an explicit, new spinlock to protect the
update of the mla_list and flags in bat_priv and then removes the
WARN_ON(delayed_work_pending()).

Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com
Reported-by: syzbot+050927a651272b145a5d@syzkaller.appspotmail.com
Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com
Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
Fixes: cbebd363b2e9 ("batman-adv: Use own timer for multicast TT and TVLV updates")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c      |  1 +
 net/batman-adv/multicast.c | 11 +++--------
 net/batman-adv/types.h     |  5 +++++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 75750870cf04..f8725786b596 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -161,6 +161,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->tt.commit_lock);
 	spin_lock_init(&bat_priv->gw.list_lock);
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	spin_lock_init(&bat_priv->mcast.mla_lock);
 	spin_lock_init(&bat_priv->mcast.want_lists_lock);
 #endif
 	spin_lock_init(&bat_priv->tvlv.container_list_lock);
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f91b1b6265cf..1b985ab89c08 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -325,8 +325,6 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
  * translation table except the ones listed in the given mcast_list.
  *
  * If mcast_list is NULL then all are retracted.
- *
- * Do not call outside of the mcast worker! (or cancel mcast worker first)
  */
 static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 					struct hlist_head *mcast_list)
@@ -334,8 +332,6 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
-	WARN_ON(delayed_work_pending(&bat_priv->mcast.work));
-
 	hlist_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
 				  list) {
 		if (mcast_list &&
@@ -359,8 +355,6 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
  *
  * Adds multicast listener announcements from the given mcast_list to the
  * translation table if they have not been added yet.
- *
- * Do not call outside of the mcast worker! (or cancel mcast worker first)
  */
 static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 				    struct hlist_head *mcast_list)
@@ -368,8 +362,6 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
-	WARN_ON(delayed_work_pending(&bat_priv->mcast.work));
-
 	if (!mcast_list)
 		return;
 
@@ -658,7 +650,10 @@ static void batadv_mcast_mla_update(struct work_struct *work)
 	priv_mcast = container_of(delayed_work, struct batadv_priv_mcast, work);
 	bat_priv = container_of(priv_mcast, struct batadv_priv, mcast);
 
+	spin_lock(&bat_priv->mcast.mla_lock);
 	__batadv_mcast_mla_update(bat_priv);
+	spin_unlock(&bat_priv->mcast.mla_lock);
+
 	batadv_mcast_start_timer(bat_priv);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a21b34ed6548..ed0f6a519de5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1224,6 +1224,11 @@ struct batadv_priv_mcast {
 	unsigned char bridged:1;
 
 	/**
+	 * @mla_lock: a lock protecting mla_list and mla_flags
+	 */
+	spinlock_t mla_lock;
+
+	/**
 	 * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP
 	 *  traffic
 	 */
-- 
2.11.0

