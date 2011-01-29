Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:31 +0100
Message-Id: <1296337660-12376-5-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/13] batman-adv: Remove vis info on hashing
	errors
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

A newly created vis info object must be removed when it couldn't be
added to the hash. The old_info which has to be replaced was already
removed and isn't related to the hash anymore.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/vis.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index f69a374..0be55be 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -444,7 +444,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 			      info);
 	if (hash_added < 0) {
 		/* did not work (for some reason) */
-		kref_put(&old_info->refcount, free_info);
+		kref_put(&info->refcount, free_info);
 		info = NULL;
 	}
 
-- 
1.7.2.3

