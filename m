Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Feb 2017 17:45:39 +0100
Message-Id: <20170220164539.27339-2-sven@narfation.org>
In-Reply-To: <20170220164539.27339-1-sven@narfation.org>
References: <20170220164539.27339-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix possible side-effects in
	macros
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

An argument of a macro should not be used multiple times. Otherwise
embedded operations in these arguments will be executed multiple times.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/log.h  | 5 +++--
 net/batman-adv/main.h | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 7a2b9f4..65ce97e 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -73,9 +73,10 @@ __printf(2, 3);
 /* possibly ratelimited debug output */
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
-		if (atomic_read(&(bat_priv)->log_level) & (type) &&	\
+		struct batadv_priv *__batpriv = (bat_priv);		\
+		if (atomic_read(&__batpriv->log_level) & (type) &&	\
 		    (!(ratelimited) || net_ratelimit()))		\
-			batadv_debug_log(bat_priv, fmt, ## arg);	\
+			batadv_debug_log(__batpriv, fmt, ## arg);	\
 	}								\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 57a8103..9aab2e6 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -200,8 +200,10 @@ struct packet_type;
 struct seq_file;
 struct sk_buff;
 
-#define BATADV_PRINT_VID(vid) (((vid) & BATADV_VLAN_HAS_TAG) ? \
-			       (int)((vid) & VLAN_VID_MASK) : -1)
+#define BATADV_PRINT_VID(vid) ({ \
+	unsigned short _vid = (vid); \
+	(_vid & BATADV_VLAN_HAS_TAG) ? (int)(_vid & VLAN_VID_MASK) : -1; \
+})
 
 extern struct list_head batadv_hardif_list;
 
-- 
2.11.0

