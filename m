Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 22 Jan 2011 23:03:17 +0100
Message-Id: <1295733797-1552-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: protect bit operations to count
	OGMs with spinlock
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Linus Lüssing <linus.luessing@saxnet.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/routing.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a90d105..fe3471a 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -539,18 +539,19 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	char is_duplicate = 0;
 	int32_t seq_diff;
 	int need_update = 0;
-	int set_mark;
+	int set_mark, ret = -1;
 
 	orig_node = get_orig_node(bat_priv, batman_packet->orig);
 	if (!orig_node)
 		return 0;
 
+	spin_lock_bh(&orig_node->ogm_cnt_lock);
 	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->batman_seqno_reset))
-		goto err;
+		goto out;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
@@ -583,12 +584,12 @@ static char count_real_packets(struct ethhdr *ethhdr,
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
 
-	kref_put(&orig_node->refcount, orig_node_free_ref);
-	return is_duplicate;
+	ret = is_duplicate;
 
-err:
+out:
+	spin_unlock_bh(&orig_node->ogm_cnt_lock);
 	kref_put(&orig_node->refcount, orig_node_free_ref);
-	return -1;
+	return ret;
 }
 
 void receive_bat_packet(struct ethhdr *ethhdr,
-- 
1.7.2.3

