Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:55 +0200
Message-Id: <1288450858-14753-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batctl: Remove unused variables
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

Different variables aren't used after they are set. We can discard them
without changing the behavior visible to the outside.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/functions.c |    3 +--
 batctl/tcpdump.c   |   32 ++++++++------------------------
 batctl/vis.c       |    3 +--
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/batctl/functions.c b/batctl/functions.c
index cff8b52..ce046ba 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -126,7 +126,6 @@ int read_file(char *dir, char *fname, int read_opt,
 	float last_seen;
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
-	ssize_t read;
 	FILE *fp = NULL;
 
 	if (read_opt & USE_BAT_HOSTS)
@@ -154,7 +153,7 @@ open:
 		system("clear");
 
 read:
-	while ((read = getline(&line_ptr, &len, fp)) != -1) {
+	while (getline(&line_ptr, &len, fp) != -1) {
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
 			break;
diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 8898cf8..ed11f22 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -84,15 +84,12 @@ static int print_time(void)
 	return 1;
 }
 
-static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int time_printed)
+static void dump_arp(unsigned char *packet_buff, ssize_t buff_len)
 {
 	struct ether_arp *arphdr;
 
 	LEN_CHECK((size_t)buff_len, sizeof(struct ether_arp), "ARP");
 
-	if (!time_printed)
-		time_printed = print_time();
-
 	arphdr = (struct ether_arp *)packet_buff;
 
 	switch (ntohs(arphdr->arp_op)) {
@@ -111,7 +108,7 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int time_prin
 	}
 }
 
-static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_printed)
+static void dump_ip(unsigned char *packet_buff, ssize_t buff_len)
 {
 	struct iphdr *iphdr, *tmp_iphdr;
 	struct tcphdr *tcphdr;
@@ -121,9 +118,6 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 	iphdr = (struct iphdr *)packet_buff;
 	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), "IP");
 
-	if (!time_printed)
-		time_printed = print_time();
-
 	switch (iphdr->protocol) {
 	case IPPROTO_ICMP:
 		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct icmphdr), "ICMP");
@@ -246,7 +240,7 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 	parse_eth_hdr(packet_buff + 4, buff_len - 4, read_opt, time_printed);
 }
 
-static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int read_opt)
 {
 	struct ether_header *ether_header;
 	struct batman_packet *batman_packet;
@@ -256,9 +250,6 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	ether_header = (struct ether_header *)packet_buff;
 	batman_packet = (struct batman_packet *)(packet_buff + sizeof(struct ether_header));
 
-	if (!time_printed)
-		time_printed = print_time();
-
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_packet->orig, read_opt));
 
@@ -273,20 +264,15 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	        (size_t)buff_len - sizeof(struct ether_header));
 }
 
-static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt)
 {
-	struct ether_header *ether_header;
 	struct icmp_packet *icmp_packet;
 	char *name;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct icmp_packet), "BAT ICMP");
 
-	ether_header = (struct ether_header *)packet_buff;
 	icmp_packet = (struct icmp_packet *)(packet_buff + sizeof(struct ether_header));
 
-	if (!time_printed)
-		time_printed = print_time();
-
 	printf("BAT %s > ", get_name_by_macaddr((struct ether_addr *)icmp_packet->orig, read_opt));
 
 	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst, read_opt);
@@ -373,13 +359,11 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 
 static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct ether_header *ether_header;
 	struct unicast_frag_packet *unicast_frag_packet;
 
 	LEN_CHECK((size_t)buff_len - ETH_HLEN, sizeof(struct unicast_frag_packet), "BAT FRAG");
 	LEN_CHECK((size_t)buff_len - ETH_HLEN - sizeof(struct unicast_frag_packet), (size_t)ETH_HLEN, "BAT FRAG (unpacked)");
 
-	ether_header = (struct ether_header *)packet_buff;
 	unicast_frag_packet = (struct unicast_frag_packet *)(packet_buff + ETH_HLEN);
 
 	if (!time_printed)
@@ -411,11 +395,11 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	switch (ntohs(eth_hdr->ether_type)) {
 	case ETH_P_ARP:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
-			dump_arp(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
+			dump_arp(packet_buff + ETH_HLEN, buff_len - ETH_HLEN);
 		break;
 	case ETH_P_IP:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
-			dump_ip(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
+			dump_ip(packet_buff + ETH_HLEN, buff_len - ETH_HLEN);
 		break;
 	case ETH_P_8021Q:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
@@ -427,11 +411,11 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		switch (batman_packet->packet_type) {
 		case BAT_PACKET:
 			if (dump_level & DUMP_TYPE_BATOGM)
-				dump_batman_ogm(packet_buff, buff_len, read_opt, time_printed);
+				dump_batman_ogm(packet_buff, buff_len, read_opt);
 			break;
 		case BAT_ICMP:
 			if (dump_level & DUMP_TYPE_BATICMP)
-				dump_batman_icmp(packet_buff, buff_len, read_opt, time_printed);
+				dump_batman_icmp(packet_buff, buff_len, read_opt);
 			break;
 		case BAT_UNICAST:
 			if (dump_level & DUMP_TYPE_BATUCAST)
diff --git a/batctl/vis.c b/batctl/vis.c
index ad612ff..4bc5954 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -183,7 +183,6 @@ static FILE *open_vis(char *mesh_iface)
 static int format(char *mesh_iface, const struct funcs *funcs)
 {
 	size_t len = 0;
-	ssize_t read;
 	char *line = NULL;
 	char *orig, *from;
 	char *duplet;
@@ -202,7 +201,7 @@ static int format(char *mesh_iface, const struct funcs *funcs)
 	if (funcs->print_header)
 		funcs->print_header();
 
-	while ((read = getline(&line, &len, fp)) != -1) {
+	while (getline(&line, &len, fp) != -1) {
 		/* First MAC address is the originator */
 		orig = strtok_r(line, ",", &line_save_ptr);
 
-- 
1.7.2.3

