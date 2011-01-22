Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:24 +0100
Message-Id: <1295659302-7171-2-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 01/19] batman-adv: Add packet structures for
	multicast optimizations
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

This adds the possibility to attach multicast announcements - so called
MCAs - to OGMs. It also adds a packet structure for the multicast path
selection and a packet types needed for the future multicast
optimizations.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 hard-interface.c |    1 +
 packet.h         |   41 +++++++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 3ab9a20..2bae3e4 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -313,6 +313,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
+	batman_packet->num_mca = 0;
 
 	batman_if->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index 2284e81..a02f793 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -24,15 +24,17 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET       0x01
-#define BAT_ICMP         0x02
-#define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
-#define BAT_VIS          0x05
-#define BAT_UNICAST_FRAG 0x06
+#define BAT_PACKET        0x01
+#define BAT_ICMP          0x02
+#define BAT_UNICAST       0x03
+#define BAT_BCAST         0x04
+#define BAT_VIS           0x05
+#define BAT_UNICAST_FRAG  0x06
+#define BAT_MCAST         0x07
+#define BAT_MCAST_TRACKER 0x08
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 12
+#define COMPAT_VERSION 14
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -61,8 +63,8 @@ struct batman_packet {
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
 	uint8_t  num_hna;
+	uint8_t  num_mca;
 	uint8_t  gw_flags;  /* flags related to gateway class */
-	uint8_t  align;
 } __packed;
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
@@ -120,6 +122,29 @@ struct bcast_packet {
 	uint32_t seqno;
 } __packed;
 
+struct mcast_packet {
+	uint8_t  packet_type;    /* BAT_MCAST */
+	uint8_t  version;        /* batman version field */
+	uint8_t  orig[6];
+	uint32_t seqno;
+	uint8_t  ttl;
+} __packed;
+
+/* marks the path for multicast streams */
+struct mcast_tracker_packet {
+	uint8_t  packet_type;    /* BAT_MCAST_TRACKER */
+	uint8_t  version;        /* batman version field */
+	uint8_t  orig[6];
+	uint8_t  ttl;
+	uint8_t  num_mcast_entries;
+	uint8_t  align[2];
+} __packed;
+
+struct mcast_entry {
+	uint8_t  mcast_addr[6];
+	uint8_t  num_dest;       /* number of multicast data receivers */
+};
+
 struct vis_packet {
 	uint8_t  packet_type;
 	uint8_t  version;        /* batman version field */
-- 
1.7.2.3

