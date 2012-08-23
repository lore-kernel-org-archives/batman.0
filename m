Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 Aug 2012 15:10:10 +0200
Message-Id: <1345727427-20805-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1345727427-20805-1-git-send-email-ordex@autistici.org>
References: <1345727427-20805-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/18] batman-adv: move function arguments on
	one line
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 563cfbf..3f0dfa2 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -41,8 +41,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv);
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 static inline int batadv_bla_rx(struct batadv_priv *bat_priv,
-				struct sk_buff *skb, short vid,
-				bool is_bcast)
+				struct sk_buff *skb, short vid, bool is_bcast)
 {
 	return 0;
 }
-- 
1.7.9.4

