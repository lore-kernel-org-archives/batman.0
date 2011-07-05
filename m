Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:00 +0200
Message-Id: <1309879385-21224-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: unify the three starting
	fields of the tt_local/global_entry structures
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

Now the three starting fields of the tt_local/global_entry structures are
unified. This allows to write generalised functions that operate on the
flags and refcount field.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 types.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/types.h b/types.h
index 25bd1db..b32ae5a 100644
--- a/types.h
+++ b/types.h
@@ -223,20 +223,20 @@ struct socket_packet {
 
 struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
-	unsigned long last_seen;
 	uint16_t flags;
 	atomic_t refcount;
+	unsigned long last_seen;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry;
 };
 
 struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
+	uint16_t flags; /* only TT_GLOBAL_ROAM is used */
+	atomic_t refcount;
 	struct orig_node *orig_node;
 	uint8_t ttvn;
-	uint16_t flags; /* only TT_GLOBAL_ROAM is used */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
-	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry; /* entry in the global table */
 };
-- 
1.7.3.4

