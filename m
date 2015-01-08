Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:14 +0100
Message-Id: <1420730120-9844-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 09/15] batman-adv: checkpatch - Please use a
	blank line after declarations
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/debugfs.c               | 1 +
 net/batman-adv/distributed-arp-table.c | 1 +
 net/batman-adv/gateway_client.c        | 1 +
 net/batman-adv/packet.h                | 1 +
 4 files changed, 4 insertions(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 1485091..a4972874 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -404,6 +404,7 @@ struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
 		.release = single_release,			\
 	},							\
 }
+
 static BATADV_HARDIF_DEBUGINFO(originators, S_IRUGO,
 			       batadv_originators_hardif_open);
 
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b598111..aad022d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1100,6 +1100,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
 	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
 }
+
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
  * DAT storage only
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e0bcf9e..27649e8 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -775,6 +775,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 
 	return ret;
 }
+
 /**
  * batadv_gw_out_of_range - check if the dhcp request destination is the best gw
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 34e096d..facd1fe 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -198,6 +198,7 @@ struct batadv_bla_claim_dst {
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
+
 #pragma pack()
 
 /**
-- 
2.2.1

