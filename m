Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:32 +0100
Message-Id: <1296337660-12376-6-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/13] batman-adv: Remove vis info element in
	free_info
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

The free_info function will be called when no reference to the info
object exists anymore. It must be ensured that the allocated memory
gets freed and not only the elements which are managed by the info
object.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/vis.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index 0be55be..988296c 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -64,6 +64,7 @@ static void free_info(struct kref *ref)
 
 	spin_unlock_bh(&bat_priv->vis_list_lock);
 	kfree_skb(info->skb_packet);
+	kfree(info);
 }
 
 /* Compare two vis packets, used by the hashing algorithm */
-- 
1.7.2.3

