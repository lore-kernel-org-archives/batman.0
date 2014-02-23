Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 24 Feb 2014 00:00:18 +0100
Message-Id: <1393196418-4001-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix merge resolution
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

While resolving a merge conflict a variable declaration was
accidentally moved onto another line.
Move it back to its original location to avoid messing up
with the in-kernel source code.

Introduced by merge commit
fbe649dfdd07d871f5b47b5e8ea1b03d104feb9d

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
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
1.8.4.5

