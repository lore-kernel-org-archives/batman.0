Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  2 Feb 2011 00:02:41 +0100
Message-Id: <1296601361-12112-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add radiotap wifi packet
	decapsulation support
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batctl/tcpdump.c |   37 ++++++++++++++++++++++++++++++-------
 batctl/tcpdump.h |   12 ++++++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 4443a2a..a715e27 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -460,6 +460,30 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	}
 }
 
+static int monitor_header_length(unsigned char *packet_buff, ssize_t buff_len, int32_t hw_type)
+{
+	struct radiotap_header *radiotap_hdr;
+	switch (hw_type) {
+	case ARPHRD_IEEE80211_PRISM:
+		if (buff_len <= (ssize_t)PRISM_HEADER_LEN)
+			return -1;
+		else
+			return PRISM_HEADER_LEN;
+
+	case ARPHRD_IEEE80211_RADIOTAP:
+		if (buff_len <= (ssize_t)RADIOTAP_HEADER_LEN)
+			return -1;
+
+		radiotap_hdr = (struct radiotap_header*)packet_buff;
+		if (buff_len <= radiotap_hdr->it_len)
+			return -1;
+		else
+			return radiotap_hdr->it_len;
+	}
+
+	return -1;
+}
+
 static void parse_wifi_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *eth_hdr;
@@ -468,12 +492,6 @@ static void parse_wifi_hdr(unsigned char *packet_buff, ssize_t buff_len, int rea
 	uint16_t fc;
 	int hdr_len;
 
-	if (buff_len <= (ssize_t)PRISM_HEADER_LEN)
-		return;
-
-	buff_len -= PRISM_HEADER_LEN;
-	packet_buff += PRISM_HEADER_LEN;
-
 	/* we assume a minimum size of 38 bytes
 	 * (802.11 data frame + LLC)
 	 * before we calculate the real size */
@@ -540,6 +558,7 @@ int tcpdump(int argc, char **argv)
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1, max_sock = 0, tmp;
 	int read_opt = USE_BAT_HOSTS;
 	unsigned char packet_buff[2000];
+	int monitor_header_len = -1;
 
 	while ((optchar = getopt(argc, argv, "hnp:")) != -1) {
 		switch (optchar) {
@@ -609,6 +628,7 @@ int tcpdump(int argc, char **argv)
 		switch (dump_if->hw_type) {
 		case ARPHRD_ETHER:
 		case ARPHRD_IEEE80211_PRISM:
+		case ARPHRD_IEEE80211_RADIOTAP:
 			break;
 		default:
 			printf("Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
@@ -685,7 +705,10 @@ int tcpdump(int argc, char **argv)
 				parse_eth_hdr(packet_buff, read_len, read_opt, 0);
 				break;
 			case ARPHRD_IEEE80211_PRISM:
-				parse_wifi_hdr(packet_buff, read_len, read_opt, 0);
+			case ARPHRD_IEEE80211_RADIOTAP:
+				monitor_header_len = monitor_header_length(packet_buff, read_len, dump_if->hw_type);
+				if (monitor_header_len >= 0)
+					parse_wifi_hdr(packet_buff + monitor_header_len, read_len - monitor_header_len, read_opt, 0);
 				break;
 			default:
 				/* should not happen */
diff --git a/batctl/tcpdump.h b/batctl/tcpdump.h
index 17eaeb0..4364be1 100644
--- a/batctl/tcpdump.h
+++ b/batctl/tcpdump.h
@@ -27,6 +27,10 @@
 #define ARPHRD_IEEE80211_PRISM 802
 #endif
 
+#ifndef ARPHRD_IEEE80211_RADIOTAP
+#define ARPHRD_IEEE80211_RADIOTAP 803
+#endif
+
 #define DUMP_TYPE_BATOGM 1
 #define DUMP_TYPE_BATICMP 2
 #define DUMP_TYPE_BATUCAST 4
@@ -67,6 +71,13 @@ struct ieee80211_hdr {
 	u_int8_t addr4[6];
 } __attribute__ ((packed));
 
+struct radiotap_header {
+	u_int8_t it_version;
+	u_int8_t it_pad;
+	u_int16_t it_len;
+	u_int32_t it_present;
+} __attribute__((__packed__));
+
 struct prism_item {
 	u_int32_t did;
 	u_int16_t status;
@@ -91,5 +102,6 @@ struct prism_header {
 };
 
 #define PRISM_HEADER_LEN sizeof(struct prism_header)
+#define RADIOTAP_HEADER_LEN sizeof(struct radiotap_header)
 
 int tcpdump(int argc, char **argv);
-- 
1.7.2.3

