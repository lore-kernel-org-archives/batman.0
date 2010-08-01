Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  1 Aug 2010 22:36:18 +0200
Message-Id: <1280694978-28232-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Keep function
	unicast_send_frag_skb local
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/unicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 64505f7..f6f5d34 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -149,7 +149,7 @@ void frag_list_free(struct list_head *head)
 	return;
 }
 
-int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			  struct batman_if *batman_if, uint8_t dstaddr[],
 			  struct orig_node *orig_node)
 {
-- 
1.7.1

