Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:05 +0100
Message-Id: <1266592691-13090-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] Staging: batman-adv: don't lock while
	sending packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: gregkh@suse.de
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

As in other parts of batman-adv, we should not lock while sending a packet but
keep the lock held for as short as possible. Additionally, we should check
whether the interface is active, otherwise batman_if->net_dev might not be
available ...

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Acked-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/device.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index a3e7429..451898c 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -25,6 +25,7 @@
 #include "send.h"
 #include "types.h"
 #include "hash.h"
+#include "hard-interface.h"
 
 static struct class *batman_class;
 
@@ -206,6 +207,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	struct icmp_packet icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
@@ -251,9 +253,15 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 		goto unlock;
 
 	batman_if = orig_node->batman_if;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 	if (!batman_if)
-		goto unlock;
+		goto dst_unreach;
+
+	if (batman_if->if_active != IF_ACTIVE)
+		goto dst_unreach;
 
 	memcpy(icmp_packet.orig,
 	       batman_if->net_dev->dev_addr,
@@ -261,9 +269,8 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 
 	send_raw_packet((unsigned char *)&icmp_packet,
 			sizeof(struct icmp_packet),
-			batman_if, orig_node->router->addr);
+			batman_if, dstaddr);
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	goto out;
 
 unlock:
-- 
1.6.6.2

