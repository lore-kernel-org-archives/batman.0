Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 19 Jan 2014 00:16:06 +0100
Message-Id: <1390086967-6047-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390086967-6047-1-git-send-email-linus.luessing@web.de>
References: <1390086967-6047-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: use eth_hdr() instead of
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

Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
the skb ether header pointer set correctly since the following commit
present in kernels >= 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Therefore we can safely use eth_hdr() instead of skb->data now, which
spares us some ugly type casts.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h         |   11 +++++++++++
 soft-interface.c |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 57c9d96..9692ed2 100644
--- a/compat.h
+++ b/compat.h
@@ -302,6 +302,17 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
 }\
 static int __batadv_interface_set_mac_addr(x, y)
 
+#define batadv_interface_tx(x, y) \
+__batadv_interface_tx(struct sk_buff *skb, struct net_device *soft_iface); \
+static int batadv_interface_tx(struct sk_buff *skb, \
+			       struct net_device *soft_iface) \
+{ \
+	skb_reset_mac_header(skb); \
+	return __batadv_interface_tx(skb, soft_iface); \
+} \
+static int __batadv_interface_tx(struct sk_buff *skb, \
+				 struct net_device *soft_iface)
+
 #define netdev_master_upper_dev_link netdev_set_master
 #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
 #define netdev_master_upper_dev_get(dev) \
diff --git a/soft-interface.c b/soft-interface.c
index f82c267..66903a1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -176,7 +176,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
@@ -194,7 +194,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* skb->data might have been reallocated by batadv_bla_tx() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
@@ -230,7 +230,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
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

