Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 12:00:10 +0200
Message-Id: <1334743210-12338-14-git-send-email-ordex@autistici.org>
In-Reply-To: <1334743210-12338-1-git-send-email-ordex@autistici.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/13] batman-adv: skip the window protection
	test when the originator has no neighbours
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

When we receive an OGM from from a node for the first time, the last_real_seqno
field of the orig_node structure has not been initialised yet. The value of this
field is used to compute the current ogm-seqno window and therefore the
protection mechanism will probably drop the packet due to an out-of-window error.
To avoid this situation this patch adds a check to skip the window protection
mechanism if no neighbour nodes have already been added. When the first
neighbour node is added, the last_real_seqno field is initialised too.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 1014210..8b2db2e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -861,7 +861,8 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	seq_diff = batman_ogm_packet->seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
-	if (window_protected(bat_priv, seq_diff,
+	if (!hlist_empty(&orig_node->neigh_list) &&
+	    window_protected(bat_priv, seq_diff,
 			     &orig_node->batman_seqno_reset))
 		goto out;
 
-- 
1.7.9.4

