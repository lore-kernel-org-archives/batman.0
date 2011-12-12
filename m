Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 12 Dec 2011 19:31:51 +0800
Message-Id: <1323689516-24427-8-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
References: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/11] batman-adv: remove extra negation in
	gw_out_of_range()
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Dan Carpenter <dan.carpenter@oracle.com>

From: Dan Carpenter <dan.carpenter@oracle.com>

There is a typo here where an extra '!' made the check to the opposite
of what was intended.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/gateway_client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 9373a14..24403a7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -695,7 +695,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 	}
 
 	neigh_old = find_router(bat_priv, orig_dst_node, NULL);
-	if (!!neigh_old)
+	if (!neigh_old)
 		goto out;
 
 	if (curr_tq_avg - neigh_old->tq_avg > GW_THRESHOLD)
-- 
1.7.5.4

