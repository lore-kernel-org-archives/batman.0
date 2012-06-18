Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:10 +0200
Message-Id: <1340051963-14836-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/19] batman-adv: avoid characters requiring
	shell escapes in protocol names
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c |    2 +-
 net/batman-adv/main.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 99ec218..e94ac0b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1241,7 +1241,7 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 }
 
 static struct bat_algo_ops batman_iv __read_mostly = {
-	.name = "BATMAN IV",
+	.name = "BATMAN_IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_iface_disable = bat_iv_ogm_iface_disable,
 	.bat_iface_update_mac = bat_iv_ogm_iface_update_mac,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index bd83aa4..65b4f08 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -40,7 +40,7 @@
  * list traversals just rcu-locked */
 struct list_head hardif_list;
 static int (*recv_packet_handler[256])(struct sk_buff *, struct hard_iface *);
-char bat_routing_algo[20] = "BATMAN IV";
+char bat_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head bat_algo_list;
 
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-- 
1.7.9.4

