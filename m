Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  9 Jul 2011 13:30:33 +0200
Message-Id: <1310211033-2951-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correct typ0 in routing.c
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Correct a very small typ0 in routing.c

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index 0f32c81..36b940c 100644
--- a/routing.c
+++ b/routing.c
@@ -93,7 +93,7 @@ static void update_transtable(struct bat_priv *bat_priv,
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
 
 		/* The ttvn alone is not enough to guarantee consistency
-		 * because a single value could repesent different states
+		 * because a single value could represent different states
 		 * (due to the wrap around). Thus a node has to check whether
 		 * the resulting table (after applying the changes) is still
 		 * consistent or not. E.g. a node could disconnect while its
-- 
1.7.3.4

