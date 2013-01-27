Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 27 Jan 2013 20:43:57 +0100
Message-Id: <1359315839-24136-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1359315839-24136-1-git-send-email-ordex@autistici.org>
References: <1359315839-24136-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix skb leak in
	batadv_dat_snoop_incoming_arp_reply()
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

The callers of batadv_dat_snoop_incoming_arp_reply() assume the skb has been
freed when it returns true; fix this by calling kfree_skb before returning as
it is done in batadv_dat_snoop_incoming_arp_request().

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/distributed-arp-table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 7485a78..9f4cff3 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1012,6 +1012,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	 */
 	ret = !batadv_is_my_client(bat_priv, hw_dst);
 out:
+	if (ret)
+		kfree_skb(skb);
 	/* if ret == false -> packet has to be delivered to the interface */
 	return ret;
 }
-- 
1.8.1.1

