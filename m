Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jun 2016 11:16:11 +0200
Message-Id: <1466932573-23105-3-git-send-email-sven@narfation.org>
In-Reply-To: <10049349.EHEiaYmtBd@sven-edge>
References: <10049349.EHEiaYmtBd@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH net 3/5] batman-adv: Fix double-put of vlan
	object
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Ben Hutchings <ben@decadent.org.uk>, Marek Lindner <mareklindner@neomailbox.ch>

From: Ben Hutchings <ben@decadent.org.uk>

Each batadv_tt_local_entry hold a single reference to a
batadv_softif_vlan.  In case a new entry cannot be added to the hash
table, the error path puts the reference, but the reference will also
now be dropped by batadv_tt_local_entry_release().

Fixes: a33d970d0b54 ("batman-adv: Fix reference counting of vlan object for tt_local_entry")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cfb5ccd..57ec87f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -693,7 +693,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_tt_local_entry_put(tt_local);
-		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
 
-- 
2.8.1

