Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jul 2016 21:04:00 +0200
Message-Id: <1468782245-12985-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: use consume_skb for
	non-dropped packets
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

kfree_skb assumes that an skb is dropped after an failure and notes that.
consume_skb should be used in non-failure situations. Such information is
important for dropmonitor netlink which tells how many packets were dropped
and where this drop happened.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     | 13 ++++++++-----
 net/batman-adv/fragmentation.c  | 20 ++++++++++++++------
 net/batman-adv/network-coding.c | 24 +++++++++++++++---------
 net/batman-adv/send.c           | 27 +++++++++++++++++++--------
 net/batman-adv/send.h           |  3 ++-
 net/batman-adv/soft-interface.c |  2 +-
 6 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a40cdf2..baf3d72 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -692,7 +692,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
 	if (!forw_packet_aggr->skb) {
-		batadv_forw_packet_free(forw_packet_aggr);
+		batadv_forw_packet_free(forw_packet_aggr, true);
 		return;
 	}
 
@@ -1605,7 +1605,7 @@ out:
 	if (hardif_neigh)
 		batadv_hardif_neigh_put(hardif_neigh);
 
-	kfree_skb(skb_priv);
+	consume_skb(skb_priv);
 }
 
 /**
@@ -1777,6 +1777,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	struct delayed_work *delayed_work;
 	struct batadv_forw_packet *forw_packet;
 	struct batadv_priv *bat_priv;
+	bool dropped = false;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -1786,8 +1787,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+		dropped = true;
 		goto out;
+	}
 
 	batadv_iv_ogm_emit(forw_packet);
 
@@ -1804,7 +1807,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_iv_ogm_schedule(forw_packet->if_incoming);
 
 out:
-	batadv_forw_packet_free(forw_packet);
+	batadv_forw_packet_free(forw_packet, dropped);
 }
 
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
@@ -1845,7 +1848,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 		ogm_packet = (struct batadv_ogm_packet *)packet_pos;
 	}
 
-	kfree_skb(skb);
+	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
 
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 0934730..461b77d 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -42,17 +42,23 @@
 /**
  * batadv_frag_clear_chain - delete entries in the fragment buffer chain
  * @head: head of chain with entries.
+ * @dropped: whether the chain is cleared because all fragments are dropped
  *
  * Free fragments in the passed hlist. Should be called with appropriate lock.
  */
-static void batadv_frag_clear_chain(struct hlist_head *head)
+static void batadv_frag_clear_chain(struct hlist_head *head, bool dropped)
 {
 	struct batadv_frag_list_entry *entry;
 	struct hlist_node *node;
 
 	hlist_for_each_entry_safe(entry, node, head, list) {
 		hlist_del(&entry->list);
-		kfree_skb(entry->skb);
+
+		if (dropped)
+			kfree_skb(entry->skb);
+		else
+			consume_skb(entry->skb);
+
 		kfree(entry);
 	}
 }
@@ -73,7 +79,7 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
 		spin_lock_bh(&chain->lock);
 
 		if (!check_cb || check_cb(chain)) {
-			batadv_frag_clear_chain(&chain->head);
+			batadv_frag_clear_chain(&chain->head, true);
 			chain->size = 0;
 		}
 
@@ -118,7 +124,7 @@ static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
 		return false;
 
 	if (!hlist_empty(&chain->head))
-		batadv_frag_clear_chain(&chain->head);
+		batadv_frag_clear_chain(&chain->head, true);
 
 	chain->size = 0;
 	chain->seqno = seqno;
@@ -220,7 +226,7 @@ out:
 		 * exceeds the maximum size of one merged packet. Don't allow
 		 * packets to have different total_size.
 		 */
-		batadv_frag_clear_chain(&chain->head);
+		batadv_frag_clear_chain(&chain->head, true);
 		chain->size = 0;
 	} else if (ntohs(frag_packet->total_size) == chain->size) {
 		/* All fragments received. Hand over chain to caller. */
@@ -254,6 +260,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	struct batadv_frag_list_entry *entry;
 	struct sk_buff *skb_out = NULL;
 	int size, hdr_size = sizeof(struct batadv_frag_packet);
+	bool dropped = false;
 
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
@@ -270,6 +277,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
 		kfree_skb(skb_out);
 		skb_out = NULL;
+		dropped = true;
 		goto free;
 	}
 
@@ -291,7 +299,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 
 free:
 	/* Locking is not needed, because 'chain' is not part of any orig. */
