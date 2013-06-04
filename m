Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  4 Jun 2013 12:11:45 +0200
Message-Id: <1370340711-1399-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-1-git-send-email-ordex@autistici.org>
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 07/13] batman-adv: initialise sysfs folder
	in softif_create()
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Move the sysfs folder creation from the netdev event handler
to softif_create() so that it is created immediately after
netdev registration.

This change allows any other routine to create sysfs
subfolders and files during mesh initialisation.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 hard-interface.c |  5 ++---
 soft-interface.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index d564af2..1278a73 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -641,10 +641,9 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_priv *bat_priv;
 
-	if (batadv_softif_is_valid(net_dev) && event == NETDEV_REGISTER) {
-		batadv_sysfs_add_meshif(net_dev);
+	/* do not handle any event for any soft_iface */
+	if (batadv_softif_is_valid(net_dev))
 		return NOTIFY_DONE;
-	}
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && event == NETDEV_REGISTER)
diff --git a/soft-interface.c b/soft-interface.c
index 7b0d1aa..414b4b1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -720,6 +720,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 struct net_device *batadv_softif_create(const char *name)
 {
 	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
 	int ret;
 
 	soft_iface = alloc_netdev(sizeof(struct batadv_priv), name,
@@ -733,11 +734,20 @@ struct net_device *batadv_softif_create(const char *name)
 	if (ret < 0) {
 		pr_err("Unable to register the batman interface '%s': %i\n",
 		       name, ret);
-		free_netdev(soft_iface);
-		return NULL;
+		goto free_dev;
 	}
 
+	ret = batadv_sysfs_add_meshif(soft_iface);
+	if (ret < 0)
+		goto free_mesh;
+
 	return soft_iface;
+
+free_mesh:
+	batadv_mesh_free(soft_iface);
+free_dev:
+	free_netdev(soft_iface);
+	return NULL;
 }
 
 /**
-- 
1.8.1.5

