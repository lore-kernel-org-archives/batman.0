Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:34:21 +0200
Message-Id: <1429288461-26260-6-git-send-email-sven@narfation.org>
In-Reply-To: <1429288461-26260-1-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 6/6] batman-adv: Use kernel variable
	declaration order in batadv_send_skb_unicast
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

The patches currently in the kernel for Linux 4.1 have a different variable
order in batadv_send_skb_unicast than the out-of-tree module. Fix the
order in the out-of-tree module because it is easier to get merged.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send.c b/send.c
index d27161e..3d64ed2 100644
--- a/send.c
+++ b/send.c
@@ -255,8 +255,8 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *orig_node,
 			    unsigned short vid)
 {
-	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr;
+	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 
 	if (!orig_node)
-- 
2.1.4

