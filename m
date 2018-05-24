Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:55 +0200
Message-Id: <20180524120300.15829-4-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: Avoid old nodes disabling
 multicast optimizations completely
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

Instead of disabling multicast optimizations mesh-wide once a node with
no multicast optimizations capabilities joins the mesh, do the
following:

Just insert such nodes into the WANT_ALL_IPV4/IPV6 lists. This is
sufficient to avoid multicast packet loss to such unsupportive nodes.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c      | 29 ++++++-----------------------
 net/batman-adv/soft-interface.c |  1 -
 net/batman-adv/types.h          |  3 ---
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index a11d3d89f012..36fd7b06c7cc 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -815,9 +815,6 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	if (!atomic_read(&bat_priv->multicast_mode))
 		return -EINVAL;
 
-	if (atomic_read(&bat_priv->mcast.num_disabled))
-		return -EINVAL;
-
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
@@ -1183,33 +1180,23 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
 {
 	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	u8 mcast_flags = BATADV_NO_FLAGS;
-	bool orig_initialized;
 
 	if (orig_mcast_enabled && tvlv_value &&
 	    tvlv_value_len >= sizeof(mcast_flags))
 		mcast_flags = *(u8 *)tvlv_value;
 
+	if (!orig_mcast_enabled) {
+		mcast_flags |= BATADV_MCAST_WANT_ALL_IPV4;
+		mcast_flags |= BATADV_MCAST_WANT_ALL_IPV6;
+	}
+
 	spin_lock_bh(&orig->mcast_handler_lock);
-	orig_initialized = test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
-				    &orig->capa_initialized);
 
-	/* If mcast support is turned on decrease the disabled mcast node
-	 * counter only if we had increased it for this node before. If this
-	 * is a completely new orig_node no need to decrease the counter.
-	 */
 	if (orig_mcast_enabled &&
 	    !test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) {
-		if (orig_initialized)
-			atomic_dec(&bat_priv->mcast.num_disabled);
 		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
-	/* If mcast support is being switched off or if this is an initial
-	 * OGM without mcast support then increase the disabled mcast
-	 * node counter.
-	 */
 	} else if (!orig_mcast_enabled &&
-		   (test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities) ||
-		    !orig_initialized)) {
-		atomic_inc(&bat_priv->mcast.num_disabled);
+		   test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) {
 		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	}
 
@@ -1595,10 +1582,6 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 
 	spin_lock_bh(&orig->mcast_handler_lock);
 
-	if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities) &&
-	    test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized))
-		atomic_dec(&bat_priv->mcast.num_disabled);
-
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv4_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv6_update(bat_priv, orig, BATADV_NO_FLAGS);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9f3a2..67065e35de51 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -796,7 +796,6 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->mcast.querier_ipv6.shadowing = false;
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
 	atomic_set(&bat_priv->multicast_mode, 1);
-	atomic_set(&bat_priv->mcast.num_disabled, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 476b052ad982..0174f79e955a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1212,9 +1212,6 @@ struct batadv_priv_mcast {
 	/** @bridged: whether the soft interface has a bridge on top */
 	bool bridged;
 
-	/** @num_disabled: number of nodes that have no mcast tvlv */
-	atomic_t num_disabled;
-
 	/**
 	 * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP
 	 *  traffic
-- 
2.11.0

