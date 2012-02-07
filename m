Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue,  7 Feb 2012 17:20:51 +0800
Message-Id: <1328606451-3418-7-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: mark existing ogm variables
	as batman iv
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The coming protocol changes also will have a part called "OGM". That
makes it necessary to introduce a distinction in the code base.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c     |    4 ++--
 hard-interface.c |    2 +-
 packet.h         |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index da93525..caa67e4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -47,7 +47,7 @@ static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 		goto out;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
-	batman_ogm_packet->header.packet_type = BAT_OGM;
+	batman_ogm_packet->header.packet_type = BAT_IV_OGM;
 	batman_ogm_packet->header.version = COMPAT_VERSION;
 	batman_ogm_packet->header.ttl = 2;
 	batman_ogm_packet->flags = NO_FLAGS;
@@ -942,7 +942,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	 * packet in an aggregation.  Here we expect that the padding
 	 * is always zero (or not 0x01)
 	 */
-	if (batman_ogm_packet->header.packet_type != BAT_OGM)
+	if (batman_ogm_packet->header.packet_type != BAT_IV_OGM)
 		return;
 
 	/* could be changed by schedule_own_packet() */
diff --git a/hard-interface.c b/hard-interface.c
index 2a435ec..30b1c07 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -617,7 +617,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	switch (batman_ogm_packet->header.packet_type) {
 		/* batman originator packet */
-	case BAT_OGM:
+	case BAT_IV_OGM:
 		ret = recv_bat_ogm_packet(skb, hard_iface);
 		break;
 
diff --git a/packet.h b/packet.h
index ed16ec3..7971a69 100644
--- a/packet.h
+++ b/packet.h
@@ -25,7 +25,7 @@
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 enum bat_packettype {
-	BAT_OGM		 = 0x01,
+	BAT_IV_OGM	 = 0x01,
 	BAT_ICMP	 = 0x02,
 	BAT_UNICAST	 = 0x03,
 	BAT_BCAST	 = 0x04,
@@ -38,7 +38,7 @@ enum bat_packettype {
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 14
 
-enum batman_flags {
+enum batman_iv_flags {
 	PRIMARIES_FIRST_HOP = 1 << 4,
 	VIS_SERVER	    = 1 << 5,
 	DIRECTLINK	    = 1 << 6
-- 
1.7.5.4

