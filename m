Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 May 2013 14:37:10 +0800
Message-Id: <1369895830-8588-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete variable
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Introduced by 1ab746a3f2441d3466592b86134fbc72a9fe0558
("batman-adv: properly align tvlv infrastructure")

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 main.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 1192e61..5d30fe0 100644
--- a/main.c
+++ b/main.c
@@ -1043,7 +1043,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 	struct batadv_orig_node *orig_node;
 	struct sk_buff *skb = NULL;
 	unsigned char *tvlv_buff;
-	unsigned int tvlv_len, tvlv_long_hdr = 0;
+	unsigned int tvlv_len;
 	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
 	bool ret = false;
 
@@ -1051,9 +1051,6 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 	if (!orig_node)
 		goto out;
 
-	if (tvlv_value_len > 255)
-		tvlv_long_hdr = 1;
-
 	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
 
 	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + hdr_len + tvlv_len);
-- 
1.7.10.4

