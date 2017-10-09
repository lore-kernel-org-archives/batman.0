Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  9 Oct 2017 17:33:06 +0200
Message-Id: <20171009153307.29245-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Only query debugfs when netlink
 failed
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

It is enough to just request the data from netlink and skip debugfs when
netlink didn't return an error. The overwrite of the ret variable was only
for testing purposes and should no longer be used.

Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 8580f1b..78b92cd 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -308,7 +308,6 @@ struct hashtable_t *tg_hash_new(const char *mesh_iface)
 	ret = translate_mac_netlink(mesh_iface, tg_hash);
 	enable_net_admin_capability(0);
 
-	ret = -EOPNOTSUPP;
 	if (ret == -EOPNOTSUPP)
 		translate_mac_debugfs(mesh_iface, tg_hash);
 
@@ -477,7 +476,6 @@ struct hashtable_t *orig_hash_new(const char *mesh_iface)
 	ret = get_tq_netlink(mesh_iface, orig_hash);
 	enable_net_admin_capability(0);
 
-	ret = -EOPNOTSUPP;
 	if (ret == -EOPNOTSUPP)
 		get_tq_debugfs(mesh_iface, orig_hash);
 
-- 
2.11.0

