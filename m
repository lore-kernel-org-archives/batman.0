Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Nov 2010 17:46:01 +0100
Message-Id: <1289148361-16019-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add sequence number and
	duplicate checks for unicasts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

When a node is set in promiscuous mode it might receive a unicast data
packet more than once. Therefore sequence number checking is required.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 originator.c     |    2 ++
 packet.h         |    4 +++-
 routing.c        |   11 ++++++++++-
 soft-interface.c |    1 +
 types.h          |    2 ++
 unicast.c        |    6 ++++++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/originator.c b/originator.c
index e888416..d71a59f 100644
--- a/originator.c
+++ b/originator.c
@@ -147,6 +147,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
+	orig_node->ucast_seqno_state.seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_state.seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 	orig_node->batman_seqno_reset = jiffies - 1
diff --git a/packet.h b/packet.h
index b49fdf7..fe60fae 100644
--- a/packet.h
+++ b/packet.h
@@ -32,7 +32,7 @@
 #define BAT_UNICAST_FRAG 0x06
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 12
+#define COMPAT_VERSION 13
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -98,7 +98,9 @@ struct icmp_packet_rr {
 struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
 	uint8_t  dest[6];
+	uint32_t seqno;
 	uint8_t  ttl;
 } __attribute__((packed));
 
diff --git a/routing.c b/routing.c
index 761fd84..9a2d41f 100644
--- a/routing.c
+++ b/routing.c
@@ -1146,6 +1146,9 @@ static inline int check_duplicate(struct bat_priv *bat_priv, uint8_t *orig,
 		case BAT_BCAST:
 			seqno_state = &orig_node->bcast_seqno_state;
 			break;
+		case BAT_UNICAST:
+			seqno_state = &orig_node->ucast_seqno_state;
+			break;
 		default:
 			goto out;
 	}
@@ -1261,9 +1264,10 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_packet);
-	int check_ret;
+	int ret, check_ret;
 
 	check_ret = check_unicast_packet(skb, hdr_size);
 	if (check_ret < 0)
@@ -1271,6 +1275,11 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
+	ret = check_duplicate(bat_priv, unicast_packet->orig,
+			      ntohl(unicast_packet->seqno), BAT_UNICAST);
+	if (ret)
+		return NET_RX_DROP;
+
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/soft-interface.c b/soft-interface.c
index e16c61b..3a97d59 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -596,6 +596,7 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
+	atomic_set(&bat_priv->ucast_seqno, 1);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->hna_local_changed, 0);
 
diff --git a/types.h b/types.h
index 87eb780..98261d0 100644
--- a/types.h
+++ b/types.h
@@ -89,6 +89,7 @@ struct orig_node {
 	struct list_head neigh_list;
 	struct list_head frag_list;
 	unsigned long last_frag_packet;
+	struct seqno_state ucast_seqno_state;
 	struct seqno_state bcast_seqno_state;
 	struct {
 		uint8_t candidates;
@@ -136,6 +137,7 @@ struct bat_priv {
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
 	atomic_t log_level;		/* uint */
+	atomic_t ucast_seqno;
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
diff --git a/unicast.c b/unicast.c
index 7b9385b..def2588 100644
--- a/unicast.c
+++ b/unicast.c
@@ -323,6 +323,12 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	unicast_packet->ttl = TTL;
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* copy the originator */
+	memcpy(unicast_packet->orig, bat_priv->primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
+	/* set unicast sequence number */
+	unicast_packet->seqno =
+		htonl(atomic_inc_return(&bat_priv->ucast_seqno));
 
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
-- 
1.7.1

