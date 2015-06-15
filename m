Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 15 Jun 2015 08:22:24 +0200
Message-Id: <1434349345-12854-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Make originator
 capability changes atomic
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

Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
OGM handler might undo the set/clear of a specific bit from another
handler run in between. This can lead to various issues in other
code paths, including kernel panics.

Fix this by using the atomic set_bit()/clear_bit() functions.

Fixes: 2b1c07b918d2 ("batman-adv: tvlv - add distributed arp table container")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 distributed-arp-table.c |    4 ++--
 multicast.c             |    6 +++---
 network-coding.c        |    4 ++--
 translation-table.c     |    4 ++--
 types.h                 |    4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 0d791dc..b2cc19b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -682,9 +682,9 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   uint16_t tvlv_value_len)
 {
 	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_DAT;
+		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
 	else
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_DAT;
+		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
 }
 
 /**
diff --git a/multicast.c b/multicast.c
index 09f2838..00612bf 100644
--- a/multicast.c
+++ b/multicast.c
@@ -684,7 +684,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	/* If mcast support is being switched off or if this is an initial
 	 * OGM without mcast support then increase the disabled mcast
 	 * node counter.
@@ -693,10 +693,10 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
 		    !orig_initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
+		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	}
 
-	orig->capa_initialized |= BATADV_ORIG_CAPA_HAS_MCAST;
+	set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized);
 
 	if (orig_mcast_enabled && tvlv_value &&
 	    (tvlv_value_len >= sizeof(mcast_flags)))
diff --git a/network-coding.c b/network-coding.c
index 89e1d47..3ce493e 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -105,9 +105,9 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  uint16_t tvlv_value_len)
 {
 	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_NC;
+		clear_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
 	else
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_NC;
+		set_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
 }
 
 /**
diff --git a/translation-table.c b/translation-table.c
index b098e53..e95a424 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1843,7 +1843,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		}
 		spin_unlock_bh(list_lock);
 	}
-	orig_node->capa_initialized &= ~BATADV_ORIG_CAPA_HAS_TT;
+	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
@@ -2802,7 +2802,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				return;
 		}
 	}
-	orig_node->capa_initialized |= BATADV_ORIG_CAPA_HAS_TT;
+	set_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
diff --git a/types.h b/types.h
index 28f2461..c6ec558 100644
--- a/types.h
+++ b/types.h
@@ -256,8 +256,8 @@ struct batadv_orig_node {
 	struct hlist_node mcast_want_all_ipv4_node;
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
-	uint8_t capabilities;
-	uint8_t capa_initialized;
+	unsigned long capabilities;
+	unsigned long capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
-- 
1.7.10.4

