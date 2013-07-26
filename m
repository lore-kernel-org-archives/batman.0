Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 26 Jul 2013 20:50:46 +0200
Message-Id: <1374864646-19268-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1374864646-19268-1-git-send-email-linus.luessing@web.de>
References: <1374864646-19268-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix potential kernel paging
	error for unicast transmissions
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
 send.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/send.c b/send.c
index 9c9cab6..b9a1f15 100644
--- a/send.c
+++ b/send.c
@@ -257,13 +257,15 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node,
 				   unsigned short vid)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	uint8_t dest[ETH_ALEN];
 	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 
 	if (!orig_node)
 		goto out;
 
+	memcpy(dest, ((struct ethhdr *)skb->data)->h_dest, sizeof(dest));
+
 	switch (packet_type) {
 	case BATADV_UNICAST:
 		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
@@ -289,7 +291,7 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	 * try to reroute it because the ttvn contained in the header is less
 	 * than the current one
 	 */
-	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
+	if (batadv_tt_global_client_is_roaming(bat_priv, dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
-- 
1.7.10.4

