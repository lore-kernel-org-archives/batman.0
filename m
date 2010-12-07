Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue,  7 Dec 2010 15:39:30 +0100
Message-Id: <1291732778-27441-3-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Adding jittering methods
	for ndp
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

This patch adds a function for fetching and jittering an ndp interval
from batman-if structure. Needed later for timing the neighbor discovery
packets.
---
 hard-interface.c |    2 +-
 routing.c        |    2 +-
 send.c           |   18 +++++++++++++-----
 send.h           |    3 ++-
 types.h          |    1 +
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 784c475..da7b9a9 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -360,7 +360,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 			batman_if->net_dev->name);
 
 	/* begin scheduling originator messages on that interface */
-	schedule_own_packet(batman_if);
+	schedule_own_ogm_packet(batman_if);
 
 out:
 	return 0;
diff --git a/routing.c b/routing.c
index a9406ba..7ebb631 100644
--- a/routing.c
+++ b/routing.c
@@ -561,7 +561,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if (batman_packet_ogm->packet_type != BAT_PACKET_OGM)
 		return;
 
-	/* could be changed by schedule_own_packet() */
+	/* could be changed by schedule_own_ogm_packet() */
 	if_incoming_seqno = atomic_read(&if_incoming->seqno);
 
 	has_directlink_flag = (batman_packet_ogm->flags & DIRECTLINK ? 1 : 0);
diff --git a/send.c b/send.c
index eb9c1e3..910411c 100644
--- a/send.c
+++ b/send.c
@@ -40,8 +40,16 @@ static uint8_t hop_penalty(const uint8_t tq, struct bat_priv *bat_priv)
 	return (tq * (TQ_MAX_VALUE - hop_penalty)) / (TQ_MAX_VALUE);
 }
 
-/* when do we schedule our own packet to be sent */
-static unsigned long own_send_time(struct bat_priv *bat_priv)
+/* when do we schedule our own neighbor discovery packet to be sent */
+unsigned long own_ndp_send_time(struct batman_if *batman_if)
+{
+	return jiffies + msecs_to_jiffies(
+		   atomic_read(&batman_if->ndp_interval) -
+		   JITTER + (random32() % 2*JITTER));
+}
+
+/* when do we schedule our own originator packet to be sent */
+static unsigned long own_ogm_send_time(struct bat_priv *bat_priv)
 {
 	return jiffies + msecs_to_jiffies(
 		   atomic_read(&bat_priv->orig_interval) -
@@ -243,7 +251,7 @@ static void rebuild_batman_packet_ogm(struct bat_priv *bat_priv,
 	}
 }
 
-void schedule_own_packet(struct batman_if *batman_if)
+void schedule_own_ogm_packet(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	unsigned long send_time;
@@ -296,7 +304,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
-	send_time = own_send_time(bat_priv);
+	send_time = own_ogm_send_time(bat_priv);
 	add_bat_packet_to_list(bat_priv,
 			       batman_if->packet_buff,
 			       batman_if->packet_len,
@@ -513,7 +521,7 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	 * shutting down
 	 */
 	if (forw_packet->own)
-		schedule_own_packet(forw_packet->if_incoming);
+		schedule_own_ogm_packet(forw_packet->if_incoming);
 
 out:
 	/* don't count own packet */
diff --git a/send.h b/send.h
index acf59e7..b626ddf 100644
--- a/send.h
+++ b/send.h
@@ -27,7 +27,8 @@
 int send_skb_packet(struct sk_buff *skb,
 				struct batman_if *batman_if,
 				uint8_t *dst_addr);
-void schedule_own_packet(struct batman_if *batman_if);
+unsigned long own_ndp_send_time(struct batman_if *batman_if);
+void schedule_own_ogm_packet(struct batman_if *batman_if);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
 			     struct batman_packet_ogm *batman_packet_ogm,
diff --git a/types.h b/types.h
index 1d00849..8921e20 100644
--- a/types.h
+++ b/types.h
@@ -47,6 +47,7 @@ struct batman_if {
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
+	atomic_t ndp_interval;
 };
 
 /**
-- 
1.7.1

