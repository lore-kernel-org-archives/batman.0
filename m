Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 13 Mar 2013 23:56:33 +0100
Message-Id: <1363215399-18875-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1363215399-18875-1-git-send-email-ordex@autistici.org>
References: <1363215399-18875-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: don't use !! in bool
	conversion
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

In C standard any expression different from 0 will be converted to
'true' when casting to bool (whatever is the length of the value).
Therefore all the "!!" conversions can be removed.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 net/batman-adv/unicast.c           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7e9e264..9322320 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -902,7 +902,7 @@ out_remove:
 	/* remove address from local hash if present */
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr,
 					     "global tt received",
-					     !!(flags & BATADV_TT_CLIENT_ROAM));
+					     flags & BATADV_TT_CLIENT_ROAM);
 	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
 
 	if (!(flags & BATADV_TT_CLIENT_ROAM))
@@ -2515,7 +2515,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_global_entry)
 		goto out;
 
-	ret = !!(tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM);
+	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_free_ref(tt_global_entry);
 out:
 	return ret;
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 50e079f..0bb3b59 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -122,7 +122,7 @@ batadv_frag_search_packet(struct list_head *head,
 {
 	struct batadv_frag_packet_list_entry *tfp;
 	struct batadv_unicast_frag_packet *tmp_up = NULL;
-	int is_head_tmp, is_head;
+	bool is_head_tmp, is_head;
 	uint16_t search_seqno;
 
 	if (up->flags & BATADV_UNI_FRAG_HEAD)
@@ -130,7 +130,7 @@ batadv_frag_search_packet(struct list_head *head,
 	else
 		search_seqno = ntohs(up->seqno)-1;
 
-	is_head = !!(up->flags & BATADV_UNI_FRAG_HEAD);
+	is_head = up->flags & BATADV_UNI_FRAG_HEAD;
 
 	list_for_each_entry(tfp, head, list) {
 		if (!tfp->skb)
@@ -142,7 +142,7 @@ batadv_frag_search_packet(struct list_head *head,
 		tmp_up = (struct batadv_unicast_frag_packet *)tfp->skb->data;
 
 		if (tfp->seqno == search_seqno) {
-			is_head_tmp = !!(tmp_up->flags & BATADV_UNI_FRAG_HEAD);
+			is_head_tmp = tmp_up->flags & BATADV_UNI_FRAG_HEAD;
 			if (is_head_tmp != is_head)
 				return tfp;
 			else
-- 
1.8.1.5

