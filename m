Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 31 Jul 2012 17:19:15 +0200
Message-Id: <1343747955-5657-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1343602203-11584-1-git-send-email-ordex@autistici.org>
References: <1343602203-11584-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use check_unicast_packet() in
	recv_roam_adv()
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

To avoid code duplication and to simplify further changes,
check_unicast_packet() is now used in recv_roam_adv() to check for not
well formed packets and so discard them.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2
- coment rearrangement
v3
- fixed sizeof argument (use the variable name instead of the type, if possible)

 routing.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/routing.c b/routing.c
index 939fc01..e7a4e25 100644
--- a/routing.c
+++ b/routing.c
@@ -687,21 +687,8 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_roam_adv_packet *roam_adv_packet;
 	struct batadv_orig_node *orig_node;
-	struct ethhdr *ethhdr;
-
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb,
-				    sizeof(struct batadv_roam_adv_packet))))
-		goto out;
-
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		goto out;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	if (batadv_check_unicast_packet(skb, sizeof(*roam_adv_packet)) < 0)
 		goto out;
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_RX);
-- 
1.7.9.4

