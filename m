Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  8 Aug 2013 12:58:46 +0800
Message-Id: <1375937926-20506-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat compile error
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Introduced by e4ff5c153dab054a6cd1c4132f87bc5e77127456
("batman-adv: add sysfs framework for VLAN")

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 compat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat.c b/compat.c
index fcd5bec..68c2258 100644
--- a/compat.c
+++ b/compat.c
@@ -31,7 +31,7 @@ void batadv_free_rcu_orig_vlan(struct rcu_head *rcu)
 {
 	struct batadv_orig_node_vlan *vlan;
 
-	vlan = container_of(rcu, structbatadv_orig_node_vlan, rcu);
+	vlan = container_of(rcu, struct batadv_orig_node_vlan, rcu);
 
 	kfree(vlan);
 }
-- 
1.7.10.4

