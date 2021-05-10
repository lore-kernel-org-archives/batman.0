Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: Avoid boolean in structures
Date: Mon, 10 May 2021 15:39:06 +0200
Message-Id: <20210510133906.45697-1-sven@narfation.org>
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

Booleans inside structures to really only store a single bit of information
is often a waste of space because a boolean is stored using multiple bytes.
While this is not too relevant for batctl, just use the same way of storing
such values as in the rest of batman-adv to avoid different paradigms in
related code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c         | 8 ++++----
 throughputmeter.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/netlink.c b/netlink.c
index 31c9b01..31f4419 100644
--- a/netlink.c
+++ b/netlink.c
@@ -592,7 +592,7 @@ static const int translate_mac_netlink_mandatory[] = {
 
 struct translate_mac_netlink_opts {
 	struct ether_addr mac;
-	bool found;
+	uint8_t found:1;
 	struct nlquery_opts query_opts;
 };
 
@@ -680,7 +680,7 @@ struct get_nexthop_netlink_opts {
 	struct ether_addr mac;
 	uint8_t *nexthop;
 	char *ifname;
-	bool found;
+	uint8_t found:1;
 	struct nlquery_opts query_opts;
 };
 
@@ -772,7 +772,7 @@ static const int get_primarymac_netlink_mandatory[] = {
 
 struct get_primarymac_netlink_opts {
 	uint8_t *primarymac;
-	bool found;
+	uint8_t found:1;
 	struct nlquery_opts query_opts;
 };
 
@@ -844,7 +844,7 @@ int get_primarymac_netlink(const char *mesh_iface, uint8_t *primarymac)
 struct get_algoname_netlink_opts {
 	char *algoname;
 	size_t algoname_len;
-	bool found;
+	uint8_t found:1;
 	struct nlquery_opts query_opts;
 };
 
diff --git a/throughputmeter.c b/throughputmeter.c
index f50f521..4c7ccca 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -38,16 +38,16 @@ static char *tp_mesh_iface;
 
 struct tp_result {
 	int error;
-	bool found;
 	uint32_t cookie;
 	uint8_t return_value;
+	uint8_t found:1;
 	uint32_t test_time;
 	uint64_t total_bytes;
 };
 
 struct tp_cookie {
 	int error;
-	bool found;
+	uint8_t found:1;
 	uint32_t cookie;
 };
 
-- 
2.30.2

