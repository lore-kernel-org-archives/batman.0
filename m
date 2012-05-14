Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 May 2012 09:17:35 +0200
Message-Id: <1336979858-13928-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1336979858-13928-1-git-send-email-ordex@autistici.org>
References: <1336979858-13928-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: use shorter pr_warn instead
	of pr_warning
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hard-interface.c |    6 +++---
 net/batman-adv/send.c           |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 0b84bb1..dc334fa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -173,9 +173,9 @@ static void check_known_mac_addr(const struct net_device *net_dev)
 				 net_dev->dev_addr))
 			continue;
 
-		pr_warning("The newly added mac address (%pM) already exists on: %s\n",
-			   net_dev->dev_addr, hard_iface->net_dev->name);
-		pr_warning("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
+		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
+			net_dev->dev_addr, hard_iface->net_dev->name);
+		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8e74d97..f47299f 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -45,8 +45,8 @@ int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 		goto send_skb_err;
 
 	if (!(hard_iface->net_dev->flags & IFF_UP)) {
-		pr_warning("Interface %s is not up - can't send packet via that interface!\n",
-			   hard_iface->net_dev->name);
+		pr_warn("Interface %s is not up - can't send packet via that interface!\n",
+			hard_iface->net_dev->name);
 		goto send_skb_err;
 	}
 
-- 
1.7.9.4

