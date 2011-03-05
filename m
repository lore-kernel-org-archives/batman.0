Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:32 +0100
Message-Id: <1299328122-21468-19-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 18/28] batman-adv: Increase orig_node
	refcount before releasing rcu read lock
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

When unicast_send_skb() is increasing the orig_node's refcount another
thread might have been freeing this orig_node already. We need to
increase the refcount in the rcu read lock protected area to avoid that.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/gateway_client.c |    3 +++
 net/batman-adv/unicast.c        |    5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a3e842f..41eba8a 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -54,6 +54,9 @@ void *gw_get_selected(struct bat_priv *bat_priv)
 
 	orig_node = curr_gateway_tmp->orig_node;
 
+	if (orig_node)
+		kref_get(&orig_node->refcount);
+
 out:
 	rcu_read_unlock();
 	return orig_node;
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 7ca994c..0603cea 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -293,10 +293,9 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest))
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
-		if (orig_node) {
-			kref_get(&orig_node->refcount);
+		if (orig_node)
 			goto find_router;
 	}
 
-- 
1.7.2.3

