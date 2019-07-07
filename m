Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Fix deletion of RTR(4|6) mcast list entries
Date: Sun,  7 Jul 2019 23:04:57 +0200
Message-Id: <20190707210457.20892-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org

The multicast code uses the lists bat_priv->mcast.want_all_rtr*_list to
store all all originator nodes which don't have the flag no-RTR4 or no-RTR6
set. When an originator is purged, it has to be removed from these lists.

Since all entries without the BATADV_MCAST_WANT_NO_RTR4/6 are stored in
these lists, they have to be handled like entries which have these flags
set to force the update routines to remove them from the lists when purging
the originator.

Not doing so will leave a pointer to a freed memory region inside the list.
Trying to operate on these lists will then cause an use-after-free error:

  BUG: KASAN: use-after-free in batadv_mcast_want_rtr4_update+0x335/0x3a0 [batman_adv]
  Write of size 8 at addr ffff888007b41a38 by task swapper/0/0

Fixes: 0a7733468f95 ("batman-adv: mcast: detect, distribute and maintain multicast router presence")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Linus Lüssing <linus.luessing@c0d3.blue>

See https://www.open-mesh.org/issues/395
---
 net/batman-adv/multicast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index a3488cfb..1d5bdf3a 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2420,8 +2420,10 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv4_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv6_update(bat_priv, orig, BATADV_NO_FLAGS);
-	batadv_mcast_want_rtr4_update(bat_priv, orig, BATADV_NO_FLAGS);
-	batadv_mcast_want_rtr6_update(bat_priv, orig, BATADV_NO_FLAGS);
+	batadv_mcast_want_rtr4_update(bat_priv, orig,
+				      BATADV_MCAST_WANT_NO_RTR4);
+	batadv_mcast_want_rtr6_update(bat_priv, orig,
+				      BATADV_MCAST_WANT_NO_RTR6);
 
 	spin_unlock_bh(&orig->mcast_handler_lock);
 }
-- 
2.20.1

