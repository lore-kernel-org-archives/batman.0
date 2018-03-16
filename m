Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Fri, 16 Mar 2018 11:29:10 +0100
Message-Id: <3cc8fb9bb6b983a5b7972af2fd803041095d8c90.1521196151.git.mschiffer@universe-factory.net>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: fix header size check
 in batadv_dbg_arp()
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

Checking for 0 is insufficient: when an SKB without a batadv header, but
with a VLAN header is received, hdr_size will be 4, making the following
code interpret the Ethernet header as a batadv header.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 19b15de455ab..b7ca4a311b91 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -393,7 +393,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
 		   batadv_arp_hw_dst(skb, hdr_size), &ip_dst);
 
-	if (hdr_size == 0)
+	if (hdr_size < sizeof(struct batadv_unicast_packet))
 		return;
 
 	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
-- 
2.16.2

