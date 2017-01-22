Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:07:46 +0100
Message-Id: <20170122120749.27932-1-sven@narfation.org>
In-Reply-To: <2527763.cX7mnL5d4j@sven-edge>
References: <2527763.cX7mnL5d4j@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batctl: tcpdump: Reset socket state on
	initialization error
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The raw dump_if sockets for tcpdump are closed+freed when an error happens
during initialization. But only fully initialized sockets were correctly
cleaned up. The socket causing the error was not handled by the standard
cleanup code.

Moving the dump_if initialization code in a separate function makes it
possible to also clean up the current dump_if without increasing the code
complexity.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 143 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index c7e0cbc..586a2ca 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1113,9 +1113,84 @@ static void parse_wifi_hdr(unsigned char *packet_buff, ssize_t buff_len, int rea
 	parse_eth_hdr(packet_buff, buff_len, read_opt, time_printed);
 }
 
-int tcpdump(int argc, char **argv)
+static struct dump_if *create_dump_interface(char *iface)
 {
+	struct dump_if *dump_if;
 	struct ifreq req;
+	int res;
+
+	dump_if = malloc(sizeof(struct dump_if));
+	if (!dump_if)
+		return NULL;
+
+	memset(dump_if, 0, sizeof(struct dump_if));
+
+	dump_if->dev = iface;
+	if (strlen(dump_if->dev) > IFNAMSIZ - 1) {
+		fprintf(stderr, "Error - interface name too long: %s\n", dump_if->dev);
+		goto free_dumpif;
+	}
+
+	dump_if->raw_sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (dump_if->raw_sock < 0) {
+		fprintf(stderr, "Error - can't create raw socket: %s\n", strerror(errno));
+		goto free_dumpif;
+	}
+
+	memset(&req, 0, sizeof (struct ifreq));
+	strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
+	req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
+
+	res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
+	if (res < 0) {
+		fprintf(stderr, "Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
+		goto close_socket;
+	}
+
+	dump_if->hw_type = req.ifr_hwaddr.sa_family;
+
+	switch (dump_if->hw_type) {
+	case ARPHRD_ETHER:
+	case ARPHRD_IEEE80211_PRISM:
+	case ARPHRD_IEEE80211_RADIOTAP:
+		break;
+	default:
+		fprintf(stderr, "Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
+		goto close_socket;
+	}
+
+	memset(&req, 0, sizeof (struct ifreq));
+	strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
+	req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
+
+	res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
+	if (res < 0) {
+		fprintf(stderr, "Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
+		goto close_socket;
+	}
+
+	dump_if->addr.sll_family   = AF_PACKET;
+	dump_if->addr.sll_protocol = htons(ETH_P_ALL);
+	dump_if->addr.sll_ifindex  = req.ifr_ifindex;
+
+	res = bind(dump_if->raw_sock, (struct sockaddr *)&dump_if->addr, sizeof(struct sockaddr_ll));
+	if (res < 0) {
+		fprintf(stderr, "Error - can't bind raw socket: %s\n", strerror(errno));
+		goto close_socket;
+	}
+
+	return dump_if;
+
+close_socket:
+	close(dump_if->raw_sock);
+free_dumpif:
+	free(dump_if);
+
+	return NULL;
+}
+
+int tcpdump(int argc, char **argv)
+{
 	struct timeval tv;
 	struct dump_if *dump_if, *dump_if_tmp;
 	struct list_head dump_if_list;
@@ -1172,71 +1247,9 @@ int tcpdump(int argc, char **argv)
 	FD_ZERO(&wait_sockets);
 
 	while (argc > found_args) {
-
-		dump_if = malloc(sizeof(struct dump_if));
-		memset(dump_if, 0, sizeof(struct dump_if));
-		dump_if->raw_sock = -1;
-
-		dump_if->dev = argv[found_args];
-
-		if (strlen(dump_if->dev) > IFNAMSIZ - 1) {
-			fprintf(stderr, "Error - interface name too long: %s\n", dump_if->dev);
-			goto out;
-		}
-
-		dump_if->raw_sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-
-		if (dump_if->raw_sock < 0) {
-			fprintf(stderr, "Error - can't create raw socket: %s\n", strerror(errno));
-			goto out;
-		}
-
-		memset(&req, 0, sizeof (struct ifreq));
-		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
-		req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
-
-		res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
-		if (res < 0) {
-			fprintf(stderr, "Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
-			close(dump_if->raw_sock);
-			goto out;
-		}
-
-		dump_if->hw_type = req.ifr_hwaddr.sa_family;
-
-		switch (dump_if->hw_type) {
-		case ARPHRD_ETHER:
-		case ARPHRD_IEEE80211_PRISM:
-		case ARPHRD_IEEE80211_RADIOTAP:
-			break;
-		default:
-			fprintf(stderr, "Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
-			goto out;
-		}
-
-		memset(&req, 0, sizeof (struct ifreq));
-		strncpy(req.ifr_name, dump_if->dev, IFNAMSIZ);
-		req.ifr_name[sizeof(req.ifr_name) - 1] = '\0';
-
-		res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
-
-		if (res < 0) {
-			fprintf(stderr, "Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
-			close(dump_if->raw_sock);
+		dump_if = create_dump_interface(argv[found_args]);
+		if (!dump_if)
 			goto out;
-		}
-
-		dump_if->addr.sll_family   = AF_PACKET;
-		dump_if->addr.sll_protocol = htons(ETH_P_ALL);
-		dump_if->addr.sll_ifindex  = req.ifr_ifindex;
-
-		res = bind(dump_if->raw_sock, (struct sockaddr *)&dump_if->addr, sizeof(struct sockaddr_ll));
-
-		if (res < 0) {
-			fprintf(stderr, "Error - can't bind raw socket: %s\n", strerror(errno));
-			close(dump_if->raw_sock);
-			goto out;
-		}
 
 		if (dump_if->raw_sock > max_sock)
 			max_sock = dump_if->raw_sock;
-- 
2.11.0

