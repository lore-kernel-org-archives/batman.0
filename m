Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 21 May 2013 21:53:55 +0200
Message-Id: <1369166035-585-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1369166035-585-1-git-send-email-ordex@autistici.org>
References: <pull request for net: batman-adv 2013-05-21>
 <1369166035-585-1-git-send-email-ordex@autistici.org>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Martin Hundebøll <martin@hundeboll.net>

On errors in batadv_mesh_init(), bat_counters will be freed in both
batadv_mesh_free() and batadv_softif_init_late(). This patch fixes this
by returning earlier from batadv_softif_init_late() in case of errors in
batadv_mesh_init() and by setting bat_counters to NULL after freeing.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.c           | 1 +
 net/batman-adv/soft-interface.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1240f07..51aafd6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -181,6 +181,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_originator_free(bat_priv);
 
 	free_percpu(bat_priv->bat_counters);
+	bat_priv->bat_counters = NULL;
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6f20d33..819dfb0 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -505,6 +505,7 @@ unreg_debugfs:
 	batadv_debugfs_del_meshif(dev);
 free_bat_counters:
 	free_percpu(bat_priv->bat_counters);
+	bat_priv->bat_counters = NULL;
 
 	return ret;
 }
-- 
1.8.1.5

