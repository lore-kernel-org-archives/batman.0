Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:02 +0200
Message-Id: <1378741567-25152-2-git-send-email-sven@open-mesh.com>
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] alfred: Mark all local functions as
	static
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 vis/vis.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index 5247b31..5e7a109 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -36,7 +36,7 @@
 #include <unistd.h>
 #include "debugfs.h"
 
-char *read_file(char *fname)
+static char *read_file(char *fname)
 {
 	FILE *fp;
 	char *buf = NULL;
@@ -64,7 +64,7 @@ char *read_file(char *fname)
 	return buf;
 }
 
-char *mac_to_str(uint8_t *mac)
+static char *mac_to_str(uint8_t *mac)
 {
 	static char macstr[20];
 	snprintf(macstr, sizeof(macstr), "%02x:%02x:%02x:%02x:%02x:%02x",
@@ -72,7 +72,7 @@ char *mac_to_str(uint8_t *mac)
 	return macstr;
 }
 
-uint8_t *str_to_mac(char *str)
+static uint8_t *str_to_mac(char *str)
 {
 	static uint8_t mac[ETH_ALEN];
 	int ret;
@@ -91,7 +91,7 @@ uint8_t *str_to_mac(char *str)
 	return mac;
 }
 
-int get_if_mac(char *ifname, uint8_t *mac)
+static int get_if_mac(char *ifname, uint8_t *mac)
 {
 	struct ifreq ifr;
 	int sock;
@@ -112,7 +112,7 @@ int get_if_mac(char *ifname, uint8_t *mac)
 	return 0;
 }
 
-int get_if_index(struct globals *globals, char *ifname)
+static int get_if_index(struct globals *globals, char *ifname)
 {
 	struct iface_list_entry *i_entry;
 	int i;
@@ -143,7 +143,7 @@ int get_if_index(struct globals *globals, char *ifname)
 	return i;
 }
 
-int alfred_open_sock(struct globals *globals)
+static int alfred_open_sock(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
@@ -168,7 +168,7 @@ int alfred_open_sock(struct globals *globals)
 	return 0;
 }
 
-int parse_transtable_local(struct globals *globals)
+static int parse_transtable_local(struct globals *globals)
 {
 	char *fbuf;
 	char *lptr, *tptr;
@@ -218,7 +218,7 @@ int parse_transtable_local(struct globals *globals)
 	return 0;
 }
 
-void clear_lists(struct globals *globals)
+static void clear_lists(struct globals *globals)
 {
 	struct vis_list_entry *v_entry, *v_entry_safe;
 	struct iface_list_entry *i_entry, *i_entry_safe;
@@ -300,7 +300,7 @@ err:
 }
 
 
-int parse_orig_list(struct globals *globals)
+static int parse_orig_list(struct globals *globals)
 {
 	char *fbuf;
 	char *lptr, *tptr;
@@ -368,7 +368,7 @@ int parse_orig_list(struct globals *globals)
 	return 0;
 }
 
-int vis_publish_data(struct globals *globals)
+static int vis_publish_data(struct globals *globals)
 {
 	int len, ret;
 
@@ -396,7 +396,7 @@ int vis_publish_data(struct globals *globals)
 	return 0;
 }
 
-int compile_vis_data(struct globals *globals)
+static int compile_vis_data(struct globals *globals)
 {
 	struct iface_list_entry *i_entry;
 	struct vis_list_entry *v_entry;
@@ -424,7 +424,7 @@ int compile_vis_data(struct globals *globals)
 	return 0;
 }
 
-int vis_update_data(struct globals *globals)
+static int vis_update_data(struct globals *globals)
 {
 	clear_lists(globals);
 	register_interfaces(globals);
@@ -437,7 +437,7 @@ int vis_update_data(struct globals *globals)
 	return 0;
 }
 
-int vis_request_data(struct globals *globals)
+static int vis_request_data(struct globals *globals)
 {
 	int ret;
 
@@ -463,7 +463,7 @@ int vis_request_data(struct globals *globals)
 }
 
 
-struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
+static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 {
 	static uint8_t buf[65536];
 	struct alfred_tlv *tlv;
@@ -510,7 +510,7 @@ struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 	return (struct vis_v1 *) data->data;
 }
 
-int vis_read_answer(struct globals *globals)
+static int vis_read_answer(struct globals *globals)
 {
 	struct vis_v1 *vis_data;
 	uint16_t len;
@@ -593,7 +593,7 @@ int vis_read_answer(struct globals *globals)
 	return 0;
 }
 
-int vis_get_data(struct globals *globals)
+static int vis_get_data(struct globals *globals)
 {
 	globals->unix_sock = vis_request_data(globals);
 	if (globals->unix_sock < 0)
@@ -676,7 +676,7 @@ static struct globals *vis_init(int argc, char *argv[])
 
 
 
-int vis_server(struct globals *globals)
+static int vis_server(struct globals *globals)
 {
 	char *debugfs_mnt;
 
-- 
1.8.4.rc3

