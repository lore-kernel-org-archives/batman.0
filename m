Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 30 Jan 2014 00:12:24 +0100
Message-Id: <1391037144-2448-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: properly check
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

pskb_may_pull() returns 1 on success and 0 in case of failure,
therefore checking for the return value being negative does
not make sense at all.

Fix this by doing the proper check.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/routing.c b/routing.c
index f28920f..f7579d0 100644
--- a/routing.c
+++ b/routing.c
@@ -833,7 +833,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	int is_old_ttvn;
 
 	/* check if there is enough data before accessing it */
-	if (pskb_may_pull(skb, hdr_len + ETH_HLEN) < 0)
+	if (!pskb_may_pull(skb, hdr_len + ETH_HLEN))
 		return 0;
 
 	/* create a copy of the skb (in case of for re-routing) to modify it. */
-- 
1.8.5.3

