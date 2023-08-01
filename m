Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E4EC001DF
	for <batman-adv@archiver.kernel.org>; Tue,  1 Aug 2023 02:16:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 27EC081ACC
	for <batman-adv@archiver.kernel.org>; Tue,  1 Aug 2023 04:16:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690856184;
 b=YpvhPSweOvVvVCkYDKRk7BewUh1aGTDj1fjxvE1Q6bFqjhPab3Q9LbuNxD+NdELBfjif/
 TJy5nDOS7PrDKc5jFjYNNu16H0VnKLVlurZa1fXM0gZ3b6WUx5s55DE9jgh5bKwVBzcnF8v
 nIvsVxfLD54xsFUCGCe1KLePdQso+W8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690856184; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bvTZJ9LMWzmJ4GhcFuuUa3Y/pnvdJtowu0JQA8DVDPo=;
 b=M6w2ocJQMIhThJsofnjo/Vwc/W3oTxBik8DBVq/uW1DmIeALdQLKhWqZWOePyyZYAHgOA
 3sigaJ5q+FnHEitvYMztfSQvXcITUOJnd8lzTNSwPfnEIO+hmtntgkVfdSVAySg9U7o0NJF
 h3hu2lK8ey61KOM1Ms6he8kyp6kHhTM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A12FF806FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  1 Aug 2023 04:15:48 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690856149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvTZJ9LMWzmJ4GhcFuuUa3Y/pnvdJtowu0JQA8DVDPo=;
	b=hQ3PWL3jwtgQJb9TLjPoKCwR+hMehLAmv/6FpXBuLzqYQ1WxVyqWVrGPbDsdH5A/x9ORfe
	UUBbZb0+t7c2VEvr6Dvz+JnrooP8fhDYCYTuvJYx/7mbfYOzEgCyYAMQDe8YNRr02wwJ8c
	EZCs6D0vhHULcL9XWkdL9IqyNamJRvc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 2a01:4f8:c2c:665b::1)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690856149; a=rsa-sha256;
	cv=none;
	b=qLz6A4YtsTSgUz1eQ/2WgKAn7f55uzS3YoDaamhGTqj26K9rYPxy2BgMj35vYAnq+0RVOw
	ylFQUzcB7LARpyLzl3RstY3woSG7ta22z3KisWYniBobVda3wukCyuubO1eu82JsCVW7iP
	qErbf68aGsjGU8SM+1/m1Flv7pTL/Fc=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F6B949B57;
	Tue,  1 Aug 2023 04:15:48 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH 2/2] batctl: tcpdump: parse batman-adv mcast packet type
Date: Tue,  1 Aug 2023 04:15:37 +0200
Message-Id: <20230801021537.22036-2-linus.luessing@c0d3.blue>
In-Reply-To: <20230801021537.22036-1-linus.luessing@c0d3.blue>
References: <20230801021537.22036-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: OQ3JHXTODOHBV25B4FQEVMOJBUJ3CIGE
X-Message-ID-Hash: OQ3JHXTODOHBV25B4FQEVMOJBUJ3CIGE
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OQ3JHXTODOHBV25B4FQEVMOJBUJ3CIGE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Implement a batctl tcpdump parsing of the new batman-adv multicast
packet type, including its multicast tracker TVLV and encapsulated
payload data.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 tcpdump.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++-------
 tcpdump.h |   1 +
 2 files changed, 119 insertions(+), 16 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index debcb0ae517a..5e7c76c69bd1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -57,7 +57,8 @@ static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATOGM2 |
 				       DUMP_TYPE_BATELP | DUMP_TYPE_BATICMP |
 				       DUMP_TYPE_BATUCAST | DUMP_TYPE_BATBCAST |
 				       DUMP_TYPE_BATUTVLV | DUMP_TYPE_BATFRAG |
-				       DUMP_TYPE_NONBAT | DUMP_TYPE_BATCODED;
+				       DUMP_TYPE_NONBAT | DUMP_TYPE_BATCODED |
+				       DUMP_TYPE_BATMCAST;
 static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
@@ -82,6 +83,7 @@ static void tcpdump_usage(void)
 	fprintf(stderr, " \t\t%3d - batman unicast tvlv packets\n", DUMP_TYPE_BATUTVLV);
 	fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
 	fprintf(stderr, " \t\t%3d - batman coded packets\n", DUMP_TYPE_BATCODED);
+	fprintf(stderr, " \t\t%3d - batman multicast packets\n", DUMP_TYPE_BATMCAST);
 	fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
@@ -101,7 +103,8 @@ static int print_time(void)
 	return 1;
 }
 
