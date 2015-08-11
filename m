Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Aug 2015 18:35:44 +0200
Message-Id: <1439310948-32426-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
References: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/10] batman-adv: Make MCAST capability
	changes atomic
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

Fixes: 60432d756cf0 ("batman-adv: Announce new capability via multicast TVLV")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/multicast.c | 18 ++++++++++--------
 net/batman-adv/types.h     |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 7aa480b..f92473d 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -697,29 +698,30 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	uint8_t mcast_flags = BATADV_NO_FLAGS;
 	bool orig_initialized;
 
-	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
+	orig_initialized = test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+				    &orig->capa_initialized);
 
 	/* If mcast support is turned on decrease the disabled mcast node
 	 * counter only if we had increased it for this node before. If this
 	 * is a completely new orig_node no need to decrease the counter.
 	 */
 	if (orig_mcast_enabled &&
-	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
+	    !(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities))) {
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	/* If mcast support is being switched off or if this is an initial
 	 * OGM without mcast support then increase the disabled mcast
 	 * node counter.
 	 */
 	} else if (!orig_mcast_enabled &&
-		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
+		   (test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities) ||
 		    !orig_initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
+		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	}
 
-	orig->capa_initialized |= BATADV_ORIG_CAPA_HAS_MCAST;
+	set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized);
 
 	if (orig_mcast_enabled && tvlv_value &&
 	    (tvlv_value_len >= sizeof(mcast_flags)))
@@ -763,8 +765,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 {
 	struct batadv_priv *bat_priv = orig->bat_priv;
 
-	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
-	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
+	if (!(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) &&
+	    test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized))
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6f801ef..1eeed18 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -316,7 +316,7 @@ enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC,
 	BATADV_ORIG_CAPA_HAS_TT,
-	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
+	BATADV_ORIG_CAPA_HAS_MCAST,
 };
 
 /**
-- 
2.5.0

