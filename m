Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 22 Mar 2018 00:21:32 +0100
Message-Id: <20180321232132.15176-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix packet loss for
 broadcasted DHCP packets to a server
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

DHCP connectivity issues can currently occur if the following conditions
are met:

1) A DHCP packet from a client to a server
2) This packet has a multicast destination
3) This destination has a matching entry in the translation table
   (FF:FF:FF:FF:FF:FF for IPv4, 33:33:00:01:00:02/33:33:00:01:00:03
    for IPv6)
4) The orig-node determined by TT for the multicast destination
   does not match the orig-node determined by best-gateway-selection

In this case the DHCP packet will be dropped.

The "gateway-out-of-range" check is supposed to only be applied to
unicasted DHCP packets to a specific DHCP server.

In that case dropping the the unicasted frame forces the client to
retry via a broadcasted one, but now directed to the new best
gateway.

A DHCP packet with broadcast/multicast destination is already ensured to
always be delivered to the best gateway. Dropping a multicasted
DHCP packet here will only prevent completing DHCP as there is no
other fallback.

So far, it seems the unicast check was implicitly performed by
expecting the batadv_transtable_search() to return NULL for multicast
destinations. However, a multicast address could have always ended up in
the translation table and in fact is now common.

To fix this potential loss of a DHCP client-to-server packet to a
multicast address this patch adds an explicit multicast destination
check to reliably bail out of the gateway-out-of-range check for such
destinations.

The issue and fix were tested in the following three node setup:

- Line topology, A-B-C
- A: gateway client, DHCP client
- B: gateway server, hop-penalty increased: 30->60, DHCP server
- C: gateway server, code modifications to announce FF:FF:FF:FF:FF:FF

Without this patch, A would never transmit its DHCP Discover packet
due to an always "out-of-range" condition. With this patch,
a full DHCP handshake between A and B was possible again.

Fixes: afae4e42aae6 ("batman-adv: refactoring gateway handling code")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changes since v1:
- now really fixing orig_dst_node initialization

Changes since RFC:

- fixed an uninitialized variable error for orig_dst_node by
  initializing it to NULL
- Verified the issue and tested the fix in VMs, added the test
  setup description to the commit message
---
 net/batman-adv/gateway_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c294f6fd..8b198ee7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -746,7 +746,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *neigh_curr = NULL;
 	struct batadv_neigh_node *neigh_old = NULL;
-	struct batadv_orig_node *orig_dst_node;
+	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
@@ -757,6 +757,9 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 
 	vid = batadv_get_vid(skb, 0);
 
+	if (is_multicast_ether_addr(ethhdr->h_dest))
+		goto out;
+
 	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
 						 ethhdr->h_dest, vid);
 	if (!orig_dst_node)
-- 
2.11.0

