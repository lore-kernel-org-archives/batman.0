Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 17 Aug 2013 13:04:46 +0200
Message-Id: <1376737486-1863-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1376737486-1863-1-git-send-email-ordex@autistici.org>
References: <1376737486-1863-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: check return type of unicast
	packet preparations
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Linus Lüssing <linus.luessing@web.de>

batadv_unicast(_4addr)_prepare_skb  might reallocate the skb's data.
And if it tries to do so then this can potentially fail.

We shouldn't continue working on this skb in such a case.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/unicast.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 688a041..857e1b8 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -432,12 +432,16 @@ find_router:
 
 	switch (packet_type) {
 	case BATADV_UNICAST:
-		batadv_unicast_prepare_skb(skb, orig_node);
+		if (!batadv_unicast_prepare_skb(skb, orig_node))
+			goto out;
+
 		header_len = sizeof(struct batadv_unicast_packet);
 		break;
 	case BATADV_UNICAST_4ADDR:
-		batadv_unicast_4addr_prepare_skb(bat_priv, skb, orig_node,
-						 packet_subtype);
+		if (!batadv_unicast_4addr_prepare_skb(bat_priv, skb, orig_node,
+						      packet_subtype))
+			goto out;
+
 		header_len = sizeof(struct batadv_unicast_4addr_packet);
 		break;
 	default:
-- 
1.8.1.5

