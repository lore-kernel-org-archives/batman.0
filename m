Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  4 Nov 2010 23:02:30 +0100
Message-Id: <1288908150-19744-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288908150-19744-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288908150-19744-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] Staging: batman-adv: suppress false
	warning when changing the mac address
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Whenever the mac address of an batman interface is changed
check_known_mac_addr() is called to print a warning if the newly added
mac address exists an another batman interface. While looping through
the batman interface list check_known_mac_addr() only compares mac
addresses and does not make sure they belong to different interfaces,
thus always printing a warning.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 80cfa86..b68a7e5 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -165,7 +165,7 @@ static void update_mac_addresses(struct batman_if *batman_if)
 	       batman_if->net_dev->dev_addr, ETH_ALEN);
 }
 
-static void check_known_mac_addr(uint8_t *addr)
+static void check_known_mac_addr(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
 
@@ -175,11 +175,16 @@ static void check_known_mac_addr(uint8_t *addr)
 		    (batman_if->if_status != IF_TO_BE_ACTIVATED))
 			continue;
 
-		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
+		if (batman_if->net_dev == net_dev)
+			continue;
+
+		if (!compare_orig(batman_if->net_dev->dev_addr,
+				  net_dev->dev_addr))
 			continue;
 
 		pr_warning("The newly added mac address (%pM) already exists "
-			   "on: %s\n", addr, batman_if->net_dev->name);
+			   "on: %s\n", net_dev->dev_addr,
+			   batman_if->net_dev->name);
 		pr_warning("It is strongly recommended to keep mac addresses "
 			   "unique to avoid problems!\n");
 	}
@@ -430,7 +435,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	atomic_set(&batman_if->refcnt, 0);
 	hardif_hold(batman_if);
 
-	check_known_mac_addr(batman_if->net_dev->dev_addr);
+	check_known_mac_addr(batman_if->net_dev);
 
 	spin_lock(&if_list_lock);
 	list_add_tail_rcu(&batman_if->list, &if_list);
@@ -515,7 +520,7 @@ static int hard_if_event(struct notifier_block *this,
 			goto out;
 		}
 
-		check_known_mac_addr(batman_if->net_dev->dev_addr);
+		check_known_mac_addr(batman_if->net_dev);
 		update_mac_addresses(batman_if);
 
 		bat_priv = netdev_priv(batman_if->soft_iface);
-- 
1.7.2.3

