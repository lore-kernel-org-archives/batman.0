Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:49 +0100
Message-Id: <1290383767-32602-12-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/29] Staging: batman-adv: fragment
	forwarded packets
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

From: Andreas Langer <an.langer@gmx.de>

If a packet is too big to be forwarded over an interface it will be
fragmented on-the-fly (if fragmentation is enabled).

Signed-off-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |    6 ++++++
 drivers/staging/batman-adv/unicast.c |    4 ++--
 drivers/staging/batman-adv/unicast.h |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 9b61d6b..1e10111 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1165,6 +1165,12 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
+	if (unicast_packet->packet_type == BAT_UNICAST &&
+	    atomic_read(&bat_priv->frag_enabled) &&
+	    skb->len > batman_if->net_dev->mtu)
+		return frag_send_skb(skb, bat_priv, batman_if,
+				     dstaddr);
+
 	/* decrement ttl */
 	unicast_packet->ttl--;
 
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 57fe2de..12afae6 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -206,8 +206,8 @@ out:
 	return ret;
 }
 
-static int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			 struct batman_if *batman_if, uint8_t dstaddr[])
+int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+		  struct batman_if *batman_if, uint8_t dstaddr[])
 {
 	struct unicast_packet tmp_uc, *unicast_packet;
 	struct sk_buff *frag_skb;
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
index 5908b01..e32b786 100644
--- a/drivers/staging/batman-adv/unicast.h
+++ b/drivers/staging/batman-adv/unicast.h
@@ -29,5 +29,7 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
+int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+		  struct batman_if *batman_if, uint8_t dstaddr[]);
 
 #endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.2.3

