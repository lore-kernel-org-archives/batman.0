Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:10 +0100
Message-Id: <1266592691-13090-7-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-6-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
	<1266592691-13090-2-git-send-email-andrew@lunn.ch>
	<1266592691-13090-3-git-send-email-andrew@lunn.ch>
	<1266592691-13090-4-git-send-email-andrew@lunn.ch>
	<1266592691-13090-5-git-send-email-andrew@lunn.ch>
	<1266592691-13090-6-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] Staging: batman-adv: avoid crash on
	memory allocation error
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
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

skb_share_check() returns NULL if it can't allocate more memory but
it still frees the skbuff.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/hard-interface.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index f8b1ba3..0f94158 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -426,10 +426,11 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct net_device_stats *stats;
 	int ret;
 
-    skb = skb_share_check(skb, GFP_ATOMIC);
+	skb = skb_share_check(skb, GFP_ATOMIC);
 
-    if (skb == NULL)
-		goto err_free;
+	/* skb was released by skb_share_check() */
+	if (!skb)
+		goto err_out;
 
 	/* packet should hold at least type and version */
 	if (unlikely(skb_headlen(skb) < 2))
@@ -444,7 +445,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!batman_if)
 		goto err_free;
 
-    stats = (struct net_device_stats *) dev_get_stats(skb->dev);
+	stats = (struct net_device_stats *)dev_get_stats(skb->dev);
 	if (stats) {
 		stats->rx_packets++;
 		stats->rx_bytes += skb->len;
@@ -490,6 +491,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	default:
 		ret = NET_RX_DROP;
 	}
+
 	if (ret == NET_RX_DROP)
 		kfree_skb(skb);
 
@@ -500,9 +502,9 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	return NET_RX_SUCCESS;
 
 err_free:
-    kfree_skb(skb);
-    return NET_RX_DROP;
-
+	kfree_skb(skb);
+err_out:
+	return NET_RX_DROP;
 }
 
 
-- 
1.6.6.2

