Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/4] alfred: Save global mode flags in bitfield
Date: Mon, 15 Feb 2021 21:01:25 +0100
Message-Id: <20210215200126.140253-3-sven@narfation.org>
In-Reply-To: <20210215200126.140253-1-sven@narfation.org>
References: <20210215200126.140253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The verbose and ipv4mode entries in the globals structure is only used to
save a boolean information. So just use a bit in a bitfield to store this
information instead of a full int.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h | 4 ++--
 main.c   | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/alfred.h b/alfred.h
index 7d6b0b3..c64ff17 100644
--- a/alfred.h
+++ b/alfred.h
@@ -115,8 +115,8 @@ struct globals {
 	enum clientmode clientmode;
 	int clientmode_arg;
 	int clientmode_version;
-	int verbose;
-	int ipv4mode;
+	uint8_t verbose:1;
+	uint8_t ipv4mode:1;
 
 	int unix_sock;
 	const char *unix_path;
diff --git a/main.c b/main.c
index 7b866cc..f25b6cc 100644
--- a/main.c
+++ b/main.c
@@ -9,6 +9,7 @@
 #include <arpa/inet.h>
 #include <getopt.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -181,8 +182,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->clientmode_version = 0;
 	globals->mesh_iface = "bat0";
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
-	globals->verbose = 0;
-	globals->ipv4mode = 0;
+	globals->verbose = false;
+	globals->ipv4mode = false;
 	globals->update_command = NULL;
 	globals->sync_period.tv_sec = ALFRED_INTERVAL;
 	globals->sync_period.tv_nsec = 0;
@@ -252,7 +253,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 			globals->unix_path = optarg;
 			break;
 		case 'd':
-			globals->verbose++;
+			globals->verbose = true;
 			break;
 		case 'c':
 			globals->update_command = optarg;
@@ -268,7 +269,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
 			break;
 		case '4':
-			globals->ipv4mode = 1;
+			globals->ipv4mode = true;
 			inet_pton(AF_INET, optarg, &alfred_mcast.ipv4);
 			printf(" ** IPv4 Multicast Mode: %x\n", alfred_mcast.ipv4.s_addr);
 			break;
-- 
2.30.0

