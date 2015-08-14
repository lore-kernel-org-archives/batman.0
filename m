Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 14 Aug 2015 22:57:09 +0200
Message-Id: <1439585834-26564-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
References: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: Make TT capability changes
	atomic
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
OGM handler might undo the set/clear of a specific bit from another
handler run in between.

Fix this by using the atomic set_bit()/clear_bit()/test_bit() functions.

Fixes: e17931d1a61d ("batman-adv: introduce capability initialization bitfield")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 8 +++++---
 net/batman-adv/types.h             | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b482495..1573489 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
@@ -1862,7 +1863,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		}
 		spin_unlock_bh(list_lock);
 	}
-	orig_node->capa_initialized &= ~BATADV_ORIG_CAPA_HAS_TT;
+	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
@@ -2821,7 +2822,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				return;
 		}
 	}
-	orig_node->capa_initialized |= BATADV_ORIG_CAPA_HAS_TT;
+	set_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
@@ -3321,7 +3322,8 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 	bool has_tt_init;
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
-	has_tt_init = orig_node->capa_initialized & BATADV_ORIG_CAPA_HAS_TT;
+	has_tt_init = test_bit(BATADV_ORIG_CAPA_HAS_TT,
+			       &orig_node->capa_initialized);
 
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ed4aec5..6f801ef 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -274,7 +274,7 @@ struct batadv_orig_node {
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
 	unsigned long capabilities;
-	uint8_t capa_initialized;
+	unsigned long capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
@@ -315,7 +315,7 @@ struct batadv_orig_node {
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC,
-	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
+	BATADV_ORIG_CAPA_HAS_TT,
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
 
-- 
2.5.0

