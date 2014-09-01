Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  1 Sep 2014 14:37:27 +0200
Message-Id: <1409575049-32726-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
References: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: checkpatch - Please use a
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 debugfs.c               | 1 +
 distributed-arp-table.c | 1 +
 gateway_client.c        | 1 +
 packet.h                | 1 +
 4 files changed, 4 insertions(+)

diff --git a/debugfs.c b/debugfs.c
index a12e25e..d9b9a8e 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -405,6 +405,7 @@ struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
 		.release = single_release,			\
 	},							\
 }
+
 static BATADV_HARDIF_DEBUGINFO(originators, S_IRUGO,
 			       batadv_originators_hardif_open);
 
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b598111..aad022d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1100,6 +1100,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
 	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
 }
+
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
  * DAT storage only
diff --git a/gateway_client.c b/gateway_client.c
index 90cff58..bcc3e0c 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -775,6 +775,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 
 	return ret;
 }
+
 /**
  * batadv_gw_out_of_range - check if the dhcp request destination is the best gw
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/packet.h b/packet.h
index 34e096d..facd1fe 100644
--- a/packet.h
+++ b/packet.h
@@ -198,6 +198,7 @@ struct batadv_bla_claim_dst {
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
+
 #pragma pack()
 
 /**
-- 
1.8.5.5

