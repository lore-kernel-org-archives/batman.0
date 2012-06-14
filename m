Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 14 Jun 2012 22:21:28 +0200
Message-Id: <1339705288-4175-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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

skb_linearize(skb) possibly rearranges the skb internal data and then changes
the skb->data pointer value. For this reason any other pointer in the code that
was assigned skb->data before invoking skb_linearise(skb) must be re-assigned.

In the current tt_query message handling code this is not done and therefore, in
case of skb linearization, the pointer used to handle the packet header ends up
in pointing to poisoned memory. The packet is then dropped but the
translation-table mechanism is corrupted.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

*** this patch is an important fix and it is for maint ***

 routing.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/routing.c b/routing.c
index be068f3..b79e42e 100644
--- a/routing.c
+++ b/routing.c
@@ -638,6 +638,8 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 			 */
 			if (skb_linearize(skb) < 0)
 				goto out;
+			/* skb_linearize() possibly changed skb->data */
+			tt_query = (struct batadv_tt_query_packet *)skb->data;
 
 			tt_size = batadv_tt_len(ntohs(tt_query->tt_data));
 
-- 
1.7.9.4

