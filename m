Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/4] batman-adv: remove unused struct definitions
Date: Fri, 16 Sep 2022 18:14:54 +0200
Message-Id: <20220916161454.1413154-5-sw@simonwunderlich.de>
In-Reply-To: <20220916161454.1413154-1-sw@simonwunderlich.de>
References: <20220916161454.1413154-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2be5d4a712c5..758cd797a063 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1740,45 +1740,6 @@ struct batadv_priv {
 #endif
 };
 
-/**
- * struct batadv_socket_client - layer2 icmp socket client data
- */
-struct batadv_socket_client {
-	/**
-	 * @queue_list: packet queue for packets destined for this socket client
-	 */
-	struct list_head queue_list;
-
-	/** @queue_len: number of packets in the packet queue (queue_list) */
-	unsigned int queue_len;
-
-	/** @index: socket client's index in the batadv_socket_client_hash */
-	unsigned char index;
-
-	/** @lock: lock protecting queue_list, queue_len & index */
-	spinlock_t lock;
-
-	/** @queue_wait: socket client's wait queue */
-	wait_queue_head_t queue_wait;
-
-	/** @bat_priv: pointer to soft_iface this client belongs to */
-	struct batadv_priv *bat_priv;
-};
-
-/**
- * struct batadv_socket_packet - layer2 icmp packet for socket client
- */
-struct batadv_socket_packet {
-	/** @list: list node for &batadv_socket_client.queue_list */
-	struct list_head list;
-
-	/** @icmp_len: size of the layer2 icmp packet */
-	size_t icmp_len;
-
-	/** @icmp_packet: layer2 icmp packet */
-	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
-};
-
 #ifdef CONFIG_BATMAN_ADV_BLA
 
 /**
-- 
2.30.2

