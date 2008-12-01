From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 20:14:13 +0100
Message-Id: <1228158854-30405-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200812012005.27477.sven.eckelmann@gmx.de>
References: <200812012005.27477.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] Use ansi-style declaration for
	parameterless functions
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
 batman/bsd/kernel.c              |    2 +-
 batman/linux/kernel.c            |    2 +-
 batman/linux/modules/gateway.c   |    6 +++---
 batman/linux/modules/gateway24.c |    6 +++---
 batman/originator.c              |    2 +-
 batman/originator.h              |    2 +-
 batman/os.h                      |   18 +++++++++---------
 batman/posix/init.c              |   10 +++++-----
 batman/posix/posix.c             |   18 +++++++++---------
 batman/posix/tunnel.c            |    2 +-
 batman/profile.c                 |    4 ++--
 batman/profile.h                 |    2 +-
 12 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/batman/bsd/kernel.c b/batman/bsd/kernel.c
index 96fcb98..90076e3 100644
--- a/batman/bsd/kernel.c
+++ b/batman/bsd/kernel.c
@@ -143,7 +143,7 @@ int8_t use_kernel_module( char *dev )
 	return -1;
 }
 
-int8_t use_gateway_module( char *dev )
+int8_t use_gateway_module(void)
 {
 	return -1;
 }
