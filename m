Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Aug 2011 15:00:35 +0200
Message-Id: <1314190838-2273-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1314190838-2273-1-git-send-email-lindner_marek@yahoo.de>
References: <1314190838-2273-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: implement AP-isolation on
	the sender side
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

If a node has to send a packet issued by a WIFI client to another WIFI client,
the packet is dropped.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c           |    2 +-
 net/batman-adv/soft-interface.c    |    3 ++-
 net/batman-adv/translation-table.c |   28 +++++++++++++++++++++-------
 net/batman-adv/translation-table.h |    2 +-
 net/batman-adv/unicast.c           |    6 ++++--
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 13444e9..91a7860 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1535,7 +1535,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 		ethhdr = (struct ethhdr *)(skb->data +
 			sizeof(struct unicast_packet));
-		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+		orig_node = transtable_search(bat_priv, NULL, ethhdr->h_dest);
 
 		if (!orig_node) {
 			if (!is_my_client(bat_priv, ethhdr->h_dest))
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9addbab..402fd96 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -597,7 +597,8 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* Register the client MAC in the transtable */
 	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
-	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+	orig_node = transtable_search(bat_priv, ethhdr->h_source,
+				      ethhdr->h_dest);
 	if (is_multicast_ether_addr(ethhdr->h_dest) ||
 				(orig_node && orig_node->gw_flags)) {
 		ret = gw_is_target(bat_priv, skb, orig_node);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d0ed931..1f128e1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -794,29 +794,43 @@ static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
 }
 
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
-				    const uint8_t *addr)
+				    const uint8_t *src, const uint8_t *addr)
 {
-	struct tt_global_entry *tt_global_entry;
+	struct tt_local_entry *tt_local_entry = NULL;
+	struct tt_global_entry *tt_global_entry = NULL;
 	struct orig_node *orig_node = NULL;
 
+	if (src && atomic_read(&bat_priv->ap_isolation)) {
+		tt_local_entry = tt_local_hash_find(bat_priv, src);
+		if (!tt_local_entry)
+			goto out;
+	}
+
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
-
 	if (!tt_global_entry)
 		goto out;
 
+	/* check whether the clients should not communicate due to AP
+	 * isolation */
+	if (tt_local_entry && _is_ap_isolated(tt_local_entry, tt_global_entry))
+		goto out;
+
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
-		goto free_tt;
+		goto out;
 
 	/* A global client marked as PENDING has already moved from that
 	 * originator */
 	if (tt_global_entry->flags & TT_CLIENT_PENDING)
-		goto free_tt;
+		goto out;
 
 	orig_node = tt_global_entry->orig_node;
 
-free_tt:
-	tt_global_entry_free_ref(tt_global_entry);
 out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
+
 	return orig_node;
 }
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index f1d148e..b47e876 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -43,7 +43,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node, const unsigned char *addr,
 		   const char *message, bool roaming);
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
-				    const uint8_t *addr);
+				    const uint8_t *src, const uint8_t *addr);
 void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			 const unsigned char *tt_buff, uint8_t tt_num_changes);
 uint16_t tt_local_crc(struct bat_priv *bat_priv);
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 32b125f..07d1c1d 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -299,8 +299,10 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 			goto find_router;
 	}
 
-	/* check for tt host - increases orig_node refcount */
-	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+	/* check for tt host - increases orig_node refcount.
+	 * returns NULL in case of AP isolation */
+	orig_node = transtable_search(bat_priv, ethhdr->h_source,
+				      ethhdr->h_dest);
 
 find_router:
 	/**
-- 
1.7.5.3

