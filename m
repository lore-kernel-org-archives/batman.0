Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  6 Jun 2012 13:17:27 +0200
Message-Id: <1338981447-25754-3-git-send-email-sven@narfation.org>
In-Reply-To: <1338981447-25754-1-git-send-email-sven@narfation.org>
References: <1338981447-25754-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: Prefix packet structs with
	batadv_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h     |   44 +++++++++++++++++++--------------------
 ping.c       |    8 +++----
 tcpdump.c    |   66 +++++++++++++++++++++++++++++-----------------------------
 traceroute.c |    2 +-
 4 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/packet.h b/packet.h
index 2ca6819..c0ed5b4 100644
--- a/packet.h
+++ b/packet.h
@@ -101,20 +101,20 @@ enum batadv_bla_claimframe {
 /* the destination hardware field in the ARP frame is used to
  * transport the claim type and the group id
  */
-struct bla_claim_dst {
+struct batadv_bla_claim_dst {
 	uint8_t magic[3];	/* FF:43:05 */
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 } __packed;
 
-struct batman_header {
+struct batadv_header {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  ttl;
 } __packed;
 
-struct batman_ogm_packet {
-	struct batman_header header;
+struct batadv_ogm_packet {
+	struct batadv_header header;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
@@ -126,10 +126,10 @@ struct batman_ogm_packet {
 	__be16   tt_crc;
 } __packed;
 
-#define BATADV_OGM_HLEN sizeof(struct batman_ogm_packet)
+#define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
-struct icmp_packet {
-	struct batman_header header;
+struct batadv_icmp_packet {
+	struct batadv_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
@@ -143,8 +143,8 @@ struct icmp_packet {
 /* icmp_packet_rr must start with all fields from imcp_packet
  * as this is assumed by code that handles ICMP packets
  */
-struct icmp_packet_rr {
-	struct batman_header header;
+struct batadv_icmp_packet_rr {
+	struct batadv_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
@@ -154,14 +154,14 @@ struct icmp_packet_rr {
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
-struct unicast_packet {
-	struct batman_header header;
+struct batadv_unicast_packet {
+	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
-struct unicast_frag_packet {
-	struct batman_header header;
+struct batadv_unicast_frag_packet {
+	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
 	uint8_t  dest[ETH_ALEN];
 	uint8_t  flags;
@@ -170,15 +170,15 @@ struct unicast_frag_packet {
 	__be16   seqno;
 } __packed;
 
-struct bcast_packet {
-	struct batman_header header;
+struct batadv_bcast_packet {
+	struct batadv_header header;
 	uint8_t  reserved;
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
 } __packed;
 
-struct vis_packet {
-	struct batman_header header;
+struct batadv_vis_packet {
+	struct batadv_header header;
 	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
 	__be32   seqno;		 /* sequence number */
 	uint8_t  entries;	 /* number of entries behind this struct */
@@ -188,8 +188,8 @@ struct vis_packet {
 	uint8_t  sender_orig[ETH_ALEN]; /* who sent or forwarded this packet */
 } __packed;
 
-struct tt_query_packet {
-	struct batman_header header;
+struct batadv_tt_query_packet {
+	struct batadv_header header;
 	/* the flag field is a combination of:
 	 * - TT_REQUEST or TT_RESPONSE
 	 * - TT_FULL_TABLE
@@ -212,15 +212,15 @@ struct tt_query_packet {
 	__be16 tt_data;
 } __packed;
 
-struct roam_adv_packet {
-	struct batman_header header;
+struct batadv_roam_adv_packet {
+	struct batadv_header header;
 	uint8_t  reserved;
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
 	uint8_t  client[ETH_ALEN];
 } __packed;
 
-struct tt_change {
+struct batadv_tt_change {
 	uint8_t flags;
 	uint8_t addr[ETH_ALEN];
 } __packed;
diff --git a/ping.c b/ping.c
index a4d579f..85b4137 100644
--- a/ping.c
+++ b/ping.c
@@ -67,7 +67,7 @@ void sig_handler(int sig)
 
 int ping(char *mesh_iface, int argc, char **argv)
 {
-	struct icmp_packet_rr icmp_packet_out, icmp_packet_in;
+	struct batadv_icmp_packet_rr icmp_packet_out, icmp_packet_in;
 	struct timeval tv;
 	struct ether_addr *dst_mac = NULL, *rr_mac = NULL;
 	struct bat_host *bat_host, *rr_host;
@@ -160,7 +160,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
-	packet_len = sizeof(struct icmp_packet);
+	packet_len = sizeof(struct batadv_icmp_packet);
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.header.packet_type = BATADV_ICMP;
@@ -170,7 +170,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 	icmp_packet_out.seqno = 0;
 
 	if (rr) {
-		packet_len = sizeof(struct icmp_packet_rr);
+		packet_len = sizeof(struct batadv_icmp_packet_rr);
 		icmp_packet_out.rr_cur = 1;
 		memset(&icmp_packet_out.rr, 0, BATADV_RR_LEN * ETH_ALEN);
 		memset(last_rr, 0, BATADV_RR_LEN * ETH_ALEN);
@@ -241,7 +241,7 @@ read_packet:
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
 					icmp_packet_in.header.ttl, time_delta);
 
-			if (read_len == sizeof(struct icmp_packet_rr)) {
+			if (read_len == sizeof(struct batadv_icmp_packet_rr)) {
 				if (last_rr_cur == icmp_packet_in.rr_cur
 					&& !memcmp(last_rr, icmp_packet_in.rr, BATADV_RR_LEN * ETH_ALEN)) {
 
diff --git a/tcpdump.c b/tcpdump.c
index ba012a7..302085b 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -254,12 +254,12 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 
 static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct tt_query_packet *tt_query_packet;
+	struct batadv_tt_query_packet *tt_query_packet;
 	char *tt_desc, *tt_data, tt_type;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct tt_query_packet), "BAT TT");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_tt_query_packet), "BAT TT");
 
-	tt_query_packet = (struct tt_query_packet *)(packet_buff + sizeof(struct ether_header));
+	tt_query_packet = (struct batadv_tt_query_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		print_time();
@@ -295,11 +295,11 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 
 static void dump_batman_roam(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct roam_adv_packet *roam_adv_packet;
+	struct batadv_roam_adv_packet *roam_adv_packet;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct roam_adv_packet), "BAT ROAM");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_roam_adv_packet), "BAT ROAM");
 
-	roam_adv_packet = (struct roam_adv_packet *)(packet_buff + sizeof(struct ether_header));
+	roam_adv_packet = (struct batadv_roam_adv_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		print_time();
@@ -319,12 +319,12 @@ static void dump_batman_roam(unsigned char *packet_buff, ssize_t buff_len, int r
 static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
-	struct batman_ogm_packet *batman_ogm_packet;
+	struct batadv_ogm_packet *batman_ogm_packet;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batman_ogm_packet), "BAT IV OGM");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_ogm_packet), "BAT IV OGM");
 
 	ether_header = (struct ether_header *)packet_buff;
-	batman_ogm_packet = (struct batman_ogm_packet *)(packet_buff + sizeof(struct ether_header));
+	batman_ogm_packet = (struct batadv_ogm_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		print_time();
@@ -346,12 +346,12 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct icmp_packet *icmp_packet;
+	struct batadv_icmp_packet *icmp_packet;
 	char *name;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct icmp_packet), "BAT ICMP");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_icmp_packet), "BAT ICMP");
 
-	icmp_packet = (struct icmp_packet *)(packet_buff + sizeof(struct ether_header));
+	icmp_packet = (struct batadv_icmp_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		print_time();
@@ -389,14 +389,14 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
-	struct unicast_packet *unicast_packet;
+	struct batadv_unicast_packet *unicast_packet;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct unicast_packet), "BAT UCAST");
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct unicast_packet),
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_unicast_packet), "BAT UCAST");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct batadv_unicast_packet),
 		sizeof(struct ether_header), "BAT UCAST (unpacked)");
 
 	ether_header = (struct ether_header *)packet_buff;
-	unicast_packet = (struct unicast_packet *)(packet_buff + sizeof(struct ether_header));
+	unicast_packet = (struct batadv_unicast_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		time_printed = print_time();
@@ -408,22 +408,22 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 	       get_name_by_macaddr((struct ether_addr *)unicast_packet->dest, read_opt),
 	       unicast_packet->ttvn, unicast_packet->header.ttl);
 
-	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_packet),
-		      buff_len - ETH_HLEN - sizeof(struct unicast_packet),
+	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_unicast_packet),
+		      buff_len - ETH_HLEN - sizeof(struct batadv_unicast_packet),
 		      read_opt, time_printed);
 }
 
 static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
-	struct bcast_packet *bcast_packet;
+	struct batadv_bcast_packet *bcast_packet;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct bcast_packet), "BAT BCAST");
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct bcast_packet),
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_bcast_packet), "BAT BCAST");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct batadv_bcast_packet),
 	          sizeof(struct ether_header), "BAT BCAST (unpacked)");
 
 	ether_header = (struct ether_header *)packet_buff;
-	bcast_packet = (struct bcast_packet *)(packet_buff + sizeof(struct ether_header));
+	bcast_packet = (struct batadv_bcast_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		time_printed = print_time();
@@ -435,19 +435,19 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 	       get_name_by_macaddr((struct ether_addr *)bcast_packet->orig, read_opt),
 	       ntohl(bcast_packet->seqno));
 
-	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct bcast_packet),
-		      buff_len - ETH_HLEN - sizeof(struct bcast_packet),
+	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_bcast_packet),
+		      buff_len - ETH_HLEN - sizeof(struct batadv_bcast_packet),
 		      read_opt, time_printed);
 }
 
 static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct unicast_frag_packet *unicast_frag_packet;
+	struct batadv_unicast_frag_packet *unicast_frag_packet;
 
-	LEN_CHECK((size_t)buff_len - ETH_HLEN, sizeof(struct unicast_frag_packet), "BAT FRAG");
-	LEN_CHECK((size_t)buff_len - ETH_HLEN - sizeof(struct unicast_frag_packet), (size_t)ETH_HLEN, "BAT FRAG (unpacked)");
+	LEN_CHECK((size_t)buff_len - ETH_HLEN, sizeof(struct batadv_unicast_frag_packet), "BAT FRAG");
+	LEN_CHECK((size_t)buff_len - ETH_HLEN - sizeof(struct batadv_unicast_frag_packet), (size_t)ETH_HLEN, "BAT FRAG (unpacked)");
 
-	unicast_frag_packet = (struct unicast_frag_packet *)(packet_buff + ETH_HLEN);
+	unicast_frag_packet = (struct batadv_unicast_frag_packet *)(packet_buff + ETH_HLEN);
 
 	if (!time_printed)
 		time_printed = print_time();
@@ -462,16 +462,16 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 	       (unicast_frag_packet->flags & BATADV_UNI_FRAG_LARGETAIL ? 'L' : '.'));
 
 	if (unicast_frag_packet->flags & BATADV_UNI_FRAG_HEAD)
-		parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_frag_packet),
-			      buff_len - ETH_HLEN - sizeof(struct unicast_frag_packet),
+		parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_unicast_frag_packet),
+			      buff_len - ETH_HLEN - sizeof(struct batadv_unicast_frag_packet),
 			      read_opt, time_printed);
 	else
-		printf("length %zu\n", (size_t)buff_len - ETH_HLEN - sizeof(struct unicast_frag_packet));
+		printf("length %zu\n", (size_t)buff_len - ETH_HLEN - sizeof(struct batadv_unicast_frag_packet));
 }
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct batman_ogm_packet *batman_ogm_packet;
+	struct batadv_ogm_packet *batman_ogm_packet;
 	struct ether_header *eth_hdr;
 
 	eth_hdr = (struct ether_header *)packet_buff;
@@ -490,7 +490,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
 		break;
 	case BATADV_ETH_P_BATMAN:
-		batman_ogm_packet = (struct batman_ogm_packet *)(packet_buff + ETH_HLEN);
+		batman_ogm_packet = (struct batadv_ogm_packet *)(packet_buff + ETH_HLEN);
 
 		if ((read_opt & COMPAT_FILTER) &&
 		    (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION))
diff --git a/traceroute.c b/traceroute.c
index 9ef70e8..31f77b0 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -51,7 +51,7 @@ void traceroute_usage(void)
 
 int traceroute(char *mesh_iface, int argc, char **argv)
 {
-	struct icmp_packet icmp_packet_out, icmp_packet_in;
+	struct batadv_icmp_packet icmp_packet_out, icmp_packet_in;
 	struct bat_host *bat_host;
 	struct ether_addr *dst_mac = NULL;
 	struct timeval tv;
-- 
1.7.10