diff --git a/batman/linux/kernel.c b/batman/linux/kernel.c
index 1d79013..09c24da 100644
--- a/batman/linux/kernel.c
+++ b/batman/linux/kernel.c
@@ -193,7 +193,7 @@ int8_t bind_to_iface( int32_t sock, char *dev ) {
 
 
 
-int8_t use_gateway_module() {
+int8_t use_gateway_module(void) {
 
 	int32_t fd;
 
diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index b1b346c..7ccbc3f 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -76,7 +76,7 @@ static struct task_struct *kthread_task = NULL;
 
 static struct proc_dir_entry *proc_dir, *clients_file;
 
-int init_module()
+int init_module(void)
 {
 	/* register our device - kernel assigns a free major number */
 	if ( ( Major = register_chrdev( 0, DRIVER_DEVICE, &fops ) ) < 0 ) {
@@ -111,7 +111,7 @@ int init_module()
 	return(0);
 }
 
-void cleanup_module()
+void cleanup_module(void)
 {
 	struct free_client_data *entry, *next;
 	struct gw_client *gw_client;
@@ -591,7 +591,7 @@ static int bat_netdev_close( struct net_device *dev )
 	return( 0 );
 }
 
-static int create_bat_netdev()
+static int create_bat_netdev(void)
 {
 	struct gate_priv *priv;
 
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index e26154b..6e91a40 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -67,7 +67,7 @@ static struct hashtable_t *wip_hash;
 static struct hashtable_t *vip_hash;
 static struct list_head free_client_list;
 
-int init_module()
+int init_module(void)
 {
 
 	printk(KERN_DEBUG "B.A.T.M.A.N. gateway modul\n");
@@ -95,7 +95,7 @@ int init_module()
 	return(0);
 }
 
-void cleanup_module()
+void cleanup_module(void)
 {
 	struct gate_priv *priv;
 	struct free_client_data *entry, *next;
@@ -545,7 +545,7 @@ static int bat_netdev_close( struct net_device *dev )
 	return( 0 );
 }
 
-static int create_bat_netdev()
+static int create_bat_netdev(void)
 {
 
 	struct gate_priv *priv;
diff --git a/batman/originator.c b/batman/originator.c
index ffc22fb..73cee8e 100644
--- a/batman/originator.c
+++ b/batman/originator.c
@@ -429,7 +429,7 @@ void purge_orig(uint32_t curr_time)
 
 
 
-void debug_orig() {
+void debug_orig(void) {
 
 	struct hash_it_t *hashit = NULL;
 	struct list_head *forw_pos, *orig_pos, *neigh_pos;
diff --git a/batman/originator.h b/batman/originator.h
index fd50300..1344661 100644
--- a/batman/originator.h
+++ b/batman/originator.h
@@ -29,5 +29,5 @@ int choose_orig( void *data, int32_t size );
 struct orig_node *get_orig_node( uint32_t addr );
 void update_orig( struct orig_node *orig_node, struct bat_packet *in, uint32_t neigh, struct batman_if *if_incoming, unsigned char *hna_recv_buff, int16_t hna_buff_len, uint8_t is_duplicate, uint32_t curr_time );
 void purge_orig( uint32_t curr_time );
-void debug_orig();
+void debug_orig(void);
 
diff --git a/batman/os.h b/batman/os.h
index 34f49c1..76525bf 100644
--- a/batman/os.h
+++ b/batman/os.h
@@ -36,7 +36,7 @@ void addr_to_string( uint32_t addr, char *str, int32_t len );
 
 
 
-int8_t is_aborted();
+int8_t is_aborted(void);
 void update_hna(struct orig_node *orig_node, unsigned char *new_hna, 
 				int new_hna_len, struct neigh_node *old_router);
 void handler(int32_t sig);
@@ -59,8 +59,8 @@ int8_t set_tun_addr( int32_t fd, uint32_t tun_addr, char *tun_dev );
 void apply_init_args(int argc, char *argv[]);
 void init_interface(struct batman_if *batman_if);
 void deactivate_interface(struct batman_if *batman_if);
-void check_inactive_interfaces();
-void init_interface_gw();
+void check_inactive_interfaces(void);
+void init_interface_gw(void);
 
 /* kernel.c */
 void set_rp_filter( int32_t state, char* dev );
@@ -74,16 +74,16 @@ int8_t use_gateway_module();
 
 /* posix.c */
 void print_animation( void );
-void del_default_route();
-void add_default_route();
+void del_default_route(void);
+void add_default_route(void);
 int8_t receive_packet(unsigned char *packet_buff, int32_t packet_buff_len, int16_t *packet_len, uint32_t *neigh, uint32_t timeout, struct batman_if **if_incoming);
 int8_t send_udp_packet(unsigned char *packet_buff, int packet_buff_len, struct sockaddr_in *broad, int send_sock, struct batman_if *batman_if);
-void del_gw_interface();
-void restore_defaults();
-void cleanup();
+void del_gw_interface(void);
+void restore_defaults(void);
+void cleanup(void);
 
 /* tunnel.c */
-void init_bh_ports();
+void init_bh_ports(void);
 void *gw_listen(void *arg);
 void *client_to_gw_tun( void *arg );
 
diff --git a/batman/posix/init.c b/batman/posix/init.c
index fcf34bb..79d5a3b 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -44,7 +44,7 @@ int8_t stop;
 
 
 
-int my_daemon() {
+int my_daemon(void) {
 
 	int fd;
 
@@ -85,7 +85,7 @@ int my_daemon() {
 
 }
 
-void create_routing_pipe()
+void create_routing_pipe(void)
 {
 	int fd[2], pipe_opts;
 
@@ -879,7 +879,7 @@ close_con:
 
 }
 
-void interface_listen_sockets()
+void interface_listen_sockets(void)
 {
 	struct list_head *list_pos;
 	struct batman_if *batman_if;
@@ -1124,7 +1124,7 @@ void init_interface(struct batman_if *batman_if)
 		activate_interface(batman_if);
 }
 
-void check_inactive_interfaces()
+void check_inactive_interfaces(void)
 {
 	struct list_head *list_pos;
 	struct batman_if *batman_if;
@@ -1143,7 +1143,7 @@ void check_inactive_interfaces()
 
 
 
-void init_interface_gw () {
+void init_interface_gw (void) {
 
 	int32_t sock_opts, err, skfd;
 	struct ifreq ifr;
diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index 785d8eb..1a67e13 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -52,7 +52,7 @@ uint8_t tunnel_running = 0;
 static pthread_mutex_t batman_clock_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 
-void update_internal_clock()
+void update_internal_clock(void)
 {
 	struct tms tp;
 	clock_t current_clock_tick = times(&tp);
@@ -61,7 +61,7 @@ void update_internal_clock()
 	last_clock_tick = current_clock_tick;
 }
 
-uint32_t get_time_msec()
+uint32_t get_time_msec(void)
 {
 	uint32_t time;
 
@@ -73,7 +73,7 @@ uint32_t get_time_msec()
 	return time;
 }
 
-uint64_t get_time_msec64()
+uint64_t get_time_msec64(void)
 {
 	uint64_t time;
 
@@ -230,7 +230,7 @@ int32_t rand_num( int32_t limit ) {
 
 
 
-int8_t is_aborted() {
+int8_t is_aborted(void) {
 
 	return stop != 0;
 
@@ -245,14 +245,14 @@ void handler( int32_t BATMANUNUSED(sig) ) {
 }
 
 
-void del_default_route()
+void del_default_route(void)
 {
 	curr_gateway = NULL;
 }
 
 
 
-void add_default_route()
+void add_default_route(void)
 {
 	struct curr_gw_data *curr_gw_data;
 
@@ -378,7 +378,7 @@ int8_t send_udp_packet(unsigned char *packet_buff, int32_t packet_buff_len, stru
 }
 
 
-void del_gw_interface()
+void del_gw_interface(void)
 {
 	struct batman_if *batman_if = (struct batman_if *)if_list.next;
 	struct batgat_ioc_args args;
@@ -410,7 +410,7 @@ void del_gw_interface()
 	}
 }
 
-void restore_defaults() {
+void restore_defaults(void) {
 
 	struct list_head *if_pos, *if_pos_tmp;
 	struct batman_if *batman_if;
@@ -520,7 +520,7 @@ void segmentation_fault(int32_t BATMANUNUSED(sig)) {
 
 
 
-void cleanup() {
+void cleanup(void) {
 
 	int8_t i;
 	struct debug_level_info *debug_level_info;
diff --git a/batman/posix/tunnel.c b/batman/posix/tunnel.c
index c5557f2..450e16b 100644
--- a/batman/posix/tunnel.c
+++ b/batman/posix/tunnel.c
@@ -58,7 +58,7 @@
 
 unsigned short bh_udp_ports[] = BH_UDP_PORTS;
 
-void init_bh_ports()
+void init_bh_ports(void)
 {
 	int i;
 
diff --git a/batman/profile.c b/batman/profile.c
index e96dc67..55b0450 100644
--- a/batman/profile.c
+++ b/batman/profile.c
@@ -57,7 +57,7 @@ void prof_stop(int32_t index) {
 }
 
 
-void prof_print() {
+void prof_print(void) {
 
 	int32_t index;
 
@@ -92,7 +92,7 @@ void prof_stop( int32_t index ) {
 }
 
 
-void prof_print() {
+void prof_print(void) {
 
 }
 
diff --git a/batman/profile.h b/batman/profile.h
index 7dc1761..a49be6f 100644
--- a/batman/profile.h
+++ b/batman/profile.h
@@ -48,4 +48,4 @@ struct prof_container {
 void prof_init(int32_t index, char *name);
 void prof_start(int32_t index);
 void prof_stop(int32_t index);
-void prof_print();
+void prof_print(void);
-- 
1.6.0.4

