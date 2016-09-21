Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 21 Sep 2016 09:23:50 +0200
Message-Id: <20160921072350.13823-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid precedence issues in macros
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

It must be avoided that arguments to a macro are evaluated ungrouped (which
enforces normal operator precendence). Otherwise the result of the macro
is not well defined.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/log.h    | 12 ++++++------
 net/batman-adv/main.h   |  4 ++--
 net/batman-adv/packet.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index e0e1a88..ab47acf 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -71,12 +71,12 @@ int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 __printf(2, 3);
 
 /* possibly ratelimited debug output */
-#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\
-	do {							\
-		if (atomic_read(&bat_priv->log_level) & type && \
-		    (!ratelimited || net_ratelimit()))		\
-			batadv_debug_log(bat_priv, fmt, ## arg);\
-	}							\
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
+	do {								\
+		if (atomic_read(&(bat_priv)->log_level) & (type) &&	\
+		    (!(ratelimited) || net_ratelimit()))		\
+			batadv_debug_log(bat_priv, fmt, ## arg);	\
+	}								\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
 __printf(4, 5)
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 09af21e..07a6e19 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -200,8 +200,8 @@ struct packet_type;
 struct seq_file;
 struct sk_buff;
 
-#define BATADV_PRINT_VID(vid) ((vid & BATADV_VLAN_HAS_TAG) ? \
-			       (int)(vid & VLAN_VID_MASK) : -1)
+#define BATADV_PRINT_VID(vid) (((vid) & BATADV_VLAN_HAS_TAG) ? \
+			       (int)((vid) & VLAN_VID_MASK) : -1)
 
 extern struct list_head batadv_hardif_list;
 
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6afc0b8..4265eba 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -21,7 +21,7 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
-#define batadv_tp_is_error(n) ((u8)n > 127 ? 1 : 0)
+#define batadv_tp_is_error(n) ((u8)(n) > 127 ? 1 : 0)
 
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
-- 
2.9.3

