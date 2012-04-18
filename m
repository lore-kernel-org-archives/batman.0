Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 18 Apr 2012 17:15:57 +0800
Message-Id: <1334740557-7848-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid characters requiring shell
	escapes in protocol names
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

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |    2 +-
 main.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index ed743a4..19da9d5 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1233,7 +1233,7 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 }
 
 static struct bat_algo_ops batman_iv __read_mostly = {
-	.name = "BATMAN IV",
+	.name = "BATMAN_IV",
 	.bat_iface_enable = bat_iv_ogm_iface_enable,
 	.bat_iface_disable = bat_iv_ogm_iface_disable,
 	.bat_iface_update_mac = bat_iv_ogm_iface_update_mac,
diff --git a/main.c b/main.c
index 0757c2d..1d338a3 100644
--- a/main.c
+++ b/main.c
@@ -40,7 +40,7 @@
  * list traversals just rcu-locked */
 struct list_head hardif_list;
 static int (*recv_packet_handler[256])(struct sk_buff *, struct hard_iface *);
-char bat_routing_algo[20] = "BATMAN IV";
+char bat_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head bat_algo_list;
 
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-- 
1.7.9.1

