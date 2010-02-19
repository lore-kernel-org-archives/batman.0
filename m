Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:11 +0100
Message-Id: <1266592691-13090-8-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-7-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
	<1266592691-13090-2-git-send-email-andrew@lunn.ch>
	<1266592691-13090-3-git-send-email-andrew@lunn.ch>
	<1266592691-13090-4-git-send-email-andrew@lunn.ch>
	<1266592691-13090-5-git-send-email-andrew@lunn.ch>
	<1266592691-13090-6-git-send-email-andrew@lunn.ch>
	<1266592691-13090-7-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] Staging: batman-adv: fix module
	initialization
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
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Make sure that batman-adv does not process packets before its
initialization is complete. Some sanity checks added to the receiver
function.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/hard-interface.c |    7 +++++++
 drivers/staging/batman-adv/proc.c           |   17 ++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 0f94158..befd488 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -432,6 +432,9 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_out;
 
+	if (atomic_read(&module_state) != MODULE_ACTIVE)
+		goto err_free;
+
 	/* packet should hold at least type and version */
 	if (unlikely(skb_headlen(skb) < 2))
 		goto err_free;
@@ -445,6 +448,10 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!batman_if)
 		goto err_free;
 
+	/* discard frames on not active interfaces */
+	if (batman_if->if_active != IF_ACTIVE)
+		goto err_free;
+
 	stats = (struct net_device_stats *)dev_get_stats(skb->dev);
 	if (stats) {
 		stats->rx_packets++;
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index 0eadc6b..7de60e8 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -63,7 +63,7 @@ static ssize_t proc_interfaces_write(struct file *instance,
 				     size_t count, loff_t *data)
 {
 	char *if_string, *colon_ptr = NULL, *cr_ptr = NULL;
-	int not_copied = 0, if_num = 0;
+	int not_copied = 0, if_num = 0, add_success;
 	struct batman_if *batman_if = NULL;
 
 	if_string = kmalloc(count, GFP_KERNEL);
@@ -109,22 +109,17 @@ static ssize_t proc_interfaces_write(struct file *instance,
 	}
 	rcu_read_unlock();
 
-	hardif_add_interface(if_string, if_num);
+	add_success = hardif_add_interface(if_string, if_num);
+	if (add_success < 0)
+		goto end;
+
+	num_ifs = if_num + 1;
 
 	if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
 	    (hardif_get_active_if_num() > 0))
 		activate_module();
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-		goto end;
-	}
-	rcu_read_unlock();
-
-	num_ifs = if_num + 1;
 	return count;
-
 end:
 	kfree(if_string);
 	return count;
-- 
1.6.6.2

