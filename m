Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH] batman-adv: remove unused struct definitions
Date: Wed, 14 Sep 2022 20:37:11 +0200
Message-Id: <20220914183711.1399253-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/types.h | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2be5d4a7..758cd797 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1740,45 +1740,6 @@ struct batadv_priv {
 #endif
 };
=20
-/**
- * struct batadv_socket_client - layer2 icmp socket client data
- */
-struct batadv_socket_client {
-	/**
-	 * @queue_list: packet queue for packets destined for this socket clien=
t
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
=20
 /**
--=20
2.37.2
