Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 14 Aug 2015 22:57:08 +0200
Message-Id: <1439585834-26564-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
References: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Make NC capability changes
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

Fixes: 3f4841ffb336 ("batman-adv: tvlv - add network coding container")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/network-coding.c | 7 ++++---
 net/batman-adv/types.h          | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f0a50f3..4660401 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/debugfs.h>
@@ -134,9 +135,9 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
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
@@ -894,7 +895,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* check if orig node is network coding enabled */
-	if (!(orig_node->capabilities & BATADV_ORIG_CAPA_HAS_NC))
+	if (!test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabilities))
 		goto out;
 
 	/* accept ogms from 'good' neighbors and single hop neighbors */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 29fd625..ed4aec5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -314,7 +314,7 @@ struct batadv_orig_node {
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
-	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
+	BATADV_ORIG_CAPA_HAS_NC,
 	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
-- 
2.5.0

