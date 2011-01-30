Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:10 +0100
Message-Id: <1296362366-3852-3-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 02/18] batman-adv: Attach local MCAs to OGMs
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This patch introduces multicast announcements - MCA for short - which
are now being attached to an OGM if an optimized multicast mode needing
MCAs has been selected (i.e. proactive_tracking).

MCA entries are multicast mac addresses used by a multicast receiver in
the mesh cloud. Currently MCAs are only fetched locally from the
according batman interface itself, bridged-in hosts will not yet get
announced and will need a more complex patch for supporting IGMP/MLD
snooping. However, the local fetching also allows to have multicast
optimizations on layer 2 already for batman nodes, not depending on
IP at all.

This patch increases the COMPAT_VERSION.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 aggregation.c    |   12 +++++++-
 aggregation.h    |    6 +++-
 compat.h         |   44 +++++++++++++++++++++++++++++
 hard-interface.c |    1 +
 main.h           |    2 +
 packet.h         |    4 +-
 send.c           |   80 ++++++++++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index 1997725..0251d17 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -30,6 +30,12 @@ static int hna_len(struct batman_packet *batman_packet)
 	return batman_packet->num_hna * ETH_ALEN;
 }
 
+/* calculate the size of the mca information for a given packet */
+static int mca_len(struct batman_packet *batman_packet)
+{
+	return batman_packet->num_mca * ETH_ALEN;
+}
+
 /* return true if new_packet can be aggregated with forw_packet */
 static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 			       int packet_len,
@@ -265,9 +271,11 @@ void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 				   hna_buff, hna_len(batman_packet),
 				   if_incoming);
 
-		buff_pos += BAT_PACKET_LEN + hna_len(batman_packet);
+		buff_pos += BAT_PACKET_LEN + hna_len(batman_packet) +
+			    mca_len(batman_packet);
 		batman_packet = (struct batman_packet *)
 			(packet_buff + buff_pos);
 	} while (aggregated_packet(buff_pos, packet_len,
-				   batman_packet->num_hna));
+				   batman_packet->num_hna,
+				   batman_packet->num_mca));
 }
diff --git a/batman-adv/aggregation.h b/batman-adv/aggregation.h
index 6ce305b..a4551f8 100644
--- a/batman-adv/aggregation.h
+++ b/batman-adv/aggregation.h
@@ -25,9 +25,11 @@
 #include "main.h"
 
 /* is there another aggregated packet here? */
-static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
+static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna,
+				    int num_mca)
 {
-	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_hna * ETH_ALEN);
+	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_hna * ETH_ALEN) +
+			    (num_mca * ETH_ALEN);
 
 	return (next_buff_pos <= packet_len) &&
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index a76d0be..e7b19cd 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -270,4 +270,48 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+#define netdev_mc_count(dev) ((dev)->mc_count)
+#undef  netdev_for_each_mc_addr
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = (struct bat_dev_addr_list*)dev->mc_list; mclist; \
+	     mclist = (struct bat_dev_addr_list*)mclist->next)
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+
+/*
+ * net_device - multicast list handling
+ *	structures
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+
+/* Note, that this breaks the usage of the normal 'struct netdev_hw_addr'
+ * for kernels < 2.6.35 in batman-adv! */
+#define netdev_hw_addr bat_dev_addr_list
+struct bat_dev_addr_list {
+	struct dev_addr_list *next;
+	u8  addr[MAX_ADDR_LEN];
+	u8  da_addrlen;
+	u8  da_synced;
+	int da_users;
+	int da_gusers;
+};
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+/*
+ * net_device - multicast list handling
+ *	locking
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
+
+#define netif_addr_lock_bh(soft_iface) \
+		netif_tx_lock_bh(soft_iface)
+#define netif_addr_unlock_bh(soft_iface) \
+		netif_tx_unlock_bh(soft_iface)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index e2b001a..1455e7f 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -319,6 +319,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
+	batman_packet->num_mca = 0;
 
 	batman_if->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
diff --git a/batman-adv/main.h b/batman-adv/main.h
index 1ec9986..64c1793 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -97,6 +97,8 @@
  *  Vis
  */
 
+#define UINT8_MAX 255
+
 /*
  * Kernel headers
  */
diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index eef5371..d77af90 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -32,7 +32,7 @@
 #define BAT_UNICAST_FRAG 0x06
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 12
+#define COMPAT_VERSION 14
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -66,8 +66,8 @@ struct batman_packet {
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
 	uint8_t  num_hna;
+	uint8_t  num_mca;
 	uint8_t  gw_flags;  /* flags related to gateway class */
-	uint8_t  align;
 } __packed;
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 7cc620e..0d4a2a6 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -122,7 +122,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	/* adjust all flags and log packets */
 	while (aggregated_packet(buff_pos,
 				 forw_packet->packet_len,
-				 batman_packet->num_hna)) {
+				 batman_packet->num_hna,
+				 batman_packet->num_mca)) {
 
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet */
@@ -214,18 +215,69 @@ static void send_packet(struct forw_packet *forw_packet)
 	rcu_read_unlock();
 }
 
