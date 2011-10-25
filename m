Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 25 Oct 2011 22:42:42 +0200
Message-Id: <1319575362-20828-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1319575362-20828-1-git-send-email-ordex@autistici.org>
References: <1319575362-20828-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: correctly set the data field
	in the TT_REPONSE packet
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
To: stable@kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

In the TT_RESPONSE packet, the number of carried entries is not correctly set.
This leads to a wrong interpretation of the packet payload on the receiver side
causing random entries to be added to the global translation table. Therefore
the latter gets always corrupted, triggering a table recovery all the time.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---

David S. Miller already merged this patch as
9d8523931f7f5eb8900077f0da0fbe6b8ad0010b in his net-next tree


 net/batman-adv/translation-table.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f599db9..ef1acfd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -999,7 +999,6 @@ static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	tt_response = (struct tt_query_packet *)skb_put(skb,
 						     tt_query_size + tt_len);
 	tt_response->ttvn = ttvn;
-	tt_response->tt_data = htons(tt_tot);
 
 	tt_change = (struct tt_change *)(skb->data + tt_query_size);
 	tt_count = 0;
@@ -1025,6 +1024,10 @@ static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	}
 	rcu_read_unlock();
 
+	/* store in the message the number of entries we have successfully
+	 * copied */
+	tt_response->tt_data = htons(tt_count);
+
 out:
 	return skb;
 }
-- 
1.7.3.4

