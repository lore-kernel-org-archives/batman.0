Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Apr 2012 09:45:42 +0200
Message-Id: <1334648742-29698-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] net: cleanup unsigned to unsigned int
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

From: Eric Dumazet <eric.dumazet@gmail.com>

Use of "unsigned int" is preferred to bare "unsigned" in net tree.

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This one is already in net-next. Please add it to our own next branch.

 bat_sysfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index c6efd68..2c81688 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -149,7 +149,7 @@ static int store_bool_attr(char *buff, size_t count,
 		 atomic_read(attr) == 1 ? "enabled" : "disabled",
 		 enabled == 1 ? "enabled" : "disabled");
 
-	atomic_set(attr, (unsigned)enabled);
+	atomic_set(attr, (unsigned int)enabled);
 	return count;
 }
 
@@ -268,7 +268,7 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 		 "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
 		 "client" : "server");
 
-	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
+	atomic_set(&bat_priv->vis_mode, (unsigned int)vis_mode_tmp);
 	return count;
 }
 
@@ -354,7 +354,7 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 		 curr_gw_mode_str, buff);
 
 	gw_deselect(bat_priv);
-	atomic_set(&bat_priv->gw_mode, (unsigned)gw_mode_tmp);
+	atomic_set(&bat_priv->gw_mode, (unsigned int)gw_mode_tmp);
 	return count;
 }
 
-- 
1.7.9.5

