Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:57:32 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718145732.GP4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup soft_interface.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make soft-interface.[ch] clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with debug_log and using
KERNEL_VERSION.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/soft-interface.c
===================================================================
--- batman-adv-kernelland/soft-interface.c	(revision 1351)
+++ batman-adv-kernelland/soft-interface.c	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
@@ -33,30 +29,23 @@
 #include <linux/etherdevice.h>
 #include "compat.h"
 
+static uint16_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
+				  * broadcast storms */
+static int32_t skb_packets;
+static int32_t skb_bad_packets;
+static int32_t lock_dropped;
 
-
-
-
-static uint16_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid broadcast storms */
-static int32_t skb_packets = 0;
-static int32_t skb_bad_packets = 0;
-static int32_t lock_dropped = 0;
-
-unsigned char mainIfAddr[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-static unsigned char mainIfAddr_default[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-
-
-
-
+unsigned char mainIfAddr[ETH_ALEN];
+static unsigned char mainIfAddr_default[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
-static void bat_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info);
+static void bat_get_drvinfo(struct net_device *dev,
+			    struct ethtool_drvinfo *info);
 static u32 bat_get_msglevel(struct net_device *dev);
 static void bat_set_msglevel(struct net_device *dev, u32 value);
 static u32 bat_get_link(struct net_device *dev);
 static u32 bat_get_rx_csum(struct net_device *dev);
 static int bat_set_rx_csum(struct net_device *dev, u32 data);
 
-
 static const struct ethtool_ops bat_ethtool_ops = {
 	.get_settings = bat_get_settings,
 	.get_drvinfo = bat_get_drvinfo,
@@ -67,7 +56,6 @@
 	.set_rx_csum = bat_set_rx_csum
 };
 
-
 void set_main_if_addr(uint8_t *addr)
 {
 	memcpy(mainIfAddr, addr, ETH_ALEN);
@@ -90,11 +78,7 @@
 		if (result < 0)
 			return result;
 	}
-	/* TODO: remove this later. it's just for verification. */
-	if ((skb_packets & 0xFF) == 0) /* report every 256 packets */
-		debug_log(LOG_TYPE_NOTICE, "(%d/%d skbs had to be re-expanded)\n", skb_bad_packets, skb_packets);
 
-
 	skb_push(skb, len);
 	return 0;
 }
@@ -132,7 +116,8 @@
 
 	dev->features |= NETIF_F_NO_CSUM;
 	dev->mtu = hardif_min_mtu();
-	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the skbuff for our header */
+	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
+						* skbuff for our header */
 
 	/* generate random address */
 	*(u16 *)dev_addr = __constant_htons(0x00FF);
@@ -207,7 +192,8 @@
 		/* batman packet type: broadcast */
 		bcast_packet->packet_type = BAT_BCAST;
 
-		/* hw address of first interface is the orig mac because only this mac is known throughout the mesh */
+		/* hw address of first interface is the orig mac because only
+		 * this mac is known throughout the mesh */
 		memcpy(bcast_packet->orig, mainIfAddr, ETH_ALEN);
 		/* set broadcast sequence number */
 		bcast_packet->seqno = htons(bcast_seqno);
@@ -220,8 +206,10 @@
 	/* unicast packet */
 	} else {
 
-		/* simply spin_lock()ing can deadlock when the lock is already hold. */
-		/* TODO: defer the work in a working queue instead of dropping */
+		/* simply spin_lock()ing can deadlock when the lock is already
+		 * hold. */
+		/* TODO: defer the work in a working queue instead of
+		 * dropping */
 		if (!spin_trylock(&orig_hash_lock)) {
 			lock_dropped++;
 			debug_log(LOG_TYPE_NOTICE, "%d packets dropped because lock was hold\n", lock_dropped);
@@ -229,14 +217,16 @@
 		}
 
 		/* get routing information */
-		orig_node = ((struct orig_node *)hash_find(orig_hash, ethhdr->h_dest));
+		orig_node = ((struct orig_node *)hash_find(orig_hash,
+							   ethhdr->h_dest));
 
 		/* check for hna host */
 		if (orig_node == NULL)
 			orig_node = transtable_search(ethhdr->h_dest);
 
-		if ((orig_node != NULL) && (orig_node->batman_if != NULL) && (orig_node->router != NULL)) {
-
+		if ((orig_node != NULL) &&
+		    (orig_node->batman_if != NULL) &&
+		    (orig_node->router != NULL)) {
 			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
 				goto unlock;
 
@@ -254,12 +244,12 @@
 			if (orig_node->batman_if->if_active != IF_ACTIVE)
 				goto unlock;
 
-			send_raw_packet(skb->data, skb->len, orig_node->batman_if->net_dev->dev_addr, orig_node->router->addr, orig_node->batman_if);
-
+			send_raw_packet(skb->data, skb->len,
+					orig_node->batman_if->net_dev->dev_addr,
+					orig_node->router->addr,
+					orig_node->batman_if);
 		} else {
-
 			goto unlock;
-
 		}
 
 		spin_unlock(&orig_hash_lock);
@@ -271,10 +261,8 @@
 
 unlock:
 	spin_unlock(&orig_hash_lock);
-
 dropped:
 	priv->stats.tx_dropped++;
-
 end:
 	kfree_skb(skb);
 	return 0;
@@ -327,7 +315,8 @@
 	return 0;
 }
 
-static void bat_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+static void bat_get_drvinfo(struct net_device *dev,
+			    struct ethtool_drvinfo *info)
 {
 	strcpy(info->driver, "B.A.T.M.A.N. advanced");
 	strcpy(info->version, SOURCE_VERSION);
@@ -359,4 +348,3 @@
 {
 	return -EOPNOTSUPP;
 }
-
Index: batman-adv-kernelland/soft-interface.h
===================================================================
--- batman-adv-kernelland/soft-interface.h	(revision 1351)
+++ batman-adv-kernelland/soft-interface.h	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 void set_main_if_addr(uint8_t *addr);
 int main_if_was_up(void);
 void interface_setup(struct net_device *dev);