+static void add_own_MCA(struct batman_packet *batman_packet, int num_mca,
+		       struct net_device *soft_iface)
+{
+	struct netdev_hw_addr *mc_list_entry;
+	int num_mca_done = 0;
+	char *mca_entry = (char *)(batman_packet + 1);
+
+	if (num_mca == 0)
+		goto out;
+
+	if (num_mca > UINT8_MAX) {
+		pr_warning("Too many multicast announcements here, "
+			   "just adding %i\n", UINT8_MAX);
+		num_mca = UINT8_MAX;
+	}
+
+	mca_entry = mca_entry + batman_packet->num_hna * ETH_ALEN;
+
+	netif_addr_lock_bh(soft_iface);
+	netdev_for_each_mc_addr(mc_list_entry, soft_iface) {
+		memcpy(mca_entry, &mc_list_entry->addr, ETH_ALEN);
+		mca_entry += ETH_ALEN;
+
+		/* A multicast address might just have been added,
+		 * avoid writing outside of buffer */
+		if (++num_mca_done == num_mca)
+			break;
+	}
+	netif_addr_unlock_bh(soft_iface);
+
+out:
+	batman_packet->num_mca = num_mca_done;
+}
+
 static void rebuild_batman_packet(struct bat_priv *bat_priv,
 				  struct batman_if *batman_if)
 {
-	int new_len;
-	unsigned char *new_buff;
+	int new_len, mcast_mode, num_mca = 0;
+	unsigned char *new_buff = NULL;
 	struct batman_packet *batman_packet;
 
-	new_len = sizeof(struct batman_packet) +
-			(bat_priv->num_local_hna * ETH_ALEN);
-	new_buff = kmalloc(new_len, GFP_ATOMIC);
+	batman_packet = (struct batman_packet *)batman_if->packet_buff;
+	mcast_mode = atomic_read(&bat_priv->mcast_mode);
 
-	/* keep old buffer if kmalloc should fail */
+	/* Avoid attaching MCAs, if multicast optimization is disabled */
+	if (mcast_mode == MCAST_MODE_PROACT_TRACKING) {
+		netif_addr_lock_bh(batman_if->soft_iface);
+		num_mca = netdev_mc_count(batman_if->soft_iface);
+		netif_addr_unlock_bh(batman_if->soft_iface);
+	}
+
+	if (atomic_read(&bat_priv->hna_local_changed) ||
+	    num_mca != batman_packet->num_mca) {
+		new_len = sizeof(struct batman_packet) +
+			(bat_priv->num_local_hna * ETH_ALEN) +
+			num_mca * ETH_ALEN;
+		new_buff = kmalloc(new_len, GFP_ATOMIC);
+	}
+
+	/*
+	 * if local hna or mca has changed but kmalloc failed
+	 * then just keep the old buffer
+	 */
 	if (new_buff) {
 		memcpy(new_buff, batman_if->packet_buff,
 		       sizeof(struct batman_packet));
@@ -239,6 +291,13 @@ static void rebuild_batman_packet(struct bat_priv *bat_priv,
 		batman_if->packet_buff = new_buff;
 		batman_if->packet_len = new_len;
 	}
+
+	/**
+	 * always copy mca entries (if there are any) - we have to
+	 * traverse the list anyway, so we can just do a memcpy instead of
+	 * memcmp for the sake of simplicity
+	 */
+	add_own_MCA(batman_packet, num_mca, batman_if->soft_iface);
 }
 
 void schedule_own_packet(struct batman_if *batman_if)
@@ -264,9 +323,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	if (batman_if->if_status == IF_TO_BE_ACTIVATED)
 		batman_if->if_status = IF_ACTIVE;
 
-	/* if local hna has changed and interface is a primary interface */
-	if ((atomic_read(&bat_priv->hna_local_changed)) &&
-	    (batman_if == bat_priv->primary_if))
+	if (batman_if == bat_priv->primary_if)
 		rebuild_batman_packet(bat_priv, batman_if);
 
 	/**
@@ -359,7 +416,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	send_time = forward_send_time();
 	add_bat_packet_to_list(bat_priv,
 			       (unsigned char *)batman_packet,
-			       sizeof(struct batman_packet) + hna_buff_len,
+			       sizeof(struct batman_packet) + hna_buff_len
+			       + batman_packet->num_mca * ETH_ALEN,
 			       if_incoming, 0, send_time);
 }
 
-- 
1.7.2.3

