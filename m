Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:19 +0200
Message-Id: <1340876067-28333-11-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/18] batman-adv: Prefix sysfs defines with
	BATADV_
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

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_sysfs.c |   14 +++++++-------
 net/batman-adv/bat_sysfs.h |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bat_sysfs.c b/net/batman-adv/bat_sysfs.c
index 3862fe1..725e7d7 100644
--- a/net/batman-adv/bat_sysfs.c
+++ b/net/batman-adv/bat_sysfs.c
@@ -505,11 +505,11 @@ int batadv_sysfs_add_meshif(struct net_device *dev)
 	struct bat_attribute **bat_attr;
 	int err;
 
-	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
+	bat_priv->mesh_obj = kobject_create_and_add(BATADV_SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
 	if (!bat_priv->mesh_obj) {
 		batadv_err(dev, "Can't add sysfs directory: %s/%s\n", dev->name,
-			   SYSFS_IF_MESH_SUBDIR);
+			   BATADV_SYSFS_IF_MESH_SUBDIR);
 		goto out;
 	}
 
@@ -518,7 +518,7 @@ int batadv_sysfs_add_meshif(struct net_device *dev)
 					&((*bat_attr)->attr));
 		if (err) {
 			batadv_err(dev, "Can't add sysfs file: %s/%s/%s\n",
-				   dev->name, SYSFS_IF_MESH_SUBDIR,
+				   dev->name, BATADV_SYSFS_IF_MESH_SUBDIR,
 				   ((*bat_attr)->attr).name);
 			goto rem_attr;
 		}
@@ -673,12 +673,12 @@ int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 	struct bat_attribute **bat_attr;
 	int err;
 
-	*hardif_obj = kobject_create_and_add(SYSFS_IF_BAT_SUBDIR,
-						    hardif_kobject);
+	*hardif_obj = kobject_create_and_add(BATADV_SYSFS_IF_BAT_SUBDIR,
+					     hardif_kobject);
 
 	if (!*hardif_obj) {
 		batadv_err(dev, "Can't add sysfs directory: %s/%s\n", dev->name,
-			   SYSFS_IF_BAT_SUBDIR);
+			   BATADV_SYSFS_IF_BAT_SUBDIR);
 		goto out;
 	}
 
@@ -686,7 +686,7 @@ int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 		err = sysfs_create_file(*hardif_obj, &((*bat_attr)->attr));
 		if (err) {
 			batadv_err(dev, "Can't add sysfs file: %s/%s/%s\n",
-				   dev->name, SYSFS_IF_BAT_SUBDIR,
+				   dev->name, BATADV_SYSFS_IF_BAT_SUBDIR,
 				   ((*bat_attr)->attr).name);
 			goto rem_attr;
 		}
diff --git a/net/batman-adv/bat_sysfs.h b/net/batman-adv/bat_sysfs.h
index 3672277..23a8390 100644
--- a/net/batman-adv/bat_sysfs.h
+++ b/net/batman-adv/bat_sysfs.h
@@ -20,8 +20,8 @@
 #ifndef _NET_BATMAN_ADV_SYSFS_H_
 #define _NET_BATMAN_ADV_SYSFS_H_
 
-#define SYSFS_IF_MESH_SUBDIR "mesh"
-#define SYSFS_IF_BAT_SUBDIR "batman_adv"
+#define BATADV_SYSFS_IF_MESH_SUBDIR "mesh"
+#define BATADV_SYSFS_IF_BAT_SUBDIR "batman_adv"
 
 struct bat_attribute {
 	struct attribute attr;
-- 
1.7.9.4

