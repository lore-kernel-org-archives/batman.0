Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:44 +0200
Message-Id: <1273177132-8792-19-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 18/26] staging:batman-adv: fix whitespace
	style issues
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

This patch fixes unnecessary whitespaces before a quoted
newline that the remaining batman-adv files had.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/bat_sysfs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 1811c8d..e2c000b 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -75,7 +75,7 @@ static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
 
-	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
+	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1\n",
 		       aggr_status == 0 ? "disabled" : "enabled");
 }
 
@@ -123,7 +123,7 @@ static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
-	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d \n",
+	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d\n",
 		       vis_mode == VIS_TYPE_CLIENT_UPDATE ?
 							"client" : "server",
 		       VIS_TYPE_SERVER_SYNC, VIS_TYPE_CLIENT_UPDATE);
@@ -364,7 +364,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (!batman_if)
 		return 0;
 
-	return sprintf(buff, "status: %s\ncommands: none, bat0 \n",
+	return sprintf(buff, "status: %s\ncommands: none, bat0\n",
 		       batman_if->if_status == IF_NOT_IN_USE ?
 							"none" : "bat0");
 }
-- 
1.7.1