-	batadv_frag_clear_chain(chain);
+	batadv_frag_clear_chain(chain, dropped);
 	return skb_out;
 }
 
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 293ef4f..e924256 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -261,10 +261,16 @@ static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
 /**
  * batadv_nc_packet_free - frees nc packet
  * @nc_packet: the nc packet to free
+ * @dropped: whether the packet is freed because is is dropped
  */
-static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
+static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
+				  bool dropped)
 {
-	kfree_skb(nc_packet->skb);
+	if (dropped)
+		kfree_skb(nc_packet->skb);
+	else
+		consume_skb(nc_packet->skb);
+
 	batadv_nc_path_put(nc_packet->nc_path);
 	kfree(nc_packet);
 }
@@ -577,7 +583,7 @@ static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
 {
 	batadv_send_unicast_skb(nc_packet->skb, nc_packet->neigh_node);
 	nc_packet->skb = NULL;
-	batadv_nc_packet_free(nc_packet);
+	batadv_nc_packet_free(nc_packet, false);
 }
 
 /**
@@ -611,7 +617,7 @@ static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
 
 	/* purge nc packet */
 	list_del(&nc_packet->list);
-	batadv_nc_packet_free(nc_packet);
+	batadv_nc_packet_free(nc_packet, true);
 
 	res = true;
 
@@ -1210,11 +1216,11 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	}
 
 	/* skb_src is now coded into skb_dest, so free it */
-	kfree_skb(skb_src);
+	consume_skb(skb_src);
 
 	/* avoid duplicate free of skb from nc_packet */
 	nc_packet->skb = NULL;
-	batadv_nc_packet_free(nc_packet);
+	batadv_nc_packet_free(nc_packet, false);
 
 	/* Send the coded packet and return true */
 	batadv_send_unicast_skb(skb_dest, first_dest);
@@ -1401,7 +1407,7 @@ static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
 	/* batadv_nc_skb_store_for_decoding() clones the skb, so we must free
 	 * our ref
 	 */
-	kfree_skb(skb);
+	consume_skb(skb);
 }
 
 /**
@@ -1725,7 +1731,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	ether_addr_copy(unicast_packet->dest, orig_dest);
 	unicast_packet->ttvn = ttvn;
 
-	batadv_nc_packet_free(nc_packet);
+	batadv_nc_packet_free(nc_packet, false);
 	return unicast_packet;
 }
 
@@ -1862,7 +1868,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 	return batadv_recv_unicast_packet(skb, recv_if);
 
 free_nc_packet:
-	batadv_nc_packet_free(nc_packet);
+	batadv_nc_packet_free(nc_packet, true);
 	return NET_RX_DROP;
 }
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8d4e1f5..4f44ee2 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -451,13 +451,19 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 /**
  * batadv_forw_packet_free - free a forwarding packet
  * @forw_packet: The packet to free
+ * @dropped: whether the packet is freed because is is dropped
  *
  * This frees a forwarding packet and releases any resources it might
  * have claimed.
  */
-void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
+			     bool dropped)
 {
-	kfree_skb(forw_packet->skb);
+	if (dropped)
+		kfree_skb(forw_packet->skb);
+	else
+		consume_skb(forw_packet->skb);
+
 	if (forw_packet->if_incoming)
 		batadv_hardif_put(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
@@ -597,7 +603,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	return NETDEV_TX_OK;
 
 err_packet_free:
-	batadv_forw_packet_free(forw_packet);
+	batadv_forw_packet_free(forw_packet, true);
 err:
 	return NETDEV_TX_BUSY;
 }
@@ -610,6 +616,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	bool dropped = false;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -621,11 +628,15 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
+		dropped = true;
 		goto out;
+	}
 
-	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
+	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet)) {
+		dropped = true;
 		goto out;
+	}
 
 	/* rebroadcast packet */
 	rcu_read_lock();
@@ -658,7 +669,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	}
 
 out:
-	batadv_forw_packet_free(forw_packet);
+	batadv_forw_packet_free(forw_packet, dropped);
 }
 
 void
@@ -699,7 +710,7 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
+			batadv_forw_packet_free(forw_packet, true);
 		}
 	}
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
@@ -726,7 +737,7 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
+			batadv_forw_packet_free(forw_packet, true);
 		}
 	}
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 999f786..e3968fe 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -27,7 +27,8 @@
 
 struct sk_buff;
 
-void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet);
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
+			     bool dropped);
 struct batadv_forw_packet *
 batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e508bf5..cb5b966 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -341,7 +341,7 @@ send:
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb.
 		 */
-		kfree_skb(skb);
+		consume_skb(skb);
 
 	/* unicast packet */
 	} else {
-- 
2.8.1

