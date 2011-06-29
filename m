Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 30 Jun 2011 01:13:59 +0200
Message-Id: <1309389240-11486-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1309127157-32507-1-git-send-email-ordex@autistici.org>
References: <1309127157-32507-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: split tt_local/global_entry
	flags field for local and remote computations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

The tt_global/local_entry 'flags' field contains flags used either for
local and remote computations. To optimise the usage of this field, its
length has been increased to 16bit in order to use the eight leading bits
(from 0 to 7) to store flags that have to be sent on the wire, while the
eight ending ones are used for local computation only.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h |   10 ++++++----
 types.h  |    4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/packet.h b/packet.h
index 8fd2fde..590e4a6 100644
--- a/packet.h
+++ b/packet.h
@@ -78,11 +78,13 @@ enum tt_query_flags {
 	TT_FULL_TABLE = 1 << 2
 };
 
-/* TT_CLIENT flags */
+/* TT_CLIENT flags.
+ * Flags from 1 to 1 << 7 are sent on the wire, while flags from 1 << 8 to
+ * 1 << 15 are used for local computation only */
 enum tt_client_flags {
-	TT_CLIENT_DEL     = 0x01,
-	TT_CLIENT_ROAM    = 0x02,
-	TT_CLIENT_NOPURGE = 0x04
+	TT_CLIENT_DEL     = 1 << 0,
+	TT_CLIENT_ROAM    = 1 << 1,
+	TT_CLIENT_NOPURGE = 1 << 8
 };
 
 struct batman_packet {
diff --git a/types.h b/types.h
index 582283a..25bd1db 100644
--- a/types.h
+++ b/types.h
@@ -224,7 +224,7 @@ struct socket_packet {
 struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
-	uint8_t flags;
+	uint16_t flags;
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry;
@@ -234,7 +234,7 @@ struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
 	struct orig_node *orig_node;
 	uint8_t ttvn;
-	uint8_t flags; /* only TT_GLOBAL_ROAM is used */
+	uint16_t flags; /* only TT_GLOBAL_ROAM is used */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.7.3.4

