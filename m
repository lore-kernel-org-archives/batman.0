Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 17 Sep 2010 00:00:09 +0200
Message-Id: <1284674410-15477-5-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100916235908.51ab3bfc@rechenknecht>
References: <20100916235908.51ab3bfc@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: fragment forwarded packets
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

If a packet is too big to be forwarded over an interface it will be
fragmented on-the-fly (if fragmentation is enabled).

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/routing.c |    6 ++++++
 batman-adv/unicast.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 5d17597..c763121 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1179,6 +1179,12 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
+	if (unicast_packet->packet_type == BAT_UNICAST &&
+	    atomic_read(&bat_priv->frag_enabled) &&
+	    skb->len > batman_if->net_dev->mtu)
+		return frag_send_skb(skb, bat_priv, batman_if,
+				     dstaddr);
+
 	/* decrement ttl */
 	unicast_packet->ttl--;
 
diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 5908b01..e32b786 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
@@ -29,5 +29,7 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
+int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+		  struct batman_if *batman_if, uint8_t dstaddr[]);
 
 #endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.0.4

