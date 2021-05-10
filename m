Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: Realign netlink_policy array
Date: Mon, 10 May 2021 15:24:59 +0200
Message-Id: <20210510132459.43795-1-sven@narfation.org>
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

The netlink_policy contains an array of structures with several members in
it. But the initialization of the entries of this array was not aligned
like any other initialization in the batctl code - instead it was tried to
have everything on the same same line. This resulted in rather long lines
and could result in larger commits which just try to realign the whole
table when a new entry with a long identifier was added.

Just realign the array to better match the rest of the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 280 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 200 insertions(+), 80 deletions(-)

diff --git a/netlink.c b/netlink.c
index 31c9b01..e0e1e28 100644
--- a/netlink.c
+++ b/netlink.c
@@ -34,86 +34,206 @@ struct nlquery_opts {
 };
 
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
-	[BATADV_ATTR_VERSION]			= { .type = NLA_STRING },
-	[BATADV_ATTR_ALGO_NAME]			= { .type = NLA_STRING },
-	[BATADV_ATTR_MESH_IFINDEX]		= { .type = NLA_U32 },
-	[BATADV_ATTR_MESH_IFNAME]		= { .type = NLA_STRING,
-						    .maxlen = IFNAMSIZ },
-	[BATADV_ATTR_MESH_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_HARD_IFINDEX]		= { .type = NLA_U32 },
-	[BATADV_ATTR_HARD_IFNAME]		= { .type = NLA_STRING,
-						    .maxlen = IFNAMSIZ },
-	[BATADV_ATTR_HARD_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_ORIG_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TPMETER_RESULT]		= { .type = NLA_U8 },
-	[BATADV_ATTR_TPMETER_TEST_TIME]		= { .type = NLA_U32 },
-	[BATADV_ATTR_TPMETER_BYTES]		= { .type = NLA_U64 },
-	[BATADV_ATTR_TPMETER_COOKIE]		= { .type = NLA_U32 },
-	[BATADV_ATTR_PAD]			= { .type = NLA_UNSPEC },
-	[BATADV_ATTR_ACTIVE]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_TT_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TT_TTVN]			= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_LAST_TTVN]		= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_CRC32]			= { .type = NLA_U32 },
-	[BATADV_ATTR_TT_VID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_TT_FLAGS]			= { .type = NLA_U32 },
-	[BATADV_ATTR_FLAG_BEST]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_LAST_SEEN_MSECS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_NEIGH_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TQ]			= { .type = NLA_U8 },
-	[BATADV_ATTR_THROUGHPUT]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_UP]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ROUTER]			= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_OWN]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_BLA_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_VID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_BLA_BACKBONE]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_CRC]			= { .type = NLA_U16 },
-	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]	= { .type = NLA_U32 },
-	[BATADV_ATTR_DAT_CACHE_HWADDRESS]	= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
-	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
-	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
-	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_FRAGMENTATION_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_GW_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
-	[BATADV_ATTR_GW_BANDWIDTH_UP]		= { .type = NLA_U32 },
-	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
-	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
-	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
-	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_MULTICAST_FANOUT]		= { .type = NLA_U32 },
-	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
-	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
+	[BATADV_ATTR_VERSION] = {
+		.type = NLA_STRING,
+	},
+	[BATADV_ATTR_ALGO_NAME] = {
+		.type = NLA_STRING,
+	},
+	[BATADV_ATTR_MESH_IFINDEX] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MESH_IFNAME] = {
+		.type = NLA_STRING,
+		.maxlen = IFNAMSIZ,
+	},
+	[BATADV_ATTR_MESH_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_HARD_IFINDEX] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_HARD_IFNAME] = {
+		.type = NLA_STRING,
+		.maxlen = IFNAMSIZ,
+	},
+	[BATADV_ATTR_HARD_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_ORIG_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TPMETER_RESULT] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TPMETER_TEST_TIME] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_TPMETER_BYTES] = {
+		.type = NLA_U64,
+	},
+	[BATADV_ATTR_TPMETER_COOKIE] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_PAD] = {
+		.type = NLA_UNSPEC,
+	},
+	[BATADV_ATTR_ACTIVE] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_TT_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TT_TTVN] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TT_LAST_TTVN] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TT_CRC32] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_TT_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_TT_FLAGS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_FLAG_BEST] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_LAST_SEEN_MSECS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_NEIGH_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TQ] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_THROUGHPUT] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BANDWIDTH_UP] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BANDWIDTH_DOWN] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ROUTER] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_OWN] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_BLA_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_BLA_BACKBONE] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_CRC] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_DAT_CACHE_HWADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_DAT_CACHE_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_MCAST_FLAGS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MCAST_FLAGS_PRIV] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_VLANID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_AP_ISOLATION_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_ISOLATION_MARK] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ISOLATION_MASK] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BONDING_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_FRAGMENTATION_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_DOWN] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_UP] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_GW_MODE] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_GW_SEL_CLASS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_HOP_PENALTY] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_LOG_LEVEL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_NETWORK_CODING_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_ORIG_INTERVAL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ELP_INTERVAL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_THROUGHPUT_OVERRIDE] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MULTICAST_FANOUT] = {
+		.type = NLA_U32,
+	},
 };
 
 int netlink_create(struct state *state)
-- 
2.30.2

