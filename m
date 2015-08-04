Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  4 Aug 2015 18:35:24 +0200
Message-Id: <1438706134-3492-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
References: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/14] batman-adv: Make DAT capability
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

Fixes: 17cf0ea455f1 ("batman-adv: tvlv - add distributed arp table container")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/distributed-arp-table.c | 7 ++++---
 net/batman-adv/types.h                 | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 6d0b471..1aa4e7e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -453,7 +454,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	int j;
 
 	/* check if orig node candidate is running DAT */
-	if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
+	if (!(test_bit(BATADV_ORIG_CAPA_HAS_DAT, &candidate->capabilities)))
 		goto out;
 
 	/* Check if this node has already been selected... */
@@ -713,9 +714,9 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
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
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 67d6348..29fd625 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -273,7 +273,7 @@ struct batadv_orig_node {
 	struct hlist_node mcast_want_all_ipv4_node;
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
-	uint8_t capabilities;
+	unsigned long capabilities;
 	uint8_t capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
@@ -313,7 +313,7 @@ struct batadv_orig_node {
  *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
-	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
+	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
 	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
-- 
2.5.0

