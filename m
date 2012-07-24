Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 24 Jul 2012 14:41:36 +0200
Message-Id: <1343133696-4981-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - print all warnings and
	errors on stderr
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 tcpdump.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index beac2ac..1a4a9a0 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -46,7 +46,7 @@
 
 #define LEN_CHECK(buff_len, check_len, desc) \
 if ((size_t)(buff_len) < (check_len)) { \
-	printf("Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
+	fprintf(stderr, "Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
 		desc, (check_len), (size_t)(buff_len)); \
 	return; \
 }
@@ -586,7 +586,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			break;
 		case BATADV_VIS:
 			if (dump_level & DUMP_TYPE_BATVIS)
-				printf("Warning - batman vis packet received: function not implemented yet\n");
+				fprintf(stderr, "Warning - batman vis packet received: function not implemented yet\n");
 			break;
 		case BATADV_UNICAST_FRAG:
 			if (dump_level & DUMP_TYPE_BATFRAG)
@@ -601,14 +601,14 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 				dump_batman_roam(packet_buff, buff_len, read_opt, time_printed);
 			break;
 		default:
-			printf("Warning - packet contains unknown batman packet type: 0x%02x\n", batman_ogm_packet->header.packet_type);
+			fprintf(stderr, "Warning - packet contains unknown batman packet type: 0x%02x\n", batman_ogm_packet->header.packet_type);
 			break;
 		}
 
 		break;
 
 	default:
-		printf("Warning - packet contains unknown ether type: 0x%04x\n", ntohs(eth_hdr->ether_type));
+		fprintf(stderr, "Warning - packet contains unknown ether type: 0x%04x\n", ntohs(eth_hdr->ether_type));
 		break;
 	}
 }
@@ -747,7 +747,7 @@ int tcpdump(int argc, char **argv)
 	}
 
 	if (argc <= found_args) {
-		printf("Error - target interface not specified\n");
+		fprintf(stderr, "Error - target interface not specified\n");
 		tcpdump_usage();
 		return EXIT_FAILURE;
 	}
@@ -767,14 +767,14 @@ int tcpdump(int argc, char **argv)
 		dump_if->dev = argv[found_args];
 
 		if (strlen(dump_if->dev) > IFNAMSIZ - 1) {
-			printf("Error - interface name too long: %s\n", dump_if->dev);
+			fprintf(stderr, "Error - interface name too long: %s\n", dump_if->dev);
 			goto out;
 		}
 
 		dump_if->raw_sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
 
 		if (dump_if->raw_sock < 0) {
-			printf("Error - can't create raw socket: %s\n", strerror(errno));
+			fprintf(stderr, "Error - can't create raw socket: %s\n", strerror(errno));
 			goto out;
 		}
 
@@ -783,7 +783,7 @@ int tcpdump(int argc, char **argv)
 
 		res = ioctl(dump_if->raw_sock, SIOCGIFHWADDR, &req);
 		if (res < 0) {
-			printf("Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
+			fprintf(stderr, "Error - can't create raw socket (SIOCGIFHWADDR): %s\n", strerror(errno));
 			close(dump_if->raw_sock);
 			goto out;
 		}
@@ -796,7 +796,7 @@ int tcpdump(int argc, char **argv)
 		case ARPHRD_IEEE80211_RADIOTAP:
 			break;
 		default:
-			printf("Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
+			fprintf(stderr, "Error - interface '%s' is of unknown type: %i\n", dump_if->dev, dump_if->hw_type);
 			goto out;
 		}
 
@@ -806,7 +806,7 @@ int tcpdump(int argc, char **argv)
 		res = ioctl(dump_if->raw_sock, SIOCGIFINDEX, &req);
 
 		if (res < 0) {
-			printf("Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
+			fprintf(stderr, "Error - can't create raw socket (SIOCGIFINDEX): %s\n", strerror(errno));
 			close(dump_if->raw_sock);
 			goto out;
 		}
@@ -818,7 +818,7 @@ int tcpdump(int argc, char **argv)
 		res = bind(dump_if->raw_sock, (struct sockaddr *)&dump_if->addr, sizeof(struct sockaddr_ll));
 
 		if (res < 0) {
-			printf("Error - can't bind raw socket: %s\n", strerror(errno));
+			fprintf(stderr, "Error - can't bind raw socket: %s\n", strerror(errno));
 			close(dump_if->raw_sock);
 			goto out;
 		}
@@ -844,7 +844,7 @@ int tcpdump(int argc, char **argv)
 			continue;
 
 		if (res < 0) {
-			printf("Error - can't select on raw socket: %s\n", strerror(errno));
+			fprintf(stderr, "Error - can't select on raw socket: %s\n", strerror(errno));
 			continue;
 		}
 
@@ -855,12 +855,12 @@ int tcpdump(int argc, char **argv)
 			read_len = read(dump_if->raw_sock, packet_buff, sizeof(packet_buff));
 
 			if (read_len < 0) {
-				printf("Error - can't read from interface '%s': %s\n", dump_if->dev, strerror(errno));
+				fprintf(stderr, "Error - can't read from interface '%s': %s\n", dump_if->dev, strerror(errno));
 				continue;
 			}
 
 			if ((size_t)read_len < sizeof(struct ether_header)) {
-				printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
+				fprintf(stderr, "Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
 					sizeof(struct ether_header), read_len);
 				continue;
 			}
-- 
1.7.9.1

