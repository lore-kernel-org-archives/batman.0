Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:43 +0100
Message-Id: <1392670129-2498-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: properly check
	pskb_may_pull return value
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

pskb_may_pull() returns 1 on success and 0 in case of failure,
therefore checking for the return value being negative does
not make sense at all.

This way if the function fails we will probably read beyond the current
skb data buffer. Fix this by doing the proper check.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1ed9f7c..c26f073 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -688,7 +688,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	int is_old_ttvn;
 
 	/* check if there is enough data before accessing it */
-	if (pskb_may_pull(skb, hdr_len + ETH_HLEN) < 0)
+	if (!pskb_may_pull(skb, hdr_len + ETH_HLEN))
 		return 0;
 
 	/* create a copy of the skb (in case of for re-routing) to modify it. */
-- 
1.8.5.3

