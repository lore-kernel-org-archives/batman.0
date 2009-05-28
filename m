From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 28 May 2009 13:36:59 +0200
Message-Id: <1243510619-10749-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] [batman] Word-Align char buffer which
	are later casted to larger data types
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Buffers of char must not be special aligned on all architecture, but
if the compiler will not know about missing alignment of the larger
data type it generate unsafe instructions as it assumes that they
are word aligned.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.h       |    1 +
 batman/linux/route.c  |    6 +++---
 batman/posix/tunnel.c |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/batman/batman.h b/batman/batman.h
index 1cc5896..d6b00cf 100644
--- a/batman/batman.h
+++ b/batman/batman.h
@@ -152,6 +152,7 @@
 
 
 #define BATMANUNUSED(x) (x)__attribute__((unused))
+#define ALIGN_WORD __attribute__ ((aligned(sizeof(TYPE_OF_WORD))))
 
 
 
diff --git a/batman/linux/route.c b/batman/linux/route.c
index 4d46955..0c7b932 100644
--- a/batman/linux/route.c
+++ b/batman/linux/route.c
@@ -185,7 +185,7 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 		struct rtmsg rtm;
 		char buff[4 * (sizeof(struct rtattr) + 4)];
 	} *req;
-	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))] ALIGN_WORD;
 
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
@@ -369,7 +369,7 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 		struct rtmsg rtm;
 		char buff[2 * (sizeof(struct rtattr) + 4)];
 	} *req;
-	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))] ALIGN_WORD;
 
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
@@ -634,7 +634,7 @@ int flush_routes_rules(int8_t is_rule)
 	struct req_s {
 		struct rtmsg rtm;
 	} *req;
-	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))] ALIGN_WORD;
 
 	struct rtattr *rtap;
 
diff --git a/batman/posix/tunnel.c b/batman/posix/tunnel.c
index 4263794..1cfb501 100644
--- a/batman/posix/tunnel.c
+++ b/batman/posix/tunnel.c
@@ -567,7 +567,7 @@ void *gw_listen(void *BATMANUNUSED(arg)) {
 	unsigned char buff[1501];
 	int32_t res, max_sock, buff_len, tun_fd, tun_ifi;
 	uint32_t addr_len, client_timeout, current_time;
-	uint8_t my_tun_ip[4], next_free_ip[4];
+	uint8_t my_tun_ip[4] ALIGN_WORD, next_free_ip[4] ALIGN_WORD;
 	struct hashtable_t *wip_hash, *vip_hash;
 	struct list_head_first free_ip_list;
 	fd_set wait_sockets, tmp_wait_sockets;
-- 
1.6.3.1

