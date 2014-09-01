Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  1 Sep 2014 14:37:28 +0200
Message-Id: <1409575049-32726-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
References: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: checkpatch - Please don't
	use multiple blank lines
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_iv_ogm.c            | 2 --
 bitarray.c              | 1 -
 bridge_loop_avoidance.c | 7 -------
 fragmentation.c         | 1 -
 main.c                  | 1 -
 originator.c            | 1 -
 originator.h            | 1 -
 routing.c               | 1 -
 soft-interface.c        | 1 -
 sysfs.c                 | 1 -
 translation-table.c     | 1 -
 11 files changed, 18 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 73209f3..4dd7c40 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -26,7 +26,6 @@
 #include "bat_algo.h"
 #include "network-coding.h"
 
-
 /**
  * enum batadv_dup_status - duplicate status
  * @BATADV_NO_DUP: the packet is a duplicate
@@ -1362,7 +1361,6 @@ out:
 	return ret;
 }
 
-
 /**
  * batadv_iv_ogm_process_per_outif - process a batman iv OGM for an outgoing if
  * @skb: the skb containing the OGM
diff --git a/bitarray.c b/bitarray.c
index 9586750..e3da07a 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -29,7 +29,6 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
 	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
 }
 
-
 /* receive and process one packet within the sequence number window.
  *
  * returns:
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0f0ca43..4fc6cab 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -69,7 +69,6 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 	return hash % size;
 }
 
-
 /* compares address and vid of two backbone gws */
 static int batadv_compare_backbone_gw(const struct hlist_node *node,
 				      const void *data2)
@@ -662,7 +661,6 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 	if (unlikely(!backbone_gw))
 		return 1;
 
-
 	/* handle as ANNOUNCE frame */
 	backbone_gw->lasttime = jiffies;
 	crc = ntohs(*((__be16 *)(&an_addr[4])));
@@ -849,7 +847,6 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 	return 2;
 }
 
-
 /**
  * batadv_bla_process_claim
  * @bat_priv: the bat priv with all the soft interface information
@@ -1347,8 +1344,6 @@ out:
 	return ret;
 }
 
-
-
 /**
  * batadv_bla_is_backbone_gw_orig
  * @bat_priv: the bat priv with all the soft interface information
@@ -1390,7 +1385,6 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 	return false;
 }
 
-
 /**
  * batadv_bla_is_backbone_gw
  * @skb: the frame to be checked
@@ -1480,7 +1474,6 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		goto allow;
 
-
 	if (unlikely(atomic_read(&bat_priv->bla.num_requests)))
 		/* don't allow broadcasts while requests are in flight */
 		if (is_multicast_ether_addr(ethhdr->h_dest) && is_bcast)
diff --git a/fragmentation.c b/fragmentation.c
index 022d18a..022156d 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -23,7 +23,6 @@
 #include "hard-interface.h"
 #include "soft-interface.h"
 
-
 /**
  * batadv_frag_clear_chain - delete entries in the fragment buffer chain
  * @head: head of chain with entries.
diff --git a/main.c b/main.c
index 2cdd25a..d4079cd 100644
--- a/main.c
+++ b/main.c
@@ -41,7 +41,6 @@
 #include "network-coding.h"
 #include "fragmentation.h"
 
-
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked
  */
diff --git a/originator.c b/originator.c
index 6a48451..6c65c54 100644
--- a/originator.c
+++ b/originator.c
@@ -799,7 +799,6 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 	return ifinfo_purged;
 }
 
-
 /**
  * batadv_purge_orig_neighbors - purges neighbors from originator
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/originator.h b/originator.h
index db3a9ed..aa4a436 100644
--- a/originator.h
+++ b/originator.h
@@ -70,7 +70,6 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
 void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan);
 
-
 /* hashfunction to choose an entry in a hash table of given size
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
  */
diff --git a/routing.c b/routing.c
index 35f76f2..3a6764d 100644
--- a/routing.c
+++ b/routing.c
@@ -292,7 +292,6 @@ out:
 	return ret;
 }
 
-
 int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
diff --git a/soft-interface.c b/soft-interface.c
index 9bf382d..ea80e6d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -36,7 +36,6 @@
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 
-
 static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info);
diff --git a/sysfs.c b/sysfs.c
index fc47baa..a63c3eb 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -151,7 +151,6 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
-
 #define BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)	\
 ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     struct attribute *attr, char *buff,	\
diff --git a/translation-table.c b/translation-table.c
index 38a804e..84e6f01 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1780,7 +1780,6 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 		batadv_tt_global_del_roaming(bat_priv, tt_global_entry,
 					     orig_node, message);
 
-
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
-- 
1.8.5.5

