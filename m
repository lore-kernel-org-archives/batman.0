Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:11 +0200
Message-Id: <20160822135620.15337-12-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/20] batman-adv: Place kref_get for
	dat_entry near use
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems caused by incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b1cc8bf..059bc23 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -343,8 +343,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	ether_addr_copy(dat_entry->mac_addr, mac_addr);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
-	kref_get(&dat_entry->refcount);
 
+	kref_get(&dat_entry->refcount);
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
-- 
2.9.3

