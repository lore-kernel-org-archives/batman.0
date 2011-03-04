Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  4 Mar 2011 02:13:16 +0100
Message-Id: <1299201196-6188-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: orig_node must be freed after in
	case of timeout
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

This patch corrects commit
4c4236064501e85915087f00a370df8d9f43028d in which
bucket_free_orig_rcu() has been removed but without
being replaced.
In _push_orig(), the orig_node was not freed anymore after
a timeout.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 originator.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/originator.c b/originator.c
index 53753d3..0b91330 100644
--- a/originator.c
+++ b/originator.c
@@ -349,6 +349,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 				if (orig_node->gw_flags)
 					gw_node_delete(bat_priv, orig_node);
 				hlist_del_rcu(node);
+				orig_node_free_ref(orig_node);
 				continue;
 			}
 
-- 
1.7.3.4

