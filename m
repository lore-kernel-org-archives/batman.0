Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 08:49:51 +0200
Message-Id: <1340693391-16434-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1340693391-16434-1-git-send-email-ordex@autistici.org>
References: <20120625.161933.730861831753419928.davem@davemloft.net>
	<1340693391-16434-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2 net-next] batman-adv: fix global TT entry
	deletion
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

During the last merge involving translation-table.c something went wrong and two
lines disappeared from translation-table.c. This patch recovers them.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e4f27a8..c673b58 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -149,6 +149,8 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 static void
 batadv_tt_orig_list_entry_free_ref(struct tt_orig_list_entry *orig_entry)
 {
+	/* to avoid race conditions, immediately decrease the tt counter */
+	atomic_dec(&orig_entry->orig_node->tt_size);
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
-- 
1.7.9.4

