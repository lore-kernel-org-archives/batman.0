From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:57:00 +0100
Message-Id: <1228157822-29406-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Mark function which are only declared
	locally as static
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/allocate.c     |    4 ++--
 batman/batman.c       |   12 ++++++------
 batman/list-batman.c  |    4 ++--
 batman/posix/init.c   |   10 +++++-----
 batman/posix/posix.c  |    6 +++---
 batman/posix/tunnel.c |   12 ++++++------
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/batman/allocate.c b/batman/allocate.c
index 3ae365b..7160daf 100644
--- a/batman/allocate.c
+++ b/batman/allocate.c
@@ -65,7 +65,7 @@ struct memoryUsage
 };
 
 
-void addMemory( uint32_t length, int32_t tag ) {
+static void addMemory( uint32_t length, int32_t tag ) {
 
 	struct memoryUsage *walker;
 
@@ -98,7 +98,7 @@ void addMemory( uint32_t length, int32_t tag ) {
 }
 
 
-void removeMemory( int32_t tag, int32_t freetag ) {
+static void removeMemory( int32_t tag, int32_t freetag ) {
 
 	struct memoryUsage *walker;
 
diff --git a/batman/batman.c b/batman/batman.c
index a23ef77..ebe5aab 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -221,7 +221,7 @@ int is_batman_if(char *dev, struct batman_if **batman_if)
  * if found, delete it from the buf and return 1.
  * if not found, return 0.
  */
-int hna_buff_delete(struct hna_element *buf, int *buf_len, struct hna_element *e)
+static int hna_buff_delete(struct hna_element *buf, int *buf_len, struct hna_element *e)
 {
 	int i;
 	int num_elements;
@@ -703,7 +703,7 @@ int isBntog(uint32_t neigh, struct orig_node *orig_tog_node)
 
 
 
-int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *orig_neigh_node, struct bat_packet *in, uint32_t recv_time, struct batman_if *if_incoming)
+static int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *orig_neigh_node, struct bat_packet *in, uint32_t recv_time, struct batman_if *if_incoming)
 {
 
 	struct list_head *list_pos;
@@ -792,7 +792,7 @@ int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *orig_nei
 
 
 
-void generate_vis_packet(void)
+static void generate_vis_packet(void)
 {
 	struct hash_it_t *hashit = NULL;
 	struct orig_node *orig_node;
@@ -901,7 +901,7 @@ void generate_vis_packet(void)
 
 
 
-void send_vis_packet(void)
+static void send_vis_packet(void)
 {
 	generate_vis_packet();
 
@@ -911,7 +911,7 @@ void send_vis_packet(void)
 
 
 
-uint8_t count_real_packets(struct bat_packet *in, uint32_t neigh, struct batman_if *if_incoming)
+static uint8_t count_real_packets(struct bat_packet *in, uint32_t neigh, struct batman_if *if_incoming)
 {
 	struct list_head *list_pos;
 	struct orig_node *orig_node;
@@ -961,7 +961,7 @@ uint8_t count_real_packets(struct bat_packet *in, uint32_t neigh, struct batman_
 	return is_duplicate;
 }
 
-void add_del_own_hna_throw(struct hna_node *hna_node, int8_t del)
+static void add_del_own_hna_throw(struct hna_node *hna_node, int8_t del)
 {
 	/* add/delete throw routing entries for own hna */
 	add_del_route(hna_node->addr, hna_node->netmask, 0, 0, 0, "unknown", BATMAN_RT_TABLE_NETWORKS, ROUTE_TYPE_THROW, del);
diff --git a/batman/list-batman.c b/batman/list-batman.c
index a34f34b..94c757e 100644
--- a/batman/list-batman.c
+++ b/batman/list-batman.c
@@ -29,7 +29,7 @@
  * This is only for internal list manipulation where we know
  * the next entries already!
  */
-void __list_add( struct list_head *new, struct list_head *prev, struct list_head *next ) {
+static void __list_add( struct list_head *new, struct list_head *prev, struct list_head *next ) {
 
 	new->next = next;
 	prev->next = new;
@@ -85,7 +85,7 @@ void list_add_before( struct list_head *prev_node, struct list_head *next_node,
  * This is only for internal list manipulation where we know
  * the next entries already!
  */
-void __list_del( struct list_head *prev, struct list_head *next ) {
+static void __list_del( struct list_head *prev, struct list_head *next ) {
 
 	prev->next = next;
 
diff --git a/batman/posix/init.c b/batman/posix/init.c
index 42a8cce..c153528 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -44,7 +44,7 @@ int8_t stop;
 
 
 
-int my_daemon(void) {
+static int my_daemon(void) {
 
 	int fd;
 
@@ -85,7 +85,7 @@ int my_daemon(void) {
 
 }
 
-void create_routing_pipe(void)
+static void create_routing_pipe(void)
 {
 	int fd[2], pipe_opts;
 
@@ -879,7 +879,7 @@ close_con:
 
 }
 
-void interface_listen_sockets(void)
+static void interface_listen_sockets(void)
 {
 	struct list_head *list_pos;
 	struct batman_if *batman_if;
@@ -899,7 +899,7 @@ void interface_listen_sockets(void)
 	}
 }
 
-int is_interface_up(char *dev)
+static int is_interface_up(char *dev)
 {
 	struct ifreq int_req;
 	int sock;
@@ -961,7 +961,7 @@ void deactivate_interface(struct batman_if *batman_if)
 	debug_output(3, "Interface deactivated: %s\n", batman_if->dev);
 }
 
-void activate_interface(struct batman_if *batman_if)
+static void activate_interface(struct batman_if *batman_if)
 {
 	struct ifreq int_req;
 	int on = 1, sock_opts;
diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index 17b0667..3efc541 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -50,7 +50,7 @@ uint8_t tunnel_running = 0;
 static pthread_mutex_t batman_clock_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 
-void update_internal_clock(void)
+static void update_internal_clock(void)
 {
 	struct tms tp;
 	clock_t current_clock_tick = times(&tp);
@@ -84,7 +84,7 @@ uint64_t get_time_msec64(void)
 }
 
 /* batman animation */
-void sym_print( char x, char y, char *z ) {
+static void sym_print( char x, char y, char *z ) {
 
 	char i = 0, Z;
 
@@ -123,7 +123,7 @@ void sym_print( char x, char y, char *z ) {
 
 
 
-void bat_wait( int32_t T, int32_t t ) {
+static void bat_wait( int32_t T, int32_t t ) {
 
 	struct timeval time;
 
diff --git a/batman/posix/tunnel.c b/batman/posix/tunnel.c
index 450e16b..c8cb1d1 100644
--- a/batman/posix/tunnel.c
+++ b/batman/posix/tunnel.c
@@ -68,7 +68,7 @@ void init_bh_ports(void)
 
 
 
-int8_t get_tun_ip( struct sockaddr_in *gw_addr, int32_t udp_sock, uint32_t *tun_addr ) {
+static int8_t get_tun_ip( struct sockaddr_in *gw_addr, int32_t udp_sock, uint32_t *tun_addr ) {
 
 	struct sockaddr_in sender_addr;
 	struct timeval tv;
@@ -407,7 +407,7 @@ out:
 	return NULL;
 }
 
-struct gw_client *get_ip_addr(struct sockaddr_in *client_addr, struct hashtable_t **wip_hash, struct hashtable_t **vip_hash, struct list_head_first *free_ip_list, uint8_t next_free_ip[]) {
+static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr, struct hashtable_t **wip_hash, struct hashtable_t **vip_hash, struct list_head_first *free_ip_list, uint8_t next_free_ip[]) {
 
 	struct gw_client *gw_client;
 	struct free_ip *free_ip;
@@ -485,19 +485,19 @@ struct gw_client *get_ip_addr(struct sockaddr_in *client_addr, struct hashtable_
 
 /* needed for hash, compares 2 struct gw_client, but only their ip-addresses. assumes that
  * the ip address is the first/second field in the struct */
-int compare_wip(void *data1, void *data2)
+static int compare_wip(void *data1, void *data2)
 {
 	return ( memcmp( data1, data2, 4 ) );
 }
 
-int compare_vip(void *data1, void *data2)
+static int compare_vip(void *data1, void *data2)
 {
 	return ( memcmp( ((char *)data1) + 4, ((char *)data2) + 4, 4 ) );
 }
 
 /* hashfunction to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
-int choose_wip(void *data, int32_t size)
+static int choose_wip(void *data, int32_t size)
 {
 	unsigned char *key= data;
 	uint32_t hash = 0;
@@ -517,7 +517,7 @@ int choose_wip(void *data, int32_t size)
 
 }
 
-int choose_vip(void *data, int32_t size)
+static int choose_vip(void *data, int32_t size)
 {
 	unsigned char *key= data;
 	uint32_t hash = 0;
-- 
1.6.0.4

