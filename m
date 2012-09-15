Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 15 Sep 2012 14:34:21 +0200
Message-Id: <1347712461-9031-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: recompute mac_len at the
	beginning of the rx path
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
To: b.a.t.m.a.n@lists.open-mesh.org

It is possible that the mac_len is not properly exported because of strange
device configuration (this behaviour has been observed when using batman-adv on
top of a vlan interface). Therefore it is needed to explicitly recompute it at
the very beginning of the rx path

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/main.c b/main.c
index f9bcfa1..4ef39b6 100644
--- a/main.c
+++ b/main.c
@@ -245,6 +245,12 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
 
+	/* sometimes the mac_len value is not properly computed (e.g. when using
+	 * batman-adv on top of a vlan interface), therefore we need to
+	 * explicitly recompute it here
+	 */
+	skb_reset_mac_len(skb);
+
 	/* expect a valid ethernet header here. */
 	if (unlikely(skb->mac_len != ETH_HLEN || !skb_mac_header(skb)))
 		goto err_free;
-- 
1.7.12

