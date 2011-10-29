Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Oct 2011 10:06:46 +0200
Message-Id: <1319875606-7794-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
References: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: unify hash_entry field
	position in tt_local/global_entry
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, stable@kernel.org

From: Antonio Quartulli <ordex@autistici.org>

Function tt_response_fill_table() actually uses a tt_local_entry pointer to
iterate either over the local or the global table entries (it depends on the
what hash table is passed as argument). To iterate over such entries the
hlist_for_each_entry_rcu() macro has to access their "hash_entry" field which
MUST be at the same position in both the tt_global/local_entry structures.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/types.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1ae3557..ab8d0fe 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -224,22 +224,22 @@ struct socket_packet {
 
 struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
+	struct hlist_node hash_entry;
 	unsigned long last_seen;
 	uint16_t flags;
 	atomic_t refcount;
 	struct rcu_head rcu;
-	struct hlist_node hash_entry;
 };
 
 struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
+	struct hlist_node hash_entry; /* entry in the global table */
 	struct orig_node *orig_node;
 	uint8_t ttvn;
 	uint16_t flags; /* only TT_GLOBAL_ROAM is used */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
 	atomic_t refcount;
 	struct rcu_head rcu;
-	struct hlist_node hash_entry; /* entry in the global table */
 };
 
 struct tt_change_node {
-- 
1.7.5.4

