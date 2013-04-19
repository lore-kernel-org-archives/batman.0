Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 10:56:25 +0200
Message-Id: <1366361785-7561-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove useless newline
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
Cc: Antonio Quartulli <ordex@autistici.org>

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 network-coding.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 4eb49fc..f7c5430 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1504,8 +1504,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
  * in case of an error.
  */
 static struct batadv_unicast_packet *
-batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv,
-			    struct sk_buff *skb,
+batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			    struct batadv_nc_packet *nc_packet)
 {
 	const int h_size = sizeof(struct batadv_unicast_packet);
-- 
1.8.1.5

