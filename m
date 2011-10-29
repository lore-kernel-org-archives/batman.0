Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Oct 2011 10:06:44 +0200
Message-Id: <1319875606-7794-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
References: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: remove references for global
	tt entries
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, stable@kernel.org

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

struct tt_global_entry holds a reference to an orig_node which must be
decremented before deallocating the structure.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Tested-by: Alexey Fisher <bug-track@fisher-privat.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 873fb3d..abf05cb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -137,10 +137,22 @@ static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 		kfree_rcu(tt_local_entry, rcu);
 }
 
+static void tt_global_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
+
+	if (tt_global_entry->orig_node)
+		orig_node_free_ref(tt_global_entry->orig_node);
+
+	kfree(tt_global_entry);
+}
+
 static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 {
 	if (atomic_dec_and_test(&tt_global_entry->refcount))
-		kfree_rcu(tt_global_entry, rcu);
+		call_rcu(&tt_global_entry->rcu, tt_global_entry_free_rcu);
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
-- 
1.7.5.4

