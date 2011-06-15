Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 15 Jun 2011 09:41:35 +0200
Message-Id: <1308123697-7893-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Fix line over 80 characters
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

This regression was introduced in
02585b0b59becfbf14749f08069862f120000bdf.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index 3a3cfb8..7ca4b42 100644
--- a/routing.c
+++ b/routing.c
@@ -1232,7 +1232,7 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
-		/* packet needs to be linearised to access the TT changes records */
+		/* packet needs to be linearised to access the TT changes */
 		if (skb_linearize(skb) < 0)
 			goto out;
 
-- 
1.7.5.3

