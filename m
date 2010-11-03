Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  3 Nov 2010 15:41:35 +0100
Message-Id: <1288795295-25392-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: suppress false warning when
	changing the mac address
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Whenever the mac address of an batman interface is changed
check_known_mac_addr() is called to print a warning if the newly added
mac address exists an another batman interface. While looping through
the batman interface list check_known_mac_addr() only compares mac
addresses and does not make sure they belong to different interfaces,
thus always printing a warning.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/hard-interface.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 37f0f8b..63a6b3e 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -175,7 +175,7 @@ static void update_mac_addresses(struct batman_if *batman_if)
 	       batman_if->net_dev->dev_addr, ETH_ALEN);
 }
 
-static void check_known_mac_addr(uint8_t *addr)
+static void check_known_mac_addr(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
 
@@ -185,11 +185,16 @@ static void check_known_mac_addr(uint8_t *addr)
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
@@ -439,7 +444,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	INIT_LIST_HEAD(&batman_if->list);
 	kref_init(&batman_if->refcount);
 
-	check_known_mac_addr(batman_if->net_dev->dev_addr);
+	check_known_mac_addr(batman_if->net_dev);
 
 	spin_lock(&if_list_lock);
 	list_add_tail_rcu(&batman_if->list, &if_list);
@@ -520,7 +525,7 @@ static int hard_if_event(struct notifier_block *this,
 		if (batman_if->if_status == IF_NOT_IN_USE)
 			goto hardif_put;
 
-		check_known_mac_addr(batman_if->net_dev->dev_addr);
+		check_known_mac_addr(batman_if->net_dev);
 		update_mac_addresses(batman_if);
 
 		bat_priv = netdev_priv(batman_if->soft_iface);
-- 
1.7.1

