Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 27 Jul 2013 03:24:45 +0200
Message-Id: <1374888285-20775-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix potential kernel
	paging error for unicast transmissions
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

batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
data. If it does then our ethhdr pointer is not valid anymore in
batadv_send_skb_unicast(), resulting in a kernel paging error.

This patch fixes this issue by storing the few bytes we are interested
in on the stack before modifying the skb.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 unicast.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unicast.c b/unicast.c
index 4c5a1aa..c636fd5 100644
--- a/unicast.c
+++ b/unicast.c
@@ -395,6 +395,7 @@ int batadv_unicast_generic_send_skb(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int packet_type,
 				    int packet_subtype)
 {
+	uint8_t dest[ETH_ALEN];
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_orig_node *orig_node;
@@ -426,6 +427,8 @@ find_router:
 	if (!neigh_node)
 		goto out;
 
+	memcpy(dest, ethhdr->h_dest, sizeof(dest));
+
 	switch (packet_type) {
 	case BATADV_UNICAST:
 		if (!batadv_unicast_prepare_skb(skb, orig_node))
@@ -450,7 +453,7 @@ find_router:
 	 * try to reroute it because the ttvn contained in the header is less
 	 * than the current one
 	 */
-	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+	if (batadv_tt_global_client_is_roaming(bat_priv, dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	dev_mtu = neigh_node->if_incoming->net_dev->mtu;
-- 
1.7.10.4

