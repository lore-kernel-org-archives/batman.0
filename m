Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 11:04:52 +0200
Message-Id: <1366362292-22961-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1366362292-22961-1-git-send-email-ordex@autistici.org>
References: <1366362292-22961-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix global protection
	fault during soft_iface destruction
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

batadv_mesh_free() schedules some RCU callbacks which need the bat_priv struct
to do their jobs, while free_netdev(), which is called immediately after, is
destroying the private data.

Put an rcu_barrier() in the middle so that free_netdev() is invoked only after
all the callbacks returned.

This bug has been introduced by ab8f433dd39be94e8617cff2dfe9f7eca162eb15
("batman-adv: Move deinitialization of soft-interface to destructor")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/soft-interface.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 403b8c4..6f20d33 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -582,6 +582,13 @@ static void batadv_softif_free(struct net_device *dev)
 {
 	batadv_debugfs_del_meshif(dev);
 	batadv_mesh_free(dev);
+
+	/* some scheduled RCU callbacks need the bat_priv struct to accomplish
+	 * their tasks. Wait for them all to be finished before freeing the
+	 * netdev and its private data (bat_priv)
+	 */
+	rcu_barrier();
+
 	free_netdev(dev);
 }
 
-- 
1.8.1.5

