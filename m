Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 20 Oct 2013 00:21:53 +0200
Message-Id: <1382221330-3769-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1382221330-3769-1-git-send-email-antonio@meshcoding.com>
References: <1382221330-3769-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/18] batman-adv: check skb preparation
	return value
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>

Fix bogus merge conflict resolution by checking the return
values of the skb preparation routines.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/send.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 82588e4..d765d53 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -267,11 +267,14 @@ int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 
 	switch (packet_type) {
 	case BATADV_UNICAST:
-		batadv_send_skb_prepare_unicast(skb, orig_node);
+		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
+			goto out;
 		break;
 	case BATADV_UNICAST_4ADDR:
-		batadv_send_skb_prepare_unicast_4addr(bat_priv, skb, orig_node,
-						      packet_subtype);
+		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
+							   orig_node,
+							   packet_subtype))
+			goto out;
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
-- 
1.8.4

