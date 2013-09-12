Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:36 +0200
Message-Id: <1379019524-23543-6-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/13] batmand: Avoid assigning const buffer
	to non-const pointer
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
Cc: Sven Eckelmann <sven@narfation.org>

Strings in C are tried to be saved in the .rodata by the compiler/linker. This
section is readonly as the name suggests. Pointer to these strings should
therefore be const.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 allocate.c          |  2 +-
 hna.c               |  4 ++--
 linux/kernel.c      | 10 +++++-----
 linux/route.c       |  8 ++++----
 linux/tun.c         |  4 ++--
 os.h                | 16 ++++++++--------
 posix/posix.c       |  2 +-
 posix/unix_socket.c |  2 +-
 profile.c           |  2 +-
 profile.h           |  4 ++--
 10 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/allocate.c b/allocate.c
index 9d79d87..57a4894 100644
--- a/allocate.c
+++ b/allocate.c
@@ -67,7 +67,7 @@ struct memoryUsage
 };
 
 
-static size_t getHeaderPad() {
+static size_t getHeaderPad(void) {
 	size_t alignwith, pad;
 
 	if (sizeof(TYPE_OF_WORD) > sizeof(void*))
diff --git a/hna.c b/hna.c
index 4c90dd3..b007ce5 100644
--- a/hna.c
+++ b/hna.c
@@ -39,12 +39,12 @@ struct list_head_first hna_chg_list;
 static pthread_mutex_t hna_chg_list_mutex;
 static struct hashtable_t *hna_global_hash = NULL;
 
-int compare_hna(void *data1, void *data2)
+static int compare_hna(void *data1, void *data2)
 {
 	return (memcmp(data1, data2, 5) == 0 ? 1 : 0);
 }
 
-int choose_hna(void *data, int32_t size)
+static int choose_hna(void *data, int32_t size)
 {
 	unsigned char *key= data;
 	uint32_t hash = 0;
diff --git a/linux/kernel.c b/linux/kernel.c
index fa8882c..08c7e20 100644
--- a/linux/kernel.c
+++ b/linux/kernel.c
@@ -70,7 +70,7 @@ static void set_integer_file(const char* filename, int32_t integer)
 	fclose(f);
 }
 
-void set_rp_filter(int32_t state, char* dev)
+void set_rp_filter(int32_t state, const char* dev)
 {
 	char filename[100], *colon_ptr;
 
@@ -85,7 +85,7 @@ void set_rp_filter(int32_t state, char* dev)
 		*colon_ptr = ':';
 }
 
-int32_t get_rp_filter(char *dev)
+int32_t get_rp_filter(const char *dev)
 {
 	int32_t state = 0;
 	char filename[100], *colon_ptr;
@@ -103,7 +103,7 @@ int32_t get_rp_filter(char *dev)
 	return state;
 }
 
-void set_send_redirects(int32_t state, char* dev)
+void set_send_redirects(int32_t state, const char* dev)
 {
 	char filename[100], *colon_ptr;
 
@@ -118,7 +118,7 @@ void set_send_redirects(int32_t state, char* dev)
 		*colon_ptr = ':';
 }
 
-int32_t get_send_redirects(char *dev)
+int32_t get_send_redirects(const char *dev)
 {
 	int32_t state = 0;
 	char filename[100], *colon_ptr;
@@ -146,7 +146,7 @@ int32_t get_forwarding(void)
 	return get_integer_file("/proc/sys/net/ipv4/ip_forward");
 }
 
-int8_t bind_to_iface(int32_t sock, char *dev)
+int8_t bind_to_iface(int32_t sock, const char *dev)
 {
 	char *colon_ptr;
 
diff --git a/linux/route.c b/linux/route.c
index bceac95..7934c27 100644
--- a/linux/route.c
+++ b/linux/route.c
@@ -73,7 +73,7 @@ static const char *rule_type_to_string_script[] = {
 
 #include <net/route.h>
 
-void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, char *dev, uint8_t rt_table, int8_t route_type, int8_t route_action)
+void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, const char *dev, uint8_t rt_table, int8_t route_type, int8_t route_action)
 {
 	struct rtentry route;
 	struct sockaddr_in *addr;
@@ -152,7 +152,7 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	close(sock);
 }
 
-void add_del_rule(uint32_t BATMANUNUSED(network), uint8_t BATMANUNUSED(netmask), int8_t BATMANUNUSED(rt_table), uint32_t BATMANUNUSED(prio), char *BATMANUNUSED(iif), int8_t BATMANUNUSED(rule_type), int8_t BATMANUNUSED(rule_action))
+void add_del_rule(uint32_t BATMANUNUSED(network), uint8_t BATMANUNUSED(netmask), int8_t BATMANUNUSED(rt_table), uint32_t BATMANUNUSED(prio), const char *BATMANUNUSED(iif), int8_t BATMANUNUSED(rule_type), int8_t BATMANUNUSED(rule_action))
 {
 	return;
 }
@@ -169,7 +169,7 @@ int flush_routes_rules(int8_t BATMANUNUSED(is_rule))
 
 #else
 
-void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, char *dev, uint8_t rt_table, int8_t route_type, int8_t route_action)
+void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, const char *dev, uint8_t rt_table, int8_t route_type, int8_t route_action)
 {
 	int netlink_sock;
 	size_t len;
@@ -354,7 +354,7 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
  *
  ***/
 
-void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t prio, char *iif, int8_t rule_type, int8_t rule_action)
+void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t prio, const char *iif, int8_t rule_type, int8_t rule_action)
 {
 	int netlink_sock;
 	size_t len;
diff --git a/linux/tun.c b/linux/tun.c
index afb0447..ac5e069 100644
--- a/linux/tun.c
+++ b/linux/tun.c
@@ -47,7 +47,7 @@
 #define IPTABLES_DEL_ACC "iptables -t nat -D POSTROUTING -s %s/%i -j ACCEPT"
 
 
-int run_cmd(char *cmd) {
+static int run_cmd(const char *cmd) {
 	int error, pipes[2], stderr = -1, ret = 0;
 	char error_log[256];
 
@@ -90,7 +90,7 @@ int probe_nat_tool(void) {
 	return run_cmd("which iptables > /dev/null");
 }
 
-void exec_iptables_rule(char *cmd, int8_t route_action) {
+static void exec_iptables_rule(const char *cmd, int8_t route_action) {
 	if (disable_client_nat)
 		return;
 
diff --git a/os.h b/os.h
index 26e97f5..2f2b2df 100644
--- a/os.h
+++ b/os.h
@@ -44,8 +44,8 @@ void segmentation_fault(int32_t sig) NO_RETURN;
 void restore_and_exit(uint8_t is_sigsegv) NO_RETURN;
 
 /* route.c */
-void add_del_route( uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, char *dev, uint8_t rt_table, int8_t route_type, int8_t del );
-void add_del_rule( uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t prio, char *iif, int8_t dst_rule, int8_t del );
+void add_del_route( uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip, int32_t ifi, const char *dev, uint8_t rt_table, int8_t route_type, int8_t del );
+void add_del_rule( uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t prio, const char *iif, int8_t dst_rule, int8_t del );
 int add_del_interface_rules( int8_t del );
 int flush_routes_rules( int8_t rt_table );
 
@@ -69,13 +69,13 @@ void init_interface_gw(void);
 void interface_listen_sockets(void);
 
 /* kernel.c */
-void set_rp_filter( int32_t state, char* dev );
-int32_t get_rp_filter( char *dev );
-void set_send_redirects( int32_t state, char* dev );
-int32_t get_send_redirects( char *dev );
+void set_rp_filter( int32_t state, const char* dev );
+int32_t get_rp_filter( const char *dev );
+void set_send_redirects( int32_t state, const char* dev );
+int32_t get_send_redirects( const char *dev );
 void set_forwarding( int32_t state );
 int32_t get_forwarding( void );
-int8_t bind_to_iface( int32_t sock, char *dev );
+int8_t bind_to_iface( int32_t sock, const char *dev );
 int is_wifi_interface(char *dev, int fd);
 
 /* posix.c */
@@ -96,7 +96,7 @@ void *client_to_gw_tun( void *arg );
 /* unix_sokcet.c */
 void *unix_listen( void *arg );
 void internal_output(uint32_t sock);
-void debug_output( int8_t debug_prio, char *format, ... );
+void debug_output( int8_t debug_prio, const char *format, ... );
 
 
 #endif
diff --git a/posix/posix.c b/posix/posix.c
index ae1cef0..81cd2e1 100644
--- a/posix/posix.c
+++ b/posix/posix.c
@@ -125,7 +125,7 @@ uint64_t get_time_msec64(void)
 }
 
 /* batman animation */
-static void sym_print( char x, char y, char *z ) {
+static void sym_print( char x, char y, const char *z ) {
 
 	char i = 0, Z;
 
diff --git a/posix/unix_socket.c b/posix/unix_socket.c
index 02a0a3a..11c5d3e 100644
--- a/posix/unix_socket.c
+++ b/posix/unix_socket.c
@@ -39,7 +39,7 @@
 #include "../hna.h"
 
 
-void debug_output(int8_t debug_prio, char *format, ...) {
+void debug_output(int8_t debug_prio, const char *format, ...) {
 
 	struct list_head *debug_pos;
 	struct debug_level_info *debug_level_info;
diff --git a/profile.c b/profile.c
index e691f5d..c76ae8d 100644
--- a/profile.c
+++ b/profile.c
@@ -33,7 +33,7 @@ static struct prof_container prof_container[PROF_COUNT];
 
 
 
-void prof_init(int32_t index, char *name) {
+void prof_init(int32_t index, const char *name) {
 
 	prof_container[index].total_time = 0;
 	prof_container[index].calls = 0;
diff --git a/profile.h b/profile.h
index d9221d5..e50bf70 100644
--- a/profile.h
+++ b/profile.h
@@ -42,13 +42,13 @@ struct prof_container {
 
 	clock_t start_time;
 	clock_t total_time;
-	char *name;
+	const char *name;
 	uint64_t calls;
 
 };
 
 
-void prof_init(int32_t index, char *name);
+void prof_init(int32_t index, const char *name);
 void prof_start(int32_t index);
 void prof_stop(int32_t index);
 void prof_print(void);
-- 
1.8.4.rc3

