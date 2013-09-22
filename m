Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 20:02:22 +0200
Message-Id: <1379872942-2803-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: make gw_init() return void
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

gw_init does not return anything other than 0
(despite the kernel doc says something different..).
Change it to void and fix the kernel doc.

Introduced-by 0853ec7fafe0a195754454832993c6b35e22b842
("batman-adv: tvlv - gateway download/upload bandwidth container")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 gateway_common.c | 5 +----
 gateway_common.h | 2 +-
 main.c           | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/gateway_common.c b/gateway_common.c
index 07fd877..ab9a5ac 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -223,15 +223,12 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 /**
  * batadv_gw_init - initialise the gateway handling internals
  * @bat_priv: the bat priv with all the soft interface information
- *
- * Return 0 on success or negative error number in case of failure.
  */
-int batadv_gw_init(struct batadv_priv *bat_priv)
+void batadv_gw_init(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
 				     NULL, BATADV_TVLV_GW, 1,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
-	return 0;
 }
 
 /**
diff --git a/gateway_common.h b/gateway_common.h
index f18e8b7..368d50e 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -43,7 +43,7 @@ enum batadv_bandwidth_types {
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count);
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
-int batadv_gw_init(struct batadv_priv *bat_priv);
+void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/main.c b/main.c
index 5ee2abb..21c6a01 100644
--- a/main.c
+++ b/main.c
@@ -145,9 +145,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
-	ret = batadv_gw_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	batadv_gw_init(bat_priv);
 
 	atomic_set(&bat_priv->gw.reselect, 0);
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
-- 
1.8.1.5

