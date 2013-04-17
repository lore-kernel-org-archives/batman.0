Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed, 17 Apr 2013 12:28:50 +0200
Message-Id: <1366194530-9367-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid double freeing of
	bat_counters
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

On errors in batadv_mesh_init(), bat_counters will be freed in both
batadv_mesh_free() and batadv_softif_init_late(). This patch fixes this
by returning earlier from batadv_softif_init_late() in case of errors in
batadv_mesh_init().

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 soft-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index c2a9c20..4de4d0f 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -503,6 +503,9 @@ static int batadv_softif_init_late(struct net_device *dev)
 
 unreg_debugfs:
 	batadv_debugfs_del_meshif(dev);
+
+	return ret;
+
 free_bat_counters:
 	free_percpu(bat_priv->bat_counters);
 
-- 
1.8.2.1

