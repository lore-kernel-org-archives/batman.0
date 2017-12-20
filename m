Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:22 +0100
Message-Id: <20171220110124.13117-18-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/19] batman-adv: Add kernel-doc to enums in
 headers
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

All enums in types.h are already documented. But some other headers
still have private enums which also should be documented.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.h | 23 +++++++++++++++++++++++
 net/batman-adv/main.h           | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index fb7a5d6b5ce3..1e61aacac539 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -31,12 +31,35 @@
 struct net_device;
 struct net;
 
+/**
+ * enum batadv_hard_if_state - State of a hard interface
+ */
 enum batadv_hard_if_state {
+	/**
+	 * @BATADV_IF_NOT_IN_USE: interface is not used as slave interface of a
+	 * batman-adv soft interface
+	 */
 	BATADV_IF_NOT_IN_USE,
+
+	/**
+	 * @BATADV_IF_TO_BE_REMOVED: interface will be removed from soft
+	 * interface
+	 */
 	BATADV_IF_TO_BE_REMOVED,
+
+	/** @BATADV_IF_INACTIVE: interface is deactivated */
 	BATADV_IF_INACTIVE,
+
+	/** @BATADV_IF_ACTIVE: interface is used */
 	BATADV_IF_ACTIVE,
+
+	/** @BATADV_IF_TO_BE_ACTIVATED: interface is getting activated */
 	BATADV_IF_TO_BE_ACTIVATED,
+
+	/**
+	 * @BATADV_IF_I_WANT_YOU: interface is queued up (using sysfs) for being
+	 * added as slave interface of a batman-adv soft interface
+	 */
 	BATADV_IF_I_WANT_YOU,
 };
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 7f6a3123e1a4..633e6e41ba14 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -141,24 +141,56 @@
  */
 #define BATADV_TP_MAX_NUM 5
 
+/**
+ * enum batadv_mesh_state - State of a soft interface
+ */
 enum batadv_mesh_state {
+	/** @BATADV_MESH_INACTIVE: soft interface is not yet running */
 	BATADV_MESH_INACTIVE,
+
+	/** @BATADV_MESH_ACTIVE: interface is up and running */
 	BATADV_MESH_ACTIVE,
+
+	/** @BATADV_MESH_DEACTIVATING: interface is getting shut down */
 	BATADV_MESH_DEACTIVATING,
 };
 
 #define BATADV_BCAST_QUEUE_LEN		256
 #define BATADV_BATMAN_QUEUE_LEN	256
 
+/**
+ * enum batadv_uev_action - action type of uevent
+ */
 enum batadv_uev_action {
+	/** @BATADV_UEV_ADD: gateway was selected (after none was selected) */
 	BATADV_UEV_ADD = 0,
+
+	/**
+	 * @BATADV_UEV_DEL: selected gateway was removed and none is selected
+	 * anymore
+	 */
 	BATADV_UEV_DEL,
+
+	/**
+	 * @BATADV_UEV_CHANGE: a different gateway was selected as based gateway
+	 */
 	BATADV_UEV_CHANGE,
+
+	/**
+	 * @BATADV_UEV_LOOPDETECT: loop was detected which cannot be handled by
+	 * bridge loop avoidance
+	 */
 	BATADV_UEV_LOOPDETECT,
 };
 
+/**
+ * enum batadv_uev_type - Type of uevent
+ */
 enum batadv_uev_type {
+	/** @BATADV_UEV_GW: selected gateway was modified */
 	BATADV_UEV_GW = 0,
+
+	/** @BATADV_UEV_BLA: bridge loop avoidance event */
 	BATADV_UEV_BLA,
 };
 
-- 
2.11.0

