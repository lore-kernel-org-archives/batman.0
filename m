From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 14 Jan 2009 11:58:03 +0100
Message-Id: <1231930683-5625-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200901140145.34127.sven.eckelmann@gmx.de>
References: <200901140145.34127.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Suppress warning about unused parameter in
	bsd/*.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/bsd/kernel.c |   10 +++++-----
 batman/bsd/route.c  |   12 ++++++------
 batman/bsd/tun.c    |    6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/batman/bsd/kernel.c b/batman/bsd/kernel.c
index 0a126d4..b98c06f 100644
--- a/batman/bsd/kernel.c
+++ b/batman/bsd/kernel.c
@@ -76,7 +76,7 @@ int32_t get_forwarding(void)
 	return state;
 }
 
-void set_send_redirects(int32_t state, char* dev)
+void set_send_redirects(int32_t state, char* BATMANUNUSED(dev))
 {
 	int mib[4];
 
@@ -97,7 +97,7 @@ void set_send_redirects(int32_t state, char* dev)
 		err(1, "Cannot change net.inet.ip.redirect");
 }
 
-int32_t get_send_redirects(char *dev)
+int32_t get_send_redirects(char *BATMANUNUSED(dev))
 {
 	int state;
 	size_t len;
@@ -117,20 +117,20 @@ int32_t get_send_redirects(char *dev)
 	return state;
 }
 
-void set_rp_filter( int32_t state, char* dev )
+void set_rp_filter( int32_t BATMANUNUSED(state), char* BATMANUNUSED(dev) )
 {
 	/* On BSD, reverse path filtering should be disabled in the firewall. */
 	return;
 }
 
-int32_t get_rp_filter( char *dev )
+int32_t get_rp_filter( char *BATMANUNUSED(dev) )
 {
 	/* On BSD, reverse path filtering should be disabled in the firewall. */
 	return 0;
 }
 
 
-int8_t bind_to_iface( int32_t udp_recv_sock, char *dev )
+int8_t bind_to_iface( int32_t BATMANUNUSED(udp_recv_sock), char *BATMANUNUSED(dev) )
 {
 	/* XXX: Is binding a socket to a specific
 	 * interface possible in *BSD?
diff --git a/batman/bsd/route.c b/batman/bsd/route.c
index 953e995..8c9de48 100644
--- a/batman/bsd/route.c
+++ b/batman/bsd/route.c
@@ -139,8 +139,8 @@ static uint32_t get_dev_addr(char *dev)
 	return addr->sin_addr.s_addr;
 }
 
-void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src_ip,
-		int32_t ifi, char *dev, uint8_t rt_table, int8_t route_type, int8_t del)
+void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t BATMANUNUSED(src_ip),
+		int32_t BATMANUNUSED(ifi), char *dev, uint8_t BATMANUNUSED(rt_table), int8_t BATMANUNUSED(route_type), int8_t del)
 {
 	char dest_str[16], router_str[16];
 	struct rt_msg msg;
@@ -203,20 +203,20 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 }
 
 
-void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table,
-		uint32_t prio, char *iif, int8_t dst_rule, int8_t del )
+void add_del_rule(uint32_t BATMANUNUSED(network), uint8_t BATMANUNUSED(netmask), int8_t BATMANUNUSED(rt_table),
+		uint32_t BATMANUNUSED(prio), char *BATMANUNUSED(iif), int8_t BATMANUNUSED(dst_rule), int8_t BATMANUNUSED(del) )
 {
 	fprintf(stderr, "add_del_rule: not implemented\n");
 	return;
 }
 
-int add_del_interface_rules( int8_t del )
+int add_del_interface_rules( int8_t BATMANUNUSED(del) )
 {
 	fprintf(stderr, "add_del_interface_rules: not implemented\n");
 	return 0;
 }
 
-int flush_routes_rules( int8_t rt_table )
+int flush_routes_rules( int8_t BATMANUNUSED(rt_table) )
 {
 	fprintf(stderr, "flush_routes_rules: not implemented\n");
 	return 0;
diff --git a/batman/bsd/tun.c b/batman/bsd/tun.c
index 7d4c79c..b44dac3 100644
--- a/batman/bsd/tun.c
+++ b/batman/bsd/tun.c
@@ -90,7 +90,7 @@ static int open_tun_any(char *dev_name, size_t dev_name_size)
 #endif
 
 /* Probe for tun interface availability */
-int8_t probe_tun(uint8_t print_to_stderr)
+int8_t probe_tun(uint8_t BATMANUNUSED(print_to_stderr))
 {
 	int fd;
 	fd = open_tun_any(NULL, 0);
@@ -105,7 +105,7 @@ int8_t del_dev_tun(int32_t fd)
 	return close(fd);
 }
 
-int8_t set_tun_addr(int32_t fd, uint32_t tun_addr, char *tun_ifname)
+int8_t set_tun_addr(int32_t BATMANUNUSED(fd), uint32_t tun_addr, char *tun_ifname)
 {
 	int so;
 	struct ifreq ifr_tun;
@@ -136,7 +136,7 @@ int8_t set_tun_addr(int32_t fd, uint32_t tun_addr, char *tun_ifname)
 }
 
 int8_t add_dev_tun(struct batman_if *batman_if, uint32_t tun_addr,
-		char *tun_dev, size_t tun_dev_size, int32_t *fd, int32_t *ifi)
+		char *tun_dev, size_t tun_dev_size, int32_t *fd, int32_t *BATMANUNUSED(ifi))
 {
 	int so;
 	struct ifreq ifr_tun, ifr_if;
-- 
1.6.0.6

