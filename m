Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E1CD8CA4
	for <batman-adv@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D079C83F86
	for <batman-adv@archiver.kernel.org>; Mon, 08 Jun 2026 21:00:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780945258;
 b=I+X/QBEvF6fCo0kWnxszct2XfQUKTpc35/YNn/AKgD6EFvTyliVipwMfjbv6uPfFbq8Xk
 P7GAn/eBtlTxTuj9UVMaNr7w0PsE/ygpxBgosn3IgeR6PucMlZjKjzINyESP+rlfScADIhT
 SS8Qs++WadgkEmVv1J9G37Og4ptPzF4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780945258; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CsboIp49WG3MEO78r/OaBKfetcHlnwcWowzadBSLNhA=;
 b=dZNPGAU3oUrIgzj3b4+dPvBWxLLviabEjZgyR4ItfYwm2JwGZw0urNnbJhUq2ttVXrHfD
 CIQO25qEC3iLR6bAXzGXvW0aCmit2n4MJrkQt5BP2x9s7p7SfliOo44sG2ZvQXJFZAZQh4v
 S2m9OBDSCdCdYbwFemg2NJeH/k5Ib6A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A28B3804D3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 08 Jun 2026 21:00:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780945248;
	b=qmMlfxHYPU4oaJVDh9rzPtO2vn8pItGB38J9wG7RWNHOv7cCBTQQJ6ID+Zu+UMcthvVQ3H
	CbvnZpdfpF/9VISOQOCApdcNhrlhV+OhYzOm9V6KfO5Fs6jORC5bZhW000eUqpA8ZCntbJ
	XxXz/vnZQa5+rkZYpjyz6SJY7hoSuAs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fB9GCn2m;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780945248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CsboIp49WG3MEO78r/OaBKfetcHlnwcWowzadBSLNhA=;
	b=jemw4TGtxllSyD7emlckh4XhytW3jY8M3d8V184F0PbfXa+rKKtvFjgxKNTC5SFGePQKim
	O98cyZZU6Y/RxIuRZ05+H3ksVa+l6Wt2w4JAeMYjA4KOJRqLpQQr/l7HSVH2kmngV+YFVn
	OK3OL53ZzQxV4vaDULq5WCqfdqeCxBs=
Received: by dvalin.narfation.org (Postfix) id B46511FF8D;
	Mon, 08 Jun 2026 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780945237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CsboIp49WG3MEO78r/OaBKfetcHlnwcWowzadBSLNhA=;
	b=fB9GCn2mLrljNTDcvtMX/eTET2XF2DVhdQIFm+nRxuL9sbhlWXyPdDft79HNWKnDfUdeTb
	bPTNTMU9xK4n06fKNAk+pgW/Z2HrR5a0QdJW4DVXKzn01uArN9oan1EjJFW7WhGSuNQfU1
	d9WGVIOAZoy4Jr6HO/4sf8pSdCCGHbM=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 08 Jun 2026 21:00:30 +0200
Subject: [PATCH] alfred: use reverse xmas tree declaration order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-reverse-xmas-v1-1-4598617e49f9@narfation.org>
X-B4-Tracking: v=1; b=H4sIAE4RJ2oC/yXMywqAIBCF4VeJWSeYhUWvEi3UppqgC05FIL17V
 ssPzvkDMHpChjoJ4PEkpnWJyNIE3GiWAQV10aCk0lLLSsQRekZxzYZFkbm+tMpIlVcQL5vHnq4
 v17S/+bATuv1twH0/1W1ngHAAAAA=
X-Change-ID: 20260608-reverse-xmas-41cf7b2a0238
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=33664; i=sven@narfation.org;
 h=from:subject:message-id; bh=NwJWVmuvbvWZ5q5ZbTsXRDWSc1Ux5ahlLm6vf+ztNXI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnqgoGxvbptzT7pmx49C32kHmCSVHKNv0DIMuGFzq2fS
 gc1uT50lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACZy7REjw42/hx3C5u39uo1B
 8taHa+/0viyw/fR9e/9N11g3lTCprLmMDMdrCtbfLnLzF9Ev37lb4MfuSze/SJ3iiKps7citlXH
 /zQ8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EATUG3RXDK3TZCRAVSFKYYBWM4UIEMWQ
X-Message-ID-Hash: EATUG3RXDK3TZCRAVSFKYYBWM4UIEMWQ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EATUG3RXDK3TZCRAVSFKYYBWM4UIEMWQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the kernel, network related code is supposed (according to the
"Networking subsystem (netdev)" documentation) to use the "reverse xmas
tree" style of variable declarations. To keep it consistent between the
userspace and kernelspace code, also use the same for userspace.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c     | 10 ++++++----
 batadv_querynl.c   |  6 +++---
 bitops.h           | 12 ++++++------
 client.c           | 41 ++++++++++++++++++++++++++++-------------
 gpsd/alfred-gpsd.c | 38 ++++++++++++++++++++++----------------
 hash.c             | 12 +++++++-----
 list.h             |  4 ++--
 main.c             | 15 +++++++++------
 netsock.c          | 31 +++++++++++++++++++------------
 recv.c             | 33 +++++++++++++++++++--------------
 send.c             | 20 ++++++++++----------
 server.c           | 27 +++++++++++++++------------
 unix_sock.c        | 43 +++++++++++++++++++++++++++----------------
 util.c             |  9 +++++----
 vis/vis.c          | 45 ++++++++++++++++++++++++++-------------------
 15 files changed, 204 insertions(+), 142 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index d1853b7..d59db34 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -28,9 +28,9 @@ static int enable_net_admin_capability(int enable)
 	int ret = 0;
 
 #ifdef CONFIG_ALFRED_CAPABILITIES
