Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:18 +0100
Message-Id: <1457190564-11419-3-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: Increase hard_iface refcnt
	for ptype
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

The hard_iface is referenced in the packet_type for batman-adv. Increase
the refcounter of the hard_interface for it to have an explicit reference
for it in case this functionality gets refactorted and the currently
used implicit reference for it will be removed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 3240a67..56b148a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -519,6 +519,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		goto err_upper;
 	}
 
+	kref_get(&hard_iface->refcount);
 	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
@@ -581,6 +582,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	batadv_info(hard_iface->soft_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
+	batadv_hardif_put(hard_iface);
 
 	bat_priv->num_ifaces--;
 	batadv_orig_hash_del_if(hard_iface, bat_priv->num_ifaces);
-- 
2.7.0

