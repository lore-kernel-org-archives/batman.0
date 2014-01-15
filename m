Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 15 Jan 2014 23:54:44 +0100
Message-Id: <1389826484-7075-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use eth_hdr() instead of
	skb->data in interface_tx path
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

Using eth_hdr() instead of skb->data avoids some ugly type casts.

I wasn't able to reproduce the skb ether header pointer mismatch
mentioned in batadv_bla_tx() on a 3.11 kernel with a vlan on top of
bat0 and therefore removed the according skb_reset_mac_header()
call, too. Nevertheless I've added a check to the beginning of
batadv_interface_tx() as I guess there might potentially be some device
drivers not being that nice.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bridge_loop_avoidance.c |    3 ---
 soft-interface.c        |   12 +++++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 5c0eda4..26ec489 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1535,9 +1535,6 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		goto allow;
 
-	/* in VLAN case, the mac header might not be set. */
-	skb_reset_mac_header(skb);
-
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
 		goto handled;
 
diff --git a/soft-interface.c b/soft-interface.c
index f82c267..8af69b9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -176,7 +176,13 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
-	ethhdr = (struct ethhdr *)skb->data;
+
+	if (skb->data != eth_hdr(skb)) {
+		pr_warn("Upper device did not set the ethernet header pointer correctly - adjusting\n");
+		skb_reset_mac_header(skb);
+	}
+
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
@@ -194,7 +200,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* skb->data might have been reallocated by batadv_bla_tx() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
@@ -230,7 +236,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		/* skb->data may have been modified by
 		 * batadv_gw_dhcp_recipient_get()
 		 */
-		ethhdr = (struct ethhdr *)skb->data;
+		ethhdr = eth_hdr(skb);
 		/* if gw_mode is on, broadcast any non-DHCP message.
 		 * All the DHCP packets are going to be sent as unicast
 		 */
-- 
1.7.10.4

