Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 26 Aug 2012 23:25:59 +0200
Message-Id: <1346016359-27041-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: check for more space before
	accessing the skb
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

In batadv_check_unicast_ttvn() the code accesses both the unicast header and the
Ethernet header in the payload. For this reason pskb_may_pull() must be invoked
to check for the required space.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index 784e9cc..44109cc 100644
--- a/routing.c
+++ b/routing.c
@@ -908,8 +908,12 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	bool tt_poss_change;
 	int is_old_ttvn;
 
-	/* I could need to modify it */
-	if (skb_cow(skb, sizeof(struct batadv_unicast_packet)) < 0)
+	/* check if there is enough data before accessing it */
+	if (pskb_may_pull(skb, sizeof(*unicast_packet) + ETH_HLEN) < 0)
+		return 0;
+
+	/* create a copy of the skb (in case of for re-routing) to modify it. */
+	if (skb_cow(skb, sizeof(*unicast_packet)) < 0)
 		return 0;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-- 
1.7.12

