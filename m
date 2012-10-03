Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  3 Oct 2012 22:15:31 +0200
Message-Id: <1349295331-8699-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Allow to use IPv4 addresses for
	ping/traceroute
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

IPv4 addresses and hostnames are easier to remember than many MAC addresses.
batctl can automatically resolve the MAC address of the target device when the
IP is configured on top of the batman-adv device and the source and destination
batman-adv interface are in the same IPv4 subnet.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c  |  149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 functions.h  |    1 +
 man/batctl.8 |   14 ++++--
 ping.c       |    4 +-
 traceroute.c |    4 +-
 5 files changed, 164 insertions(+), 8 deletions(-)

diff --git a/functions.c b/functions.c
index e095fd0..8c731e7 100644
--- a/functions.c
+++ b/functions.c
@@ -22,6 +22,9 @@
 
 #define _GNU_SOURCE
 #include <netinet/ether.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <netdb.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -318,3 +321,149 @@ out:
 		close(fd);
 	return res;
 }
+
+static uint32_t resolve_ipv4(const char *asc)
+{
+	int ret;
+	struct addrinfo hints;
+	struct addrinfo *res;
+	struct sockaddr_in *inet4;
+	uint32_t addr = 0;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_INET;
+	ret = getaddrinfo(asc, NULL, &hints, &res);
+	if (ret)
+		return 0;
+
+	if (res) {
+		inet4 = (struct sockaddr_in *)res->ai_addr;
+		addr = inet4->sin_addr.s_addr;
+	}
+
+	freeaddrinfo(res);
+	return addr;
+}
+
+static void request_arp(uint32_t ipv4_addr)
+{
+	struct sockaddr_in inet4;
+	int sock;
+	char t = 0;
+
+	memset(&inet4, 0, sizeof(inet4));
+	sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock < 0)
+		return;
+
+	inet4.sin_family = AF_INET;
+	inet4.sin_port = htons(9);
+	inet4.sin_addr.s_addr = ipv4_addr;
+	sendto(sock, &t, 1, 0, (const struct sockaddr *)&inet4,
+	       sizeof(inet4));
+	close(sock);
+}
+
+static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
+{
+	static struct ether_addr mac_empty;
+	struct ether_addr *mac_result = NULL, *mac_tmp;
+	struct sockaddr_in inet4;
+	int ret;
+	FILE *f;
+	size_t len = 0;
+	char *line = NULL;
+	int skip_line = 1;
+	size_t column;
+	char *token, *input, *saveptr;
+	int line_invalid;
+
+	memset(&mac_empty, 0, sizeof(mac_empty));
+
+	f = fopen("/proc/net/arp", "r");
+	if (!f)
+		return NULL;
+
+	while (getline(&line, &len, f) != -1) {
+		if (skip_line) {
+			skip_line = 0;
+			continue;
+		}
+
+		line_invalid = 0;
+		column = 0;
+		input = line;
+		while ((token = strtok_r(input, " \t", &saveptr))) {
+			input = NULL;
+
+			if (column == 0) {
+				ret = inet_pton(AF_INET, token, &inet4.sin_addr);
+				if (ret != 1) {
+					line_invalid = 1;
+					break;
+				}
+			}
+
+			if (column == 3) {
+				mac_tmp = ether_aton(token);
+				if (!mac_tmp || memcmp(mac_tmp, &mac_empty,
+						       sizeof(mac_empty)) == 0) {
+					line_invalid = 1;
+					break;
+				}
+			}
+
+			column++;
+		}
+
+		if (column < 4)
+			line_invalid = 1;
+
+		if (line_invalid)
+			continue;
+
+		if (ipv4_addr == inet4.sin_addr.s_addr) {
+			mac_result = mac_tmp;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return mac_result;
+}
+
+static struct ether_addr *resolve_mac_from_ipv4(const char *asc)
+{
+	uint32_t ipv4_addr;
+	int retries = 5;
+	struct ether_addr *mac_result = NULL;
+
+	ipv4_addr = resolve_ipv4(asc);
+	if (!ipv4_addr)
+		return NULL;
+
+	while (retries-- && !mac_result) {
+		mac_result = resolve_mac_from_arp(ipv4_addr);
+		if (!mac_result) {
+			request_arp(ipv4_addr);
+			usleep(200000);
+		}
+	}
+
+	return mac_result;
+}
+
+struct ether_addr *resolve_mac(const char *asc)
+{
+	struct ether_addr *mac_result = NULL;
+
+	mac_result = ether_aton(asc);
+	if (mac_result)
+		goto out;
+
+	mac_result = resolve_mac_from_ipv4(asc);
+
+out:
+	return mac_result;
+}
diff --git a/functions.h b/functions.h
index 92d6ae5..4629a55 100644
--- a/functions.h
+++ b/functions.h
@@ -37,6 +37,7 @@ int file_exists(const char *fpath);
 int read_file(char *dir, char *path, int read_opt,
 	      float orig_timeout, float watch_interval);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
+struct ether_addr *resolve_mac(const char *asc);
 
 extern char *line_ptr;
 
diff --git a/man/batctl.8 b/man/batctl.8
index ab02e9a..2a1ae88 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -204,16 +204,22 @@ tt - translation table counters
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
 .br
-.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
-not a MAC address. The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
+not a MAC address. It can also try to guess the MAC address using an IPv4 address or a hostname when
+the IPv4 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IPv4 subnet.
+The "\-c" option tells batctl how man pings should be sent before the program exits. Without the "\-c"
 option batctl will continue pinging without end. Use CTRL + C to stop it.  With "\-i" and "\-t" you can set the default
 interval between pings and the timeout time for replies, both in seconds. When run with "\-R", the route taken by the ping
 messages will be recorded.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIPv4_address\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
-was not a MAC address. batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
+was not a MAC address. It can also try to guess the MAC address using an IPv4 address or a hostname when
+the IPv4 address was configured on top of the batman-adv interface of the destination device and both source and
+destination devices are in the same IPv4 subnet.
+batctl will send 3 packets to each host and display the response time. If "\-n" is given batctl will
 not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBtcpdump\fP|\fBtd\fP [\fB\-c\fP][\fB\-n\fP][\fB\-p filter\fP][\fB\-x filter\fP] \fBinterface ...\fP"
diff --git a/ping.c b/ping.c
index ce8f457..b763715 100644
--- a/ping.c
+++ b/ping.c
@@ -131,10 +131,10 @@ int ping(char *mesh_iface, int argc, char **argv)
 		dst_mac = &bat_host->mac_addr;
 
 	if (!dst_mac) {
-		dst_mac = ether_aton(dst_string);
+		dst_mac = resolve_mac(dst_string);
 
 		if (!dst_mac) {
-			printf("Error - the ping destination is not a mac address or bat-host name: %s\n", dst_string);
+			printf("Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
 			goto out;
 		}
 	}
diff --git a/traceroute.c b/traceroute.c
index 75ff2b3..781b4cf 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -93,10 +93,10 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		dst_mac = &bat_host->mac_addr;
 
 	if (!dst_mac) {
-		dst_mac = ether_aton(dst_string);
+		dst_mac = resolve_mac(dst_string);
 
 		if (!dst_mac) {
-			printf("Error - the traceroute destination is not a mac address or bat-host name: %s\n", dst_string);
+			printf("Error - mac address of the ping destination could not be resolved and is not a bat-host name: %s\n", dst_string);
 			goto out;
 		}
 	}
-- 
1.7.10.4

