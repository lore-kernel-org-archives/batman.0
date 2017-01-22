Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:07:49 +0100
Message-Id: <20170122120749.27932-4-sven@narfation.org>
In-Reply-To: <2527763.cX7mnL5d4j@sven-edge>
References: <2527763.cX7mnL5d4j@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batctl: Simplify standard error messages
	with perror
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

The error string of errno can either be printed via fprintf + strerror or
by simply using the helper function perror. Using the latter can simplify
the code slightly by reducing the line length.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat-hosts.c   |  2 +-
 icmp_helper.c |  7 ++++---
 ioctl.c       |  8 ++++----
 tcpdump.c     | 10 +++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/bat-hosts.c b/bat-hosts.c
index 015fbcb..b530243 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -128,7 +128,7 @@ static void parse_hosts_file(struct hashtable_t **hash, const char path[], int r
 
 		if (!bat_host) {
 			if (read_opt & USE_BAT_HOSTS)
-				fprintf(stderr, "Error - could not allocate memory: %s\n", strerror(errno));
+				perror("Error - could not allocate memory");
 			goto out;
 		}
 
diff --git a/icmp_helper.c b/icmp_helper.c
index fb461d5..0eea5c4 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -30,6 +30,7 @@
 #include <netinet/ether.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
@@ -190,7 +191,7 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 
 	iface->sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
 	if (iface->sock < 0) {
-		fprintf(stderr, "Error - can't create raw socket: %s\n", strerror(errno));
+		perror("Error - can't create raw socket");
 		ret = -errno;
 		goto free_iface;
 	}
@@ -201,7 +202,7 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 
 	ret = ioctl(iface->sock, SIOCGIFINDEX, &req);
 	if (ret < 0) {
-		fprintf(stderr, "Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
+		perror("Error - can't create raw socket (SIOCGIFINDEX)");
 		ret = -errno;
 		goto close_sock;
 	}
@@ -214,7 +215,7 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 
 	ret = bind(iface->sock, (struct sockaddr *)&sll, sizeof(struct sockaddr_ll));
 	if (ret < 0) {
-		fprintf(stderr, "Error - can't bind raw socket: %s\n", strerror(errno));
+		perror("Error - can't bind raw socket");
 		ret = -errno;
 		goto close_sock;
 	}
diff --git a/ioctl.c b/ioctl.c
index b1db5e4..d95fc8d 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -48,7 +48,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (void *)&drvinfo;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		fprintf(stderr, "Error - can't open driver information: %s\n", strerror(errno));
+		perror("Error - can't open driver information");
 		goto out;
 	}
 
@@ -72,7 +72,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (void *)strings;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		fprintf(stderr, "Error - can't get stats strings information: %s\n", strerror(errno));
+		perror("Error - can't get stats strings information");
 		goto out;
 	}
 
@@ -81,7 +81,7 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	ifr->ifr_data = (void *) stats;
 	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if (err < 0) {
-		fprintf(stderr, "Error - can't get stats information: %s\n", strerror(errno));
+		perror("Error - can't get stats information");
 		goto out;
 	}
 
@@ -110,7 +110,7 @@ int ioctl_statistics_get(char *mesh_iface)
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (fd < 0) {
-		fprintf(stderr, "Error - can't open socket: %s\n", strerror(errno));
+		perror("Error - can't open socket");
 		goto out;
 	}
 
diff --git a/tcpdump.c b/tcpdump.c
index 92171a3..3000343 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1134,7 +1134,7 @@ static struct dump_if *create_dump_interface(char *iface)
 
 	dump_if->raw_sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
 	if (dump_if->raw_sock < 0) {
-		fprintf(stderr, "Error - can't create raw socket: %s\n", strerror(errno));
+		perror("Error - can't create raw socket");
 		goto free_dumpif;
 	}
 
@@ -1144,7 +1144,7 @@ static struct dump_if *create_dump_interface(char *iface)
 
 	res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
 	if (res < 0) {
-		fprintf(stderr, "Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
+		perror("Error - can't create raw socket (SIOCGIFHWADDR)");
 		goto close_socket;
 	}
 
@@ -1166,7 +1166,7 @@ static struct dump_if *create_dump_interface(char *iface)
 
 	res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
 	if (res < 0) {
-		fprintf(stderr, "Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
+		perror("Error - can't create raw socket (SIOCGIFINDEX)");
 		goto close_socket;
 	}
 
@@ -1176,7 +1176,7 @@ static struct dump_if *create_dump_interface(char *iface)
 
 	res = bind(dump_if->raw_sock, (struct sockaddr *)&dump_if->addr, sizeof(struct sockaddr_ll));
 	if (res < 0) {
-		fprintf(stderr, "Error - can't bind raw socket: %s\n", strerror(errno));
+		perror("Error - can't bind raw socket");
 		goto close_socket;
 	}
 
@@ -1290,7 +1290,7 @@ int tcpdump(int argc, char **argv)
 			continue;
 
 		if (res < 0) {
-			fprintf(stderr, "Error - can't select on raw socket: %s\n", strerror(errno));
+			perror("Error - can't select on raw socket");
 			continue;
 		}
 
-- 
2.11.0

