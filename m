Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 10 Oct 2010 12:07:06 +0200
Message-Id: <1286705226-4203-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Keep line length to 80 chars
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

48628bb9419fb5b01a26ca995465d1aded1e47ed added a line over the limit of
80 chars. This should be avoided according to the kernel
Documentation/CodingStyle.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/soft-interface.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 22fe548..683ec5f 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -220,7 +220,8 @@ int softif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev, short vid)
+static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev,
+			       short vid)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-- 
1.7.2.3