-static void batctl_tvlv_parse_gw_v1(void *buff, ssize_t buff_len)
+static void batctl_tvlv_parse_gw_v1(void *buff, ssize_t buff_len,
+				    int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_gateway_data *tvlv = buff;
 	uint32_t down, up;
@@ -119,8 +122,9 @@ static void batctl_tvlv_parse_gw_v1(void *buff, ssize_t buff_len)
 	       down / 10, down % 10, up / 10, up % 10);
 }
 
-static void batctl_tvlv_parse_dat_v1(void (*buff)__attribute__((unused)),
-				     ssize_t buff_len)
+static void batctl_tvlv_parse_dat_v1(void *buff __maybe_unused,
+				     ssize_t buff_len,
+				     int read_opt __maybe_unused)
 {
 	if (buff_len != 0) {
 		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (0): %zu\n",
@@ -131,8 +135,9 @@ static void batctl_tvlv_parse_dat_v1(void (*buff)__attribute__((unused)),
 	printf("\tTVLV DATv1: enabled\n");
 }
 
-static void batctl_tvlv_parse_nc_v1(void (*buff)__attribute__((unused)),
-				    ssize_t buff_len)
+static void batctl_tvlv_parse_nc_v1(void *buff __maybe_unused,
+				    ssize_t buff_len,
+				    int read_opt __maybe_unused)
 {
 	if (buff_len != 0) {
 		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (0): %zu\n",
@@ -143,7 +148,8 @@ static void batctl_tvlv_parse_nc_v1(void (*buff)__attribute__((unused)),
 	printf("\tTVLV NCv1: enabled\n");
 }
 
-static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len)
+static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len,
+				    int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_tt_data *tvlv = buff;
 	struct batadv_tvlv_tt_vlan_data *vlan;
@@ -183,7 +189,8 @@ static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len)
 	}
 }
 
-static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len)
+static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len,
+				      int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_roam_adv *tvlv = buff;
 
@@ -199,7 +206,8 @@ static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len)
 }
 
 static void batctl_tvlv_parse_mcast_v1(void *buff __maybe_unused,
-				       ssize_t buff_len)
+				       ssize_t buff_len,
+				       int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_mcast_data *tvlv = buff;
 	uint8_t flags;
@@ -218,7 +226,8 @@ static void batctl_tvlv_parse_mcast_v1(void *buff __maybe_unused,
 	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
 }
 
-static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len)
+static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len,
+				       int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_mcast_data *tvlv = buff;
 	uint8_t flags;
@@ -240,7 +249,37 @@ static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len)
 	       !(flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 }
 
-typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
+static void
+batctl_tvlv_parse_mcast_tracker_v1(void *buff, ssize_t buff_len, int read_opt)
+{
+	struct batadv_tvlv_mcast_tracker *tvlv = buff;
+	size_t tvlv_len = sizeof(*tvlv);
+	struct ether_addr *dst;
+	uint16_t num_dests;
+
+	if (buff_len < (ssize_t)tvlv_len) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV MCAST TRACKER v1", tvlv_len, buff_len);
+		return;
+	}
+
+	num_dests = ntohs(tvlv->num_dests);
+	tvlv_len += num_dests * ETH_ALEN;
+	dst = (struct ether_addr *)(tvlv + 1);
+
+	if (buff_len < (ssize_t)tvlv_len) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV MCAST TRACKER v1 (with destinations)", tvlv_len, buff_len);
+		return;
+	}
+
+	printf("\tTVLV MCAST TRACKER v1, destinations (%hu):\n", num_dests);
+
+	for (int i = 0; i < num_dests; i++)
+		printf("\t\t%s\n", get_name_by_macaddr(dst++, read_opt));
+}
+
+typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len, int read_opt);
 
 static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
 {
@@ -295,12 +334,20 @@ static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
 			return NULL;
 		}
 
+	case BATADV_TVLV_MCAST_TRACKER:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_mcast_tracker_v1;
+		default:
+			return NULL;
+		}
+
 	default:
 		return NULL;
 	}
 }
 
-static void dump_tvlv(unsigned char *ptr, ssize_t tvlv_len)
+static void dump_tvlv(unsigned char *ptr, ssize_t tvlv_len, int read_opt)
 {
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	batctl_tvlv_parser_t parser;
@@ -318,7 +365,7 @@ static void dump_tvlv(unsigned char *ptr, ssize_t tvlv_len)
 
 		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
 		if (parser)
-			parser(ptr, len);
+			parser(ptr, len, read_opt);
 
 		/* go to the next container */
 		ptr += len;
@@ -358,7 +405,7 @@ static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 	       buff_len - sizeof(struct ether_header), tvlv_len,
 	       tvlv_packet->ttl);
 
