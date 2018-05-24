Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:57 +0200
Message-Id: <20180524120300.15829-6-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: Remove unused dentry without
 DEBUGFS
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

The debug_dir variable in the main structures is only accessed when
CONFIG_BATMAN_ADV_DEBUGFS is enabled. It can be dropped to potentially save
some bytes of memory.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 3b3fc146b30d..360357f83f20 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -215,10 +215,12 @@ struct batadv_hard_iface {
 	struct batadv_hard_iface_bat_v bat_v;
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	/**
 	 * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
 	 */
 	struct dentry *debug_dir;
+#endif
 
 	/**
 	 * @neigh_list: list of unique single hop neighbors via this interface
@@ -1242,10 +1244,12 @@ struct batadv_priv_nc {
 	/** @work: work queue callback item for cleanup */
 	struct delayed_work work;
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	/**
 	 * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
 	 */
 	struct dentry *debug_dir;
+#endif
 
 	/**
 	 * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
@@ -1598,8 +1602,10 @@ struct batadv_priv {
 	/** @mesh_obj: kobject for sysfs mesh subdirectory */
 	struct kobject *mesh_obj;
 
+#ifdef CONFIG_BATMAN_ADV_DEBUGFS
 	/** @debug_dir: dentry for debugfs batman-adv subdirectory */
 	struct dentry *debug_dir;
+#endif
 
 	/** @forw_bat_list: list of aggregated OGMs that will be forwarded */
 	struct hlist_head forw_bat_list;
-- 
2.11.0

