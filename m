Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 28 Aug 2013 13:28:09 +0200
Message-Id: <1377689291-2412-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1377689291-2412-1-git-send-email-ordex@autistici.org>
References: <1377689291-2412-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: move enum definition at the
	top of the file
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9886a2f..0a8a80c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -28,6 +28,22 @@
 #include "bat_algo.h"
 #include "network-coding.h"
 
+
+/**
+ * batadv_dup_status - duplicate status
+ * @BATADV_NO_DUP: the packet is a duplicate
+ * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
+ *  neighbor)
+ * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
+ * @BATADV_PROTECTED: originator is currently protected (after reboot)
+ */
+enum batadv_dup_status {
+	BATADV_NO_DUP = 0,
+	BATADV_ORIG_DUP,
+	BATADV_NEIGH_DUP,
+	BATADV_PROTECTED,
+};
+
 /**
  * batadv_ring_buffer_set - update the ring buffer with the given value
  * @lq_recv: pointer to the ring buffer
@@ -71,21 +87,6 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 	return (uint8_t)(sum / count);
 }
 
-/*
- * batadv_dup_status - duplicate status
- * @BATADV_NO_DUP: the packet is a duplicate
- * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
- *  neighbor)
- * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
- * @BATADV_PROTECTED: originator is currently protected (after reboot)
- */
-enum batadv_dup_status {
-	BATADV_NO_DUP = 0,
-	BATADV_ORIG_DUP,
-	BATADV_NEIGH_DUP,
-	BATADV_PROTECTED,
-};
-
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const uint8_t *neigh_addr,
-- 
1.8.1.5

