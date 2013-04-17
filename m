Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed, 17 Apr 2013 14:36:46 +0200
Message-Id: <1366202206-32718-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <20130417120550.GD20819@ritirata.org>
References: <20130417120550.GD20819@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Avoid double freeing of
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
v2:
  Removed label as suggested by Antonio

 soft-interface.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index c2a9c20..44089b3 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -497,12 +497,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 
 	ret = batadv_mesh_init(dev);
 	if (ret < 0)
-		goto unreg_debugfs;
+		batadv_debugfs_del_meshif(dev);
 
-	return 0;
+	return ret;
 
-unreg_debugfs:
-	batadv_debugfs_del_meshif(dev);
 free_bat_counters:
 	free_percpu(bat_priv->bat_counters);
 
-- 
1.8.2.1

