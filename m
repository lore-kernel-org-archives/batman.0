Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Jan 2011 06:22:54 +0100
Message-Id: <1295500975-3884-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Mark bucket_free_orig_rcu as
	static
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/originator.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 35ab3ab..5a6745f 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -179,7 +179,7 @@ void originator_free(struct bat_priv *bat_priv)
 	hash_destroy(hash);
 }
 
-void bucket_free_orig_rcu(struct rcu_head *rcu)
+static void bucket_free_orig_rcu(struct rcu_head *rcu)
 {
 	struct element_t *bucket;
 	struct orig_node *orig_node;
-- 
1.7.2.3

