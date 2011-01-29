Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Jan 2011 17:16:47 +0100
Message-Id: <1296317807-13584-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: add raw wifi packet decapsulation
	support
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
Added ntohs() to make it more portable.

 batctl/tcpdump.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 batctl/tcpdump.h |   49 +++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 8a08bbf..a439c1e 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -29,6 +29,7 @@
 #include <sys/time.h>
 #include <arpa/inet.h>
 #include <net/if.h>
+#include <net/if_arp.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <netinet/tcp.h>
@@ -459,6 +460,75 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	}
 }
 
+static void parse_wifi_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+{
+	struct ether_header *eth_hdr;
+	struct ieee80211_hdr *wifi_hdr;
+	unsigned char *shost, *dhost;
+	uint16_t fc;
+	int hdr_len;
+
+	if (buff_len <= (ssize_t)PRISM_HEADER_LEN)
+		return;
+
+	buff_len -= PRISM_HEADER_LEN;
+	packet_buff += PRISM_HEADER_LEN;
+
+	/* we assume a minimum size of 38 bytes
+	 * (802.11 data frame + LLC)
+	 * before we calculate the real size */
+	if (buff_len <= 38)
+		return;
+
+	wifi_hdr = (struct ieee80211_hdr *)packet_buff;
+	fc = ntohs(wifi_hdr->frame_control);
+
+	/* not carrying payload */
+	if ((fc & IEEE80211_FCTL_FTYPE) != IEEE80211_FTYPE_DATA)
+		return;
+
+	/* encrypted packet */
+	if (fc & IEEE80211_FCTL_PROTECTED)
+		return;
+
+	shost = wifi_hdr->addr2;
+	if (fc & IEEE80211_FCTL_FROMDS)
+		shost = wifi_hdr->addr3;
+	else if (fc & IEEE80211_FCTL_TODS)
+		shost = wifi_hdr->addr4;
+
+	dhost = wifi_hdr->addr1;
+	if (fc & IEEE80211_FCTL_TODS)
+		dhost = wifi_hdr->addr3;
+
+	hdr_len = 24;
+	if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
+		hdr_len = 30;
+
+	if (fc & IEEE80211_STYPE_QOS_DATA)
+		hdr_len += 2;
+
+	/* LLC */
+	hdr_len += 8;
+	hdr_len -= sizeof(struct ether_header);
+
+	if (buff_len <= hdr_len)
+		return;
+
+	buff_len -= hdr_len;
+	packet_buff += hdr_len;
+
+	eth_hdr = (struct ether_header *)packet_buff;
+	memmove(eth_hdr->ether_shost, shost, ETH_ALEN);
+	memmove(eth_hdr->ether_dhost, dhost, ETH_ALEN);
+
+	 /* printf("parse_wifi_hdr(): ether_type: 0x%04x\n", ntohs(eth_hdr->ether_type));
+	printf("parse_wifi_hdr(): shost: %s\n", ether_ntoa_long((struct ether_addr *)eth_hdr->ether_shost));
+	printf("parse_wifi_hdr(): dhost: %s\n", ether_ntoa_long((struct ether_addr *)eth_hdr->ether_dhost)); */
+
+	parse_eth_hdr(packet_buff, buff_len, read_opt, time_printed);
+}
+
 int tcpdump(int argc, char **argv)
 {
 	struct ifreq req;
@@ -527,6 +597,27 @@ int tcpdump(int argc, char **argv)
 		memset(&req, 0, sizeof (struct ifreq));
 		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
 
+		res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
+		if (res < 0) {
+			printf("Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
+			close(dump_if->raw_sock);
+			goto out;
+		}
+
+		dump_if->hw_type = req.ifr_hwaddr.sa_family;
+
+		switch (dump_if->hw_type) {
+		case ARPHRD_ETHER:
+		case ARPHRD_IEEE80211_PRISM:
+			break;
+		default:
+			printf("Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
+			goto out;
+		}
+
+		memset(&req, 0, sizeof (struct ifreq));
+		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
+
 		res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
 
 		if (res < 0) {
@@ -589,7 +680,18 @@ int tcpdump(int argc, char **argv)
 				continue;
 			}
 
-			parse_eth_hdr(packet_buff, read_len, read_opt, 0);
+			switch (dump_if->hw_type) {
+			case ARPHRD_ETHER:
+				parse_eth_hdr(packet_buff, read_len, read_opt, 0);
+				break;
+			case ARPHRD_IEEE80211_PRISM:
+				parse_wifi_hdr(packet_buff, read_len, read_opt, 0);
+				break;
+			default:
+				/* should not happen */
+				break;
+			}
+
 			fflush(stdout);
 		}
 
diff --git a/batctl/tcpdump.h b/batctl/tcpdump.h
index f98d63f..a2d488f 100644
--- a/batctl/tcpdump.h
+++ b/batctl/tcpdump.h
@@ -23,6 +23,10 @@
 #include <netpacket/packet.h>
 #include "list-batman.h"
 
+#ifndef ARPHRD_IEEE80211_PRISM
+#define ARPHRD_IEEE80211_PRISM 802
+#endif
+
 #define DUMP_TYPE_BATOGM 1
 #define DUMP_TYPE_BATICMP 2
 #define DUMP_TYPE_BATUCAST 4
@@ -31,11 +35,21 @@
 #define DUMP_TYPE_BATFRAG 32
 #define DUMP_TYPE_NONBAT 64
 
+#define IEEE80211_FCTL_FTYPE 0x0c00
+#define IEEE80211_FCTL_TODS 0x0001
+#define IEEE80211_FCTL_FROMDS 0x0002
+#define IEEE80211_FCTL_PROTECTED 0x0040
+
+#define IEEE80211_FTYPE_DATA 0x0800
+
+#define IEEE80211_STYPE_QOS_DATA 0x8000
+
 struct dump_if {
 	struct list_head list;
 	char *dev;
 	int32_t raw_sock;
 	struct sockaddr_ll addr;
+	int32_t hw_type;
 };
 
 struct vlanhdr {
@@ -43,4 +57,39 @@ struct vlanhdr {
 	u_int16_t ether_type;
 } __attribute__ ((packed));
 
+struct ieee80211_hdr {
+	u_int16_t frame_control;
+	u_int16_t duration_id;
+	u_int8_t addr1[6];
+	u_int8_t addr2[6];
+	u_int8_t addr3[6];
+	u_int16_t seq_ctrl;
+	u_int8_t addr4[6];
+} __attribute__ ((packed));
+
+struct prism_item {
+	u_int32_t did;
+	u_int16_t status;
+	u_int16_t len;
+	u_int32_t data;
+};
+
+struct prism_header {
+	u_int32_t msgcode;
+	u_int32_t msglen;
+	u_int8_t devname[16];
+	struct prism_item hosttime;
+	struct prism_item mactime;
+	struct prism_item channel;
+	struct prism_item rssi;
+	struct prism_item sq;
+	struct prism_item signal;
+	struct prism_item noise;
+	struct prism_item rate;
+	struct prism_item istx;
+	struct prism_item frmlen;
+};
+
+#define PRISM_HEADER_LEN sizeof(struct prism_header)
+
 int tcpdump(int argc, char **argv);
-- 
1.7.2.3