-	dump_tvlv((uint8_t *)(tvlv_packet + 1), tvlv_len);
+	dump_tvlv((uint8_t *)(tvlv_packet + 1), tvlv_len, read_opt);
 }
 
 static int dump_bla2_claim(struct ether_header *eth_hdr,
@@ -779,7 +826,7 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 	check_len -= sizeof(struct batadv_ogm_packet);
 	LEN_CHECK(check_len, (size_t)tvlv_len, "BAT OGM TVLV (containers)");
 
-	dump_tvlv((uint8_t *)(batman_ogm_packet + 1), tvlv_len);
+	dump_tvlv((uint8_t *)(batman_ogm_packet + 1), tvlv_len, read_opt);
 }
 
 static void dump_batman_ogm2(unsigned char *packet_buff, ssize_t buff_len,
@@ -823,7 +870,7 @@ static void dump_batman_ogm2(unsigned char *packet_buff, ssize_t buff_len,
 	check_len -= BATADV_OGM2_HLEN;
 	LEN_CHECK(check_len, (size_t)tvlv_len, "BAT OGM2 TVLV (containers)");
 
-	dump_tvlv((uint8_t *)(batman_ogm2 + 1), tvlv_len);
+	dump_tvlv((uint8_t *)(batman_ogm2 + 1), tvlv_len, read_opt);
 }
 
 static void dump_batman_elp(unsigned char *packet_buff, ssize_t buff_len,
@@ -988,6 +1035,57 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 		      read_opt, time_printed);
 }
 
+static void dump_batman_mcast(unsigned char *packet_buff, ssize_t buff_len,
+			      int read_opt, int time_printed)
+{
+	struct batadv_mcast_packet *mcast_packet;
+	struct ether_header *ether_header;
+	uint8_t *tvlv_hdr;
+	ssize_t check_len;
+	size_t tvlv_len;
+
+	check_len = (size_t)buff_len - sizeof(struct ether_header);
+
+	LEN_CHECK(check_len, sizeof(*mcast_packet), "BAT MCAST");
+	check_len -= sizeof(*mcast_packet);
+
+	ether_header = (struct ether_header *)packet_buff;
+	mcast_packet = (struct batadv_mcast_packet *)(ether_header + 1);
+	tvlv_len = ntohs(mcast_packet->tvlv_len);
+
+	LEN_CHECK(check_len, tvlv_len, "BAT MCAST TVLV (containers)");
+	check_len -= tvlv_len;
+
+	tvlv_hdr = (uint8_t *)(mcast_packet + 1);
+
+	if (!time_printed)
+		time_printed = print_time();
+
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
+
+	printf("%s: MCAST, ttl %hhu, ",
+	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_dhost, read_opt),
+	       mcast_packet->ttl);
+
+	/* batman-adv mcast packet's data payload is optional */
+	if (check_len >= ETH_HLEN) {
+		ether_header = (struct ether_header *)(tvlv_hdr + tvlv_len);
+
+		printf("%s > ",
+		       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
+		printf("%s, ",
+		       get_name_by_macaddr((struct ether_addr *)ether_header->ether_dhost, read_opt));
+
+		parse_eth_hdr((unsigned char *)ether_header, check_len,
+			      read_opt, time_printed);
+	} else {
+		printf("\n");
+	}
+
+	dump_tvlv(tvlv_hdr, tvlv_len, read_opt);
+}
+
 static void dump_batman_coded(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct batadv_coded_packet *coded_packet;
@@ -1106,6 +1204,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			if (dump_level & DUMP_TYPE_BATBCAST)
 				dump_batman_bcast(packet_buff, buff_len, read_opt, time_printed);
 			break;
+		case BATADV_MCAST:
+			if (dump_level & DUMP_TYPE_BATMCAST)
+				dump_batman_mcast(packet_buff, buff_len, read_opt, time_printed);
+			break;
 		case BATADV_CODED:
 			if (dump_level & DUMP_TYPE_BATCODED)
 				dump_batman_coded(packet_buff, buff_len, read_opt, time_printed);
diff --git a/tcpdump.h b/tcpdump.h
index 527fb7f0891d..be64aeb810c6 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -34,6 +34,7 @@
 #define DUMP_TYPE_BATFRAG 128
 #define DUMP_TYPE_NONBAT 256
 #define DUMP_TYPE_BATCODED 512
+#define DUMP_TYPE_BATMCAST 1024
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
 #define IEEE80211_FCTL_TODS 0x0001
-- 
2.40.1

