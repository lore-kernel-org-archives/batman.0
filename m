Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Feb 2011 00:21:43 +0100
Message-Id: <1297466503-13246-5-git-send-email-sven@narfation.org>
In-Reply-To: <1297466503-13246-1-git-send-email-sven@narfation.org>
References: <1297466503-13246-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Disallow originator
	addressing within mesh layer
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

For a host in the mesh network, the batman layer should be transparent.
However, we had one exception, data packets within the mesh network
which have the same destination as a originator are being routed to
that node, although there is no host that node's bat0 interface and
therefore gets dropped anyway. This commit removes this exception.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/unicast.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 6c92eef..1b5e761 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -281,7 +281,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct unicast_packet *unicast_packet;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct batman_if *batman_if;
 	struct neigh_node *router;
 	int data_len = skb->len;
@@ -292,11 +292,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest))
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
-	else
-		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-							   compare_orig,
-							   choose_orig,
-							   ethhdr->h_dest));
 
 	/* check for hna host */
 	if (!orig_node)
-- 
1.7.2.3

