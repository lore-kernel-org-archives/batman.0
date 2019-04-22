Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Apr 2019 10:39:58 +0200
Message-Id: <20190422083958.10197-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Drop support for translating
 destinations via debugfs
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

The support for getting the necessary data for translating traceroute/ping
destinations via netlink was added 3 years ago to batman-adv. The old
debugfs functionality is also currently disabled by default and will be
dropped completely in 2021.

These convenience helpers are now dropped as first step to get rid of
debugfs functionality in batctl. They are still provided when batman-adv
provides the generic batadv netlink family.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c   | 91 +--------------------------------------------------
 icmp_helper.c | 90 --------------------------------------------------
 ping.c        |  8 -----
 traceroute.c  |  8 -----
 4 files changed, 1 insertion(+), 196 deletions(-)

diff --git a/functions.c b/functions.c
index 636ff8d..aad6327 100644
--- a/functions.c
+++ b/functions.c
@@ -353,98 +353,12 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	return res;
 }
 
-static int translate_mac_debugfs(const char *mesh_iface,
-				 const struct ether_addr *mac,
-				 struct ether_addr *mac_out)
-{
-	enum {
-		tg_start,
-		tg_mac,
-		tg_via,
-		tg_originator,
-	} pos;
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-	struct ether_addr *mac_tmp;
-	FILE *f = NULL;
-	size_t len = 0;
-	char *line = NULL;
-	char *input, *saveptr, *token;
-	int line_invalid;
-	bool found = false;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt)
-		return -EOPNOTSUPP;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL, mesh_iface, full_path, sizeof(full_path));
-
-	f = fopen(full_path, "r");
-	if (!f)
-		return -EOPNOTSUPP;
-
-	while (getline(&line, &len, f) != -1) {
-		line_invalid = 0;
-		pos = tg_start;
-		input = line;
-
-		while ((token = strtok_r(input, " \t", &saveptr))) {
-			input = NULL;
-
-			switch (pos) {
-			case tg_start:
-				if (strcmp(token, "*") != 0)
-					line_invalid = 1;
-				else
-					pos = tg_mac;
-				break;
-			case tg_mac:
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp || memcmp(mac_tmp, mac,
-						       ETH_ALEN) != 0)
-					line_invalid = 1;
-				else
-					pos = tg_via;
-				break;
-			case tg_via:
-				if (strcmp(token, "via") == 0)
-					pos = tg_originator;
-				break;
-			case tg_originator:
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp) {
-					line_invalid = 1;
-				} else {
-					memcpy(mac_out, mac_tmp, ETH_ALEN);
-					found = true;
-					goto out;
-				}
-				break;
-			}
-
-			if (line_invalid)
-				break;
-		}
-	}
-
-out:
-	if (f)
-		fclose(f);
-	free(line);
-
-	if (found)
-		return 0;
-	else
-		return -ENOENT;
-}
-
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac)
 {
 	struct ether_addr in_mac;
 	static struct ether_addr out_mac;
 	struct ether_addr *mac_result;
-	int ret;
 
 	/* input mac has to be copied because it could be in the shared
 	 * ether_aton buffer
@@ -456,10 +370,7 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	if (!ether_addr_valid(in_mac.ether_addr_octet))
 		return mac_result;
 
-	ret = translate_mac_netlink(mesh_iface, &in_mac, mac_result);
-
-	if (ret == -EOPNOTSUPP)
-		translate_mac_debugfs(mesh_iface, &in_mac, mac_result);
+	translate_mac_netlink(mesh_iface, &in_mac, mac_result);
 
 	return mac_result;
 }
diff --git a/icmp_helper.c b/icmp_helper.c
index bfe99f0..26233c7 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -294,94 +294,6 @@ static int icmp_interface_update_parse(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int get_nexthop_debugfs(const char *mesh_iface,
-			       struct ether_addr *mac,
-			       uint8_t nexthop[ETH_ALEN],
-			       char ifname[IF_NAMESIZE])
-{
-	char *tptr;
-	char *temp1, *temp2;
-	char *dest, *neigh, *iface;
-	int lnum, tnum;
-	struct ether_addr *mac_tmp;
-	char path[1024];
-	FILE *f = NULL;
-	size_t len = 0;
-	char *line = NULL;
-	char *primary_info;
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" "originators", mesh_iface, path, sizeof(path));
-
-	f = fopen(path, "r");
-	if (!f)
-		return -EOPNOTSUPP;
-
-	lnum = 0;
-	while (getline(&line, &len, f) != -1) {
-		lnum++;
-
-		/* find primary mac */
-		if (lnum == 1) {
-			primary_info = strstr(line, "MainIF/MAC: ");
-			if (!primary_info)
-				continue;
-
-			primary_info += 12;
-			temp1 = strstr(primary_info, "/");
-			if (!temp1)
-				continue;
-
-			temp1++;
-			temp2 = strstr(line, " ");
-			if (!temp2)
-				continue;
-
-			temp2[0] = '\0';
-			mac_tmp = ether_aton(temp1);
-			if (!mac_tmp)
-				continue;
-
-			memcpy(primary_mac, mac_tmp, ETH_ALEN);
-		}
-
-		if (lnum < 3)
-			continue;
-
-		/* find correct neighbor */
-		for (tptr = line, tnum = 0;; tptr = NULL, tnum++) {
-			tptr = strtok_r(tptr, "\t []()", &temp2);
-			if (!tptr)
-				break;
-			switch (tnum) {
-			case 0: dest = tptr; break;
-			case 2: break;
-			case 3: neigh = tptr; break;
-			case 4: iface = tptr; break;
-			default: break;
-			}
-		}
-		if (tnum <= 4)
-			continue;
-
-		mac_tmp = ether_aton(dest);
-		if (!mac_tmp || memcmp(mac_tmp, mac, ETH_ALEN) != 0)
-			continue;
-
-		mac_tmp = ether_aton(neigh);
-		if (!mac_tmp)
-			continue;
-
-		memcpy(nexthop, mac_tmp, ETH_ALEN);
-		strncpy(ifname, iface, IF_NAMESIZE);
-		ifname[IF_NAMESIZE - 1] = '\0';
-		break;
-	}
-	free(line);
-	fclose(f);
-
-	return 0;
-}
-
 static void icmp_interface_unmark(void)
 {
 	struct icmp_interface *iface;
@@ -478,8 +390,6 @@ int icmp_interface_write(const char *mesh_iface,
 	memcpy(&mac, icmp_packet->dst, ETH_ALEN);
 
 	ret = get_nexthop_netlink(mesh_iface, &mac, nexthop, ifname);
-	if (ret == -EOPNOTSUPP)
-		ret = get_nexthop_debugfs(mesh_iface, &mac, nexthop, ifname);
 	if (ret < 0)
 		goto dst_unreachable;
 
diff --git a/ping.c b/ping.c
index d798a5e..aa7cbc3 100644
--- a/ping.c
+++ b/ping.c
@@ -27,7 +27,6 @@
 #include "main.h"
 #include "functions.h"
 #include "bat-hosts.h"
-#include "debugfs.h"
 #include "icmp_helper.h"
 
 
@@ -73,7 +72,6 @@ static int ping(struct state *state, int argc, char **argv)
 	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
 	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
 	size_t packet_len;
-	char *debugfs_mnt;
 	int disable_translate_mac = 0;
 
 	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
@@ -144,12 +142,6 @@ static int ping(struct state *state, int argc, char **argv)
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		goto out;
-	}
-
 	icmp_interfaces_init();
 	packet_len = sizeof(struct batadv_icmp_packet);
 
diff --git a/traceroute.c b/traceroute.c
index 522d1c9..d810122 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -24,7 +24,6 @@
 #include "main.h"
 #include "functions.h"
 #include "bat-hosts.h"
-#include "debugfs.h"
 #include "icmp_helper.h"
 
 
@@ -52,7 +51,6 @@ static int traceroute(struct state *state, int argc, char **argv)
 	int ret = EXIT_FAILURE, res, i;
 	int found_args = 1, optchar, seq_counter = 0, read_opt = USE_BAT_HOSTS;
 	double time_delta[NUM_PACKETS];
-	char *debugfs_mnt;
 	int disable_translate_mac = 0;
 
 	while ((optchar = getopt(argc, argv, "hnT")) != -1) {
@@ -103,12 +101,6 @@ static int traceroute(struct state *state, int argc, char **argv)
 
 	mac_string = ether_ntoa_long(dst_mac);
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		goto out;
-	}
-
 	icmp_interfaces_init();
 
 	memset(&icmp_packet_out, 0, sizeof(icmp_packet_out));
-- 
2.20.1