-	cap_t cap_cur;
-	cap_flag_value_t cap_flag;
 	cap_value_t cap_net_admin = CAP_NET_ADMIN;
+	cap_flag_value_t cap_flag;
+	cap_t cap_cur;
 
 	if (enable)
 		cap_flag = CAP_SET;
@@ -143,7 +143,8 @@ int batadv_interface_check(const char *mesh_iface)
 
 static int tg_compare(void *d1, void *d2)
 {
-	struct tg_entry *s1 = d1, *s2 = d2;
+	struct tg_entry *s1 = d1;
+	struct tg_entry *s2 = d2;
 
 	if (memcmp(&s1->mac, &s2->mac, sizeof(s1->mac)) == 0)
 		return 1;
@@ -227,7 +228,8 @@ struct ether_addr *translate_mac(struct hashtable_t *tg_hash,
 
 static int orig_compare(void *d1, void *d2)
 {
-	struct orig_entry *s1 = d1, *s2 = d2;
+	struct orig_entry *s1 = d1;
+	struct orig_entry *s2 = d2;
 
 	if (memcmp(&s1->mac, &s2->mac, sizeof(s1->mac)) == 0)
 		return 1;
diff --git a/batadv_querynl.c b/batadv_querynl.c
index abb500b..199fe9d 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -39,12 +39,12 @@ struct translate_mac_netlink_opts {
 static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct translate_mac_netlink_opts *opts;
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlquery_opts *query_opts = arg;
-	struct translate_mac_netlink_opts *opts;
-	struct genlmsghdr *ghdr;
 	struct ether_addr mac_addr;
 	struct ether_addr mac_orig;
+	struct genlmsghdr *ghdr;
 	uint8_t *addr;
 	uint8_t *orig;
 
@@ -118,8 +118,8 @@ static int get_tq_netlink_cb(struct nl_msg *msg, void *arg)
 	struct nlquery_opts *query_opts = arg;
 	struct get_tq_netlink_opts *opts;
 	struct genlmsghdr *ghdr;
-	uint8_t *orig;
 	struct ether_addr mac;
+	uint8_t *orig;
 	uint8_t tq;
 
 	opts = container_of(query_opts, struct get_tq_netlink_opts,
diff --git a/bitops.h b/bitops.h
index 582a1f2..bc87c24 100644
--- a/bitops.h
+++ b/bitops.h
@@ -260,12 +260,12 @@ static __inline__ void set_bit(size_t bit, unsigned long *bitmap)
 static __inline__ size_t find_next_bit(unsigned long *bitmap, size_t bits,
 				       size_t start)
 {
-	size_t i;
-	size_t pos;
-	unsigned long t;
-	size_t l = BITS_TO_LONGS(bits);
-	size_t first_long = start / BITS_PER_LONG;
 	size_t long_lower = start - (start % BITS_PER_LONG);
+	size_t first_long = start / BITS_PER_LONG;
+	size_t l = BITS_TO_LONGS(bits);
+	unsigned long t;
+	size_t pos;
+	size_t i;
 
 	if (start >= bits)
 		return bits;
@@ -325,8 +325,8 @@ static __inline__ size_t find_next_bit(unsigned long *bitmap, size_t bits,
 static __inline__ size_t bitmap_weight(const unsigned long *bitmap, size_t bits)
 {
 	size_t l = BITS_TO_LONGS(bits);
-	size_t i;
 	size_t sum = 0;
+	size_t i;
 
 	for (i = 0; i < l - 1; i++)
 		sum += hweight_long(bitmap[i]);
diff --git a/client.c b/client.c
index 2676e32..9fa9f00 100644
--- a/client.c
+++ b/client.c
@@ -22,14 +22,18 @@
 
 int alfred_client_request_data(struct globals *globals)
 {
-	unsigned char buf[MAX_PAYLOAD], *pos;
 	struct alfred_request_v0 request;
 	struct alfred_push_data_v0 *push;
 	struct alfred_status_v0 *status;
-	struct alfred_tlv *tlv;
+	unsigned char buf[MAX_PAYLOAD];
 	struct alfred_data *data;
-	int ret, len, data_len, i;
 	const size_t buf_data_len = sizeof(buf) - sizeof(*push) - sizeof(*data);
+	struct alfred_tlv *tlv;
+	unsigned char *pos;
+	int data_len;
+	int ret;
+	int len;
+	int i;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -135,10 +139,11 @@ int alfred_client_request_data(struct globals *globals)
 
 int alfred_client_set_data(struct globals *globals)
 {
-	unsigned char buf[MAX_PAYLOAD];
 	struct alfred_push_data_v0 *push;
+	unsigned char buf[MAX_PAYLOAD];
 	struct alfred_data *data;
-	int ret, len;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -178,7 +183,8 @@ int alfred_client_set_data(struct globals *globals)
 int alfred_client_modeswitch(struct globals *globals)
 {
 	struct alfred_modeswitch_v0 modeswitch;
-	int ret, len;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -213,8 +219,8 @@ int alfred_client_modeswitch(struct globals *globals)
 
 static int check_interface(const char *iface)
 {
-	int sock = -1;
 	struct ifreq ifr;
+	int sock = -1;
 
 	if (strlen(iface) > IFNAMSIZ) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
@@ -245,9 +251,12 @@ static int check_interface(const char *iface)
 int alfred_client_change_interface(struct globals *globals)
 {
 	struct alfred_change_interface_v0 change_interface;
-	int ret, len;
-	char *input, *token, *saveptr;
 	size_t interface_len;
+	char *saveptr;
+	char *input;
+	char *token;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -294,8 +303,9 @@ int alfred_client_change_interface(struct globals *globals)
 int alfred_client_change_bat_iface(struct globals *globals)
 {
 	struct alfred_change_bat_iface_v0 change_bat_iface;
-	int ret, len;
 	size_t interface_len;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -331,11 +341,15 @@ int alfred_client_server_status(struct globals *globals)
 	struct alfred_server_status_net_iface_v0 *status_net_iface;
 	struct alfred_server_status_bat_iface_v0 *status_bat_iface;
 	struct alfred_server_status_op_mode_v0 *status_op_mode;
-	struct alfred_server_status_req_v0 status_req;
 	struct alfred_server_status_rep_v0 *status_rep;
-	int ret, tlvsize, headsize, len, consumed;
+	struct alfred_server_status_req_v0 status_req;
 	struct alfred_tlv *status_tlv;
 	uint8_t buf[MAX_PAYLOAD];
+	int headsize;
+	int consumed;
+	int tlvsize;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
@@ -457,7 +471,8 @@ int alfred_client_event_monitor(struct globals *globals)
 {
 	struct alfred_event_register_v0 event_register;
 	struct alfred_event_notify_v0 event_notify;
-	int ret, len;
+	int ret;
+	int len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index fd87e0b..04f7a46 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -40,7 +40,8 @@ static int alfred_open_sock(struct globals *globals)
 
 static int gpsd_publish_data(struct globals *globals)
 {
-	int len, ret;
+	int len;
+	int ret;
 
 	/* to push data we have to add a push header, the header for the data
 	 * and our own data type.
@@ -135,11 +136,12 @@ static int gpsd_request_data(struct globals *globals)
 static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 						  uint8_t *source)
 {
-	static uint8_t buf[65536];
-	struct alfred_tlv *tlv;
 	struct alfred_push_data_v0 *push;
+	static uint8_t buf[65536];
 	struct alfred_data *data;
-	int l, ret;
+	struct alfred_tlv *tlv;
+	int ret;
+	int l;
 
 	ret = read(sock, buf, sizeof(*tlv));
 	if (ret < 0)
@@ -184,9 +186,9 @@ static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 static int gpsd_read_answer(struct globals *globals)
 {
 	struct gpsd_v1 *gpsd_data;
-	uint16_t len;
 	uint8_t source[ETH_ALEN];
 	bool first_line = true;
+	uint16_t len;
 
 	printf("[\n");
 
@@ -301,14 +303,14 @@ static void gpsd_connect_gpsd(struct globals *globals)
 
 static void gpsd_read_gpsd(struct globals *globals)
 {
-	ssize_t ret;
-	size_t cnt;
-	bool eol = false;
-	char buf[4096];
 	const size_t tpv_size = sizeof(globals->buf) -
 				sizeof(*globals->push) -
 				sizeof(struct alfred_data) -
 				sizeof(*globals->gpsd_data);
+	bool eol = false;
+	char buf[4096];
+	ssize_t ret;
+	size_t cnt;
 
 	cnt = 0;
 	do {
@@ -360,8 +362,10 @@ static void gpsd_usage(void)
 static void gpsd_parse_location(struct globals *globals,
 				const char * optarg)
 {
+	float lat;
+	float lon;
+	float alt;
 	int n;
-	float lat, lon, alt;
 
 	n = sscanf(optarg, "%f,%f,%f", &lat, &lon, &alt);
 	if (n != 3) {
@@ -396,9 +400,6 @@ static void gpsd_parse_location(struct globals *globals,
 
 static struct globals *gpsd_init(int argc, char *argv[])
 {
-	bool have_source = false;
-	int opt, opt_ind;
-	struct globals *globals;
 	struct option long_options[] = {
 		{"server",	no_argument,		NULL,	's'},
 		{"location",    required_argument,	NULL,	'l'},
@@ -408,6 +409,10 @@ static struct globals *gpsd_init(int argc, char *argv[])
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
 	};
+	bool have_source = false;
+	struct globals *globals;
+	int opt_ind;
+	int opt;
 
 	globals = &gpsd_globals;
 	memset(globals, 0, sizeof(*globals));
@@ -455,16 +460,17 @@ static struct globals *gpsd_init(int argc, char *argv[])
 
 static int gpsd_server(struct globals *globals)
 {
-	struct timeval tv;
-	fd_set fds;
-	int max_fd, ret;
 	const size_t overhead = sizeof(*globals->push) +
 		sizeof(struct alfred_data);
 	const size_t tpv_size = sizeof(globals->buf) -
 				sizeof(*globals->push) -
 				sizeof(struct alfred_data) -
 				sizeof(*globals->gpsd_data);
+	struct timeval tv;
 	long interval;
+	fd_set fds;
+	int max_fd;
+	int ret;
 
 	globals->push = (struct alfred_push_data_v0 *) globals->buf;
 	globals->gpsd_data = (struct gpsd_v1 *)
diff --git a/hash.c b/hash.c
index 006d7ef..2715fa2 100644
--- a/hash.c
+++ b/hash.c
@@ -27,7 +27,8 @@ void hash_init(struct hashtable_t *hash)
  * if you don't remove the elements, memory might be leaked. */
 void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 {
-	struct element_t *bucket, *last_bucket;
+	struct element_t *last_bucket;
+	struct element_t *bucket;
 	int i;
 
 	for (i = 0; i < hash->size; i++) {
@@ -51,8 +52,9 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 static int hash_add_bucket(struct hashtable_t *hash, void *data,
 			   struct element_t *bucket, int check_duplicate)
 {
+	struct element_t *prev_bucket = NULL;
+	struct element_t *bucket_it;
 	int index;
-	struct element_t *bucket_it, *prev_bucket = NULL;
 
 	index = hash->choose(data, hash->size);
 	bucket_it = hash->table[index];
@@ -198,8 +200,8 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 /* adds data to the hashtable. returns 0 on success, -1 on error */
 int hash_add(struct hashtable_t *hash, void *data)
 {
-	int ret;
 	struct element_t *bucket;
+	int ret;
 
 	/* found the tail of the list, add new element */
 	bucket = debugMalloc(sizeof(struct element_t), 304);
@@ -218,8 +220,8 @@ int hash_add(struct hashtable_t *hash, void *data)
  * or NULL on error */
 void *hash_find(struct hashtable_t *hash, void *keydata)
 {
-	int index;
 	struct element_t *bucket;
+	int index;
 
 	index = hash->choose(keydata, hash->size);
 	bucket = hash->table[index];
@@ -316,8 +318,8 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 
 /* print the hash table for debugging */
 /* void hash_debug(struct hashtable_t *hash) {
-	int i;
 	struct element_t *bucket;
+	int i;
 
 	for (i = 0; i < hash->size; i++) {
 		printf("[%d] ", i);
diff --git a/list.h b/list.h
index a8bd44b..12d3ee0 100644
--- a/list.h
+++ b/list.h
@@ -247,8 +247,8 @@ static inline void list_splice(struct list_head *list,
 static inline void list_splice_tail(struct list_head *list,
 				    struct list_head *head)
 {
-	struct list_head *head_last = head->prev;
 	struct list_head *list_first = list->next;
+	struct list_head *head_last = head->prev;
 	struct list_head *list_last = list->prev;
 
 	if (list_empty(list))
@@ -628,8 +628,8 @@ static inline void hlist_add_behind(struct hlist_node *new_node,
  */
 static inline void hlist_del(struct hlist_node *node)
 {
-	struct hlist_node *next = node->next;
 	struct hlist_node **pprev = node->pprev;
+	struct hlist_node *next = node->next;
 
 	if (pprev)
 		*pprev = next;
diff --git a/main.c b/main.c
index 71a6260..9c38fd7 100644
--- a/main.c
+++ b/main.c
@@ -67,11 +67,11 @@ static int reduce_capabilities(void)
 	int ret = 0;
 
 #ifdef CONFIG_ALFRED_CAPABILITIES
+	cap_value_t cap_net_admin = CAP_NET_ADMIN;
+	cap_value_t cap_net_raw = CAP_NET_RAW;
+	cap_flag_value_t cap_flag;
 	cap_t cap_cur;
 	cap_t cap_new;
-	cap_flag_value_t cap_flag;
-	cap_value_t cap_net_raw = CAP_NET_RAW;
-	cap_value_t cap_net_admin = CAP_NET_ADMIN;
 
 	/* get current process capabilities */
 	cap_cur = cap_get_proc();
@@ -149,9 +149,6 @@ static int reduce_capabilities(void)
 
 static struct globals *alfred_init(int argc, char *argv[])
 {
-	int opt, opt_ind, i, ret;
-	double sync_period = 0.0;
-	struct globals *globals;
 	struct option long_options[] = {
 		{"set-data",		required_argument,	NULL,	's'},
 		{"request",		required_argument,	NULL,	'r'},
@@ -173,6 +170,12 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"force",		no_argument,		NULL,	'f'},
 		{NULL,			0,			NULL,	0},
 	};
+	double sync_period = 0.0;
+	struct globals *globals;
+	int opt_ind;
+	int opt;
+	int ret;
+	int i;
 
 	ret = reduce_capabilities();
 	if (ret < 0)
diff --git a/netsock.c b/netsock.c
index 95dbf5e..60b2285 100644
--- a/netsock.c
+++ b/netsock.c
@@ -40,7 +40,9 @@ alfred_addr alfred_mcast = {
 
 static int server_compare(void *d1, void *d2)
 {
-	struct server *s1 = d1, *s2 = d2;
+	struct server *s1 = d1;
+	struct server *s2 = d2;
+
 	/* compare source and type */
 	if (memcmp(&s1->hwaddr, &s2->hwaddr, sizeof(s1->hwaddr)) == 0)
 		return 1;
@@ -69,7 +71,8 @@ static int server_choose(void *d1, int size)
 
 void netsock_close_all(struct globals *globals)
 {
-	struct interface *interface, *is;
+	struct interface *interface;
+	struct interface *is;
 
 	list_for_each_entry_safe(interface, is, &globals->interfaces, list) {
 		if (interface->netsock >= 0)
@@ -112,8 +115,10 @@ static struct interface *netsock_find_interface(struct globals *globals,
 
 int netsock_set_interfaces(struct globals *globals, char *interfaces)
 {
-	char *input, *saveptr, *token;
 	struct interface *interface;
+	char *saveptr;
+	char *input;
+	char *token;
 
 	netsock_close_all(globals);
 
@@ -170,9 +175,9 @@ static int enable_raw_bind_capability(int enable)
 	int ret = 0;
 
 #ifdef CONFIG_ALFRED_CAPABILITIES
-	cap_t cap_cur;
-	cap_flag_value_t cap_flag;
 	cap_value_t cap_net_raw = CAP_NET_RAW;
+	cap_flag_value_t cap_flag;
+	cap_t cap_cur;
 
 	if (enable)
 		cap_flag = CAP_SET;
@@ -252,12 +257,13 @@ static void netsock_mcast_handle_event(struct globals *globals,
 
 static int netsock_open(struct globals *globals, struct interface *interface)
 {
-	int sock;
-	int sock_mc;
-	struct sockaddr_in6 sin6, sin6_mc;
+	struct sockaddr_in6 sin6_mc;
+	struct sockaddr_in6 sin6;
 	struct ipv6_mreq mreq;
 	struct epoll_event ev;
 	struct ifreq ifr;
+	int sock_mc;
+	int sock;
 	int ret;
 
 	interface->netsock = -1;
@@ -410,12 +416,13 @@ static int netsock_open(struct globals *globals, struct interface *interface)
 
 static int netsock_open4(struct globals *globals, struct interface *interface)
 {
-	int sock;
-	int sock_mc;
-	struct sockaddr_in sin4, sin_mc;
+	struct sockaddr_in sin_mc;
+	struct sockaddr_in sin4;
 	struct epoll_event ev;
 	struct ip_mreq mreq;
 	struct ifreq ifr;
+	int sock_mc;
+	int sock;
 	int ret;
 
 	interface->netsock = -1;
@@ -559,9 +566,9 @@ static int netsock_open4(struct globals *globals, struct interface *interface)
 
 int netsock_open_all(struct globals *globals)
 {
+	struct interface *interface;
 	int num_socks = 0;
 	int ret;
-	struct interface *interface;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		if (globals->ipv4mode)
diff --git a/recv.c b/recv.c
index 75e3faf..76bfb30 100644
--- a/recv.c
+++ b/recv.c
@@ -28,10 +28,11 @@ static int finish_alfred_push_data(struct globals *globals,
 				   struct ether_addr mac,
 				   struct alfred_push_data_v0 *push)
 {
-	unsigned int len, data_len;
-	bool new_entry_created;
 	struct alfred_data *data;
 	struct dataset *dataset;
+	bool new_entry_created;
+	unsigned int data_len;
+	unsigned int len;
 	uint8_t *pos;
 
 	/* test already done in process_alfred_push_data */
@@ -141,7 +142,8 @@ transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id)
 struct transaction_head *transaction_clean(struct globals *globals,
 					   struct transaction_head *head)
 {
-	struct transaction_packet *transaction_packet, *safe;
+	struct transaction_packet *transaction_packet;
+	struct transaction_packet *safe;
 
 	list_for_each_entry_safe(transaction_packet, safe, &head->packet_list,
 				 list) {
@@ -158,7 +160,8 @@ static int finish_alfred_transaction(struct globals *globals,
 				     struct transaction_head *head,
 				     struct ether_addr mac)
 {
-	struct transaction_packet *transaction_packet, *safe;
+	struct transaction_packet *transaction_packet;
+	struct transaction_packet *safe;
 
 	/* finish when all packets received */
 	if (!transaction_finished(head))
@@ -188,12 +191,13 @@ static int process_alfred_push_data(struct globals *globals,
 				    alfred_addr *source,
 				    struct alfred_push_data_v0 *push)
 {
-	unsigned int len;
-	struct ether_addr mac;
-	int ret;
-	struct transaction_head search, *head;
 	struct transaction_packet *transaction_packet;
+	struct transaction_head search;
+	struct transaction_head *head;
+	struct ether_addr mac;
+	unsigned int len;
 	int found;
+	int ret;
 
 	if (globals->ipv4mode)
 		ret = ipv4_to_mac(interface, source, &mac);
@@ -325,7 +329,8 @@ static int process_alfred_status_txend(struct globals *globals,
 				       alfred_addr *source,
 				       struct alfred_status_v0 *request)
 {
-	struct transaction_head search, *head;
+	struct transaction_head search;
+	struct transaction_head *head;
 	struct ether_addr mac;
 	unsigned int len;
 	int ret;
@@ -376,14 +381,14 @@ static int process_alfred_status_txend(struct globals *globals,
 int recv_alfred_packet(struct globals *globals, struct interface *interface,
 		       int recv_sock)
 {
-	uint8_t buf[MAX_PAYLOAD];
-	ssize_t length;
-	struct alfred_tlv *packet;
+	struct sockaddr_in6 source6;
 	struct sockaddr_in *source;
 	struct sockaddr_in source4;
-	struct sockaddr_in6 source6;
-	socklen_t sourcelen;
+	struct alfred_tlv *packet;
 	alfred_addr alfred_source;
+	uint8_t buf[MAX_PAYLOAD];
+	socklen_t sourcelen;
+	ssize_t length;
 
 	if (interface->netsock < 0)
 		return -1;
diff --git a/send.c b/send.c
index 10094ba..8290c98 100644
--- a/send.c
+++ b/send.c
@@ -40,15 +40,15 @@ int push_data(struct globals *globals, struct interface *interface,
 	      alfred_addr *destination, enum data_source max_source_level,
 	      int type_filter, uint16_t tx_id)
 {
-	struct hash_it_t *hashit = NULL;
-	uint8_t buf[MAX_PAYLOAD];
-	struct alfred_push_data_v0 *push;
-	struct alfred_data *data;
-	uint16_t total_length = 0;
-	size_t tlv_length;
-	uint16_t seqno = 0;
-	uint16_t length;
 	struct alfred_status_v0 status_end;
+	struct alfred_push_data_v0 *push;
+	struct hash_it_t *hashit = NULL;
+	uint16_t total_length = 0;
+	uint8_t buf[MAX_PAYLOAD];
+	struct alfred_data *data;
+	uint16_t seqno = 0;
+	size_t tlv_length;
+	uint16_t length;
 
 	push = (struct alfred_push_data_v0 *)buf;
 	push->header.type = ALFRED_PUSH_DATA;
@@ -160,11 +160,11 @@ int push_local_data(struct globals *globals)
 ssize_t send_alfred_packet(struct globals *globals, struct interface *interface,
 			   const alfred_addr *dest, void *buf, int length)
 {
-	ssize_t ret;
-	struct sockaddr *dest_addr;
 	struct sockaddr_in6 dest_addr6;
 	struct sockaddr_in dest_addr4;
+	struct sockaddr *dest_addr;
 	socklen_t slen;
+	ssize_t ret;
 
 	if (globals->ipv4mode) {
 		memset(&dest_addr4, 0, sizeof(dest_addr4));
diff --git a/server.c b/server.c
index c3d32a0..cb3fcfe 100644
--- a/server.c
+++ b/server.c
@@ -71,10 +71,11 @@ static int tx_compare(void *d1, void *d2)
 static int tx_choose(void *d1, int size)
 {
 	struct transaction_head *txh1 = d1;
-	unsigned char *key = (unsigned char *)&txh1->server_addr;
+	unsigned char *key;
 	uint32_t hash = 0;
 	size_t i;
 
+	key = (unsigned char *)&txh1->server_addr;
 	for (i = 0; i < ETH_ALEN; i++) {
 		hash += key[i];
 		hash += (hash << 10);
@@ -104,10 +105,10 @@ static int create_hashes(struct globals *globals)
 
 static int set_best_server(struct globals *globals)
 {
-	struct hash_it_t *hashit = NULL;
 	struct server *best_server = NULL;
-	int best_tq = -1;
+	struct hash_it_t *hashit = NULL;
 	struct interface *interface;
+	int best_tq = -1;
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		while (NULL != (hashit = hash_iterate(interface->server_hash,
@@ -137,8 +138,9 @@ void changed_data_type(struct globals *globals, uint8_t arg)
 static int purge_data(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
-	struct timespec now, diff;
 	struct interface *interface;
+	struct timespec diff;
+	struct timespec now;
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 
@@ -196,11 +198,11 @@ static int purge_data(struct globals *globals)
 
 static void update_server_info(struct globals *globals)
 {
+	struct hashtable_t *orig_hash = NULL;
+	struct hashtable_t *tg_hash = NULL;
 	struct hash_it_t *hashit = NULL;
 	struct interface *interface;
 	struct ether_addr *macaddr;
-	struct hashtable_t *tg_hash = NULL;
-	struct hashtable_t *orig_hash = NULL;
 
 	/* TQ is not used for primary sync mode */
 	if (globals->opmode == OPMODE_PRIMARY)
@@ -249,8 +251,8 @@ static void update_server_info(struct globals *globals)
 
 static void check_if_socket(struct interface *interface, struct globals *globals)
 {
-	int sock;
 	struct ifreq ifr;
+	int sock;
 
 	if (interface->netsock < 0)
 		return;
@@ -299,8 +301,9 @@ static void check_if_socket(struct interface *interface, struct globals *globals
 
 static void check_if_sockets(struct globals *globals)
 {
-	struct timespec now, diff;
 	struct interface *interface;
+	struct timespec diff;
+	struct timespec now;
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 	time_diff(&now, &globals->if_check, &diff);
@@ -316,11 +319,11 @@ static void check_if_sockets(struct globals *globals)
 
 static void execute_update_command(struct globals *globals)
 {
-	pid_t script_pid;
-	size_t command_len;
-	char *command;
-	size_t data_type;
 	size_t changed_data_type_count;
+	size_t command_len;
+	pid_t script_pid;
+	size_t data_type;
+	char *command;
 	/* data type is limited by ALFRED_NUM_TYPES to 255 (3 chars), plus
 	 * 1x space for appending + terminating null byte
 	 */
diff --git a/unix_sock.c b/unix_sock.c
index e6208ef..e6b44da 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -103,10 +103,12 @@ static int unix_sock_add_data(struct globals *globals,
 			      int client_sock)
 {
 	bool new_entry_created = false;
+	struct interface *interface;
 	struct alfred_data *data;
 	struct dataset *dataset;
-	int len, data_len, ret = -1;
-	struct interface *interface;
+	int data_len;
+	int ret = -1;
+	int len;
 
 	len = ntohs(push->header.length);
 
@@ -201,11 +203,12 @@ static int unix_sock_add_data(struct globals *globals,
 static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 				    uint16_t id, uint8_t requested_type)
 {
-	int len;
 	struct alfred_push_data_v0 *push;
 	struct hash_it_t *hashit = NULL;
 	uint8_t buf[MAX_PAYLOAD];
-	uint16_t seqno = 0, ret = 0;
+	uint16_t seqno = 0;
+	uint16_t ret = 0;
+	int len;
 
 	/* send some data back through the unix socket */
 
@@ -252,10 +255,10 @@ static int unix_sock_req_data(struct globals *globals,
 			      struct alfred_request_v0 *request,
 			      int client_sock)
 {
-	int len;
-	uint16_t id;
 	struct transaction_head *head = NULL;
 	struct interface *interface;
+	uint16_t id;
+	int len;
 
 	len = ntohs(request->header.length);
 
@@ -293,10 +296,11 @@ int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head)
 {
 	struct alfred_status_v0 status;
-	int ret = 0, send_data = 1;
+	uint8_t requested_type;
+	int send_data = 1;
 	int client_sock;
 	uint16_t id;
-	uint8_t requested_type;
+	int ret = 0;
 
 	requested_type = head->requested_type;
 	id = head->id;
@@ -328,7 +332,8 @@ static int unix_sock_modesw(struct globals *globals,
 			    struct alfred_modeswitch_v0 *modeswitch,
 			    int client_sock)
 {
-	int len, ret = -1;
+	int ret = -1;
+	int len;
 
 	len = ntohs(modeswitch->header.length);
 
@@ -360,7 +365,8 @@ unix_sock_change_iface(struct globals *globals,
 		       struct alfred_change_interface_v0 *change_iface,
 		       int client_sock)
 {
-	int len, ret = -1;
+	int ret = -1;
+	int len;
 
 	len = ntohs(change_iface->header.length);
 
@@ -390,7 +396,8 @@ unix_sock_change_bat_iface(struct globals *globals,
 			   struct alfred_change_bat_iface_v0 *change_bat_iface,
 			   int client_sock)
 {
-	int len, ret = -1;
+	int ret = -1;
+	int len;
 
 	len = ntohs(change_bat_iface->header.length);
 
@@ -514,13 +521,15 @@ static void unix_sock_read(struct globals *globals,
 			   struct epoll_handle *handle __unused,
 			   struct epoll_event *ev __unused)
 {
-	int client_sock;
 	struct sockaddr_un sun_addr;
-	socklen_t sun_size = sizeof(sun_addr);
 	struct alfred_tlv *packet;
 	uint8_t buf[MAX_PAYLOAD];
-	int length, headsize;
+	socklen_t sun_size;
+	int client_sock;
+	int headsize;
+	int length;
 
+	sun_size = sizeof(sun_addr);
 	client_sock = accept(globals->unix_sock, (struct sockaddr *)&sun_addr,
 			     &sun_size);
 	if (client_sock < 0) {
@@ -698,7 +707,8 @@ static void unix_sock_event_notify_listener(struct event_listener *listener,
 
 void unix_sock_events_close_all(struct globals *globals)
 {
-	struct event_listener *listener, *tmp;
+	struct event_listener *listener;
+	struct event_listener *tmp;
 
 	list_for_each_entry_safe(listener, tmp,
 				 &globals->event_listeners, list) {
@@ -709,7 +719,8 @@ void unix_sock_events_close_all(struct globals *globals)
 void unix_sock_event_notify(struct globals *globals, uint8_t type,
 			    const uint8_t source[ETH_ALEN])
 {
-	struct event_listener *listener, *tmp;
+	struct event_listener *listener;
+	struct event_listener *tmp;
 
 	/* if event notify is unsuccessful, listener socket is closed */
 	list_for_each_entry_safe(listener, tmp,
diff --git a/util.c b/util.c
index eabef57..b00b953 100644
--- a/util.c
+++ b/util.c
@@ -35,10 +35,11 @@ int time_diff(struct timespec *tv1, struct timespec *tv2,
 void time_random_seed(void)
 {
 	struct timespec now;
-	uint8_t *c = (uint8_t *)&now;
-	size_t i;
 	unsigned int s = 0;
+	uint8_t *c;
+	size_t i;
 
+	c = (uint8_t *)&now;
 	clock_gettime(CLOCK_REALTIME, &now);
 
 	for (i = 0; i < sizeof(now); i++) {
@@ -83,8 +84,8 @@ static void ipv4_request_mac_resolve(const alfred_addr *addr)
 	const struct sockaddr *sockaddr;
 	struct sockaddr_in inet4;
 	size_t sockaddr_len;
-	int sock;
 	char t = 0;
+	int sock;
 
 	sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock < 0)
@@ -104,8 +105,8 @@ static void ipv4_request_mac_resolve(const alfred_addr *addr)
 int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
 		     struct ether_addr *mac)
 {
-	struct arpreq arpreq;
 	struct sockaddr_in *sin;
+	struct arpreq arpreq;
 	int retries = 1;
 
 	memset(&arpreq, 0, sizeof(arpreq));
diff --git a/vis/vis.c b/vis/vis.c
index b3366bc..4642227 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -47,7 +47,8 @@ static char *mac_to_str(uint8_t *mac)
 static int get_if_mac(char *ifname, uint8_t *mac)
 {
 	struct ifreq ifr;
-	int sock, ret;
+	int sock;
+	int ret;
 
 	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
@@ -111,8 +112,8 @@ static int get_if_index_byname(struct globals *globals, char *ifname)
 static int get_if_index_devindex(struct globals *globals, int devindex)
 {
 	struct iface_list_entry *i_entry;
-	char *ifname;
 	char ifnamebuf[IF_NAMESIZE];
+	char *ifname;
 	int i;
 
 	if (!devindex)
@@ -182,9 +183,9 @@ static int parse_transtable_local_netlink_cb(struct nl_msg *msg, void *arg)
 	struct nlattr *attrs[BATADV_ATTR_MAX+1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlquery_opts *query_opts = arg;
+	struct vis_list_entry *v_entry;
 	struct vis_netlink_opts *opts;
 	struct genlmsghdr *ghdr;
-	struct vis_list_entry *v_entry;
 	uint8_t *addr;
 
 	opts = container_of(query_opts, struct vis_netlink_opts,
@@ -243,8 +244,10 @@ static int parse_transtable_local(struct globals *globals)
 
 static void clear_lists(struct globals *globals)
 {
-	struct vis_list_entry *v_entry, *v_entry_safe;
-	struct iface_list_entry *i_entry, *i_entry_safe;
+	struct iface_list_entry *i_entry_safe;
+	struct vis_list_entry *v_entry_safe;
+	struct iface_list_entry *i_entry;
+	struct vis_list_entry *v_entry;
 
 	list_for_each_entry_safe(v_entry, v_entry_safe, &globals->entry_list,
 				 list) {
@@ -514,13 +517,13 @@ static int parse_orig_list_netlink_cb(struct nl_msg *msg, void *arg)
 	struct nlattr *attrs[BATADV_ATTR_MAX+1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlquery_opts *query_opts = arg;
+	struct vis_list_entry *v_entry;
 	struct vis_netlink_opts *opts;
 	struct genlmsghdr *ghdr;
-	struct vis_list_entry *v_entry;
-	uint8_t *orig;
-	uint8_t *neigh;
-	uint8_t tq;
 	uint32_t hardif;
+	uint8_t *neigh;
+	uint8_t *orig;
+	uint8_t tq;
 
 	opts = container_of(query_opts, struct vis_netlink_opts,
 			    query_opts);
@@ -589,7 +592,8 @@ static int parse_orig_list(struct globals *globals)
 
 static int vis_publish_data(struct globals *globals)
 {
-	int len, ret;
+	int len;
+	int ret;
 
 	/* to push data we have to add a push header, the header for the data
 	 * and our own data type.
@@ -620,7 +624,8 @@ static int compile_vis_data(struct globals *globals)
 	struct iface_list_entry *i_entry;
 	struct vis_list_entry *v_entry;
 	struct vis_entry *vis_entries;
-	int iface_n = 0, entries_n = 0;
+	int entries_n = 0;
+	int iface_n = 0;
 
 	list_for_each_entry(i_entry, &globals->iface_list, list) {
 		memcpy(&globals->vis_data->ifaces[iface_n], i_entry->mac, ETH_ALEN);
@@ -684,11 +689,12 @@ static int vis_request_data(struct globals *globals)
 
 static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 {
-	static uint8_t buf[65536];
-	struct alfred_tlv *tlv;
 	struct alfred_push_data_v0 *push;
+	static uint8_t buf[65536];
 	struct alfred_data *data;
-	int l, ret;
+	struct alfred_tlv *tlv;
+	int ret;
+	int l;
 
 	ret = read(sock, buf, sizeof(*tlv));
 	if (ret < 0)
@@ -836,8 +842,8 @@ static void vis_jsondoc_preamble(void)
 
 static void vis_jsondoc_interfaces(uint8_t iface_n, struct vis_iface *ifaces)
 {
-	int i;
 	static bool first_interface = true;
+	int i;
 
 	if (first_interface)
 		first_interface = false;
@@ -954,10 +960,10 @@ static const struct vis_print_ops vis_jsondoc_ops =
 static int vis_read_answer(struct globals *globals)
 {
 	const struct vis_print_ops *ops;
+	struct vis_entry *vis_entries;
+	struct vis_iface *ifaces;
 	struct vis_v1 *vis_data;
 	uint16_t len;
-	struct vis_iface *ifaces;
-	struct vis_entry *vis_entries;
 
 	switch (globals->vis_format) {
 	case FORMAT_DOT:
@@ -1029,8 +1035,6 @@ static void vis_usage(void)
 
 static struct globals *vis_init(int argc, char *argv[])
 {
-	int opt, opt_ind;
-	struct globals *globals;
 	struct option long_options[] = {
 		{"server",	no_argument,		NULL,	's'},
 		{"interface",	required_argument,	NULL,	'i'},
@@ -1040,6 +1044,9 @@ static struct globals *vis_init(int argc, char *argv[])
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
 	};
+	struct globals *globals;
+	int opt_ind;
+	int opt;
 
 	globals = &vis_globals;
 	memset(globals, 0, sizeof(*globals));

---
base-commit: 88db36d4c50cda4665809fe8da0d7a975b5596aa
change-id: 20260608-reverse-xmas-41cf7b2a0238

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

