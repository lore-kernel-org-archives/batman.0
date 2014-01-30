Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 30 Jan 2014 13:57:27 +0100
Message-Id: <1391086647-1732-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: remove useless assignment
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

Introduced by 41b38727749a94c1a65cf0f4be9bfe1cbaf0adeb
   ("batman-adv: fix potential kernel paging error for unicast transmissions")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send.c b/send.c
index 2035bd9..75be770 100644
--- a/send.c
+++ b/send.c
@@ -256,7 +256,7 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node,
 				   unsigned short vid)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct ethhdr *ethhdr;
 	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 
-- 
1.8.5.3

