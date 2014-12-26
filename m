Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:22 +0100
Message-Id: <1419594103-10928-6-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 05/26] batman-adv: init,
	Add some error handling
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

This patch adds some error handling for the main init function. It
checks the return values of all the function calls that provide return
values.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/main.c b/main.c
index a9e09e852c4b..65021ea567e8 100644
--- a/main.c
+++ b/main.c
@@ -59,29 +59,47 @@ static void batadv_recv_handler_init(void);
 
 static int __init batadv_init(void)
 {
+	int ret;
+
 	INIT_LIST_HEAD(&batadv_hardif_list);
 	INIT_HLIST_HEAD(&batadv_algo_list);
 
 	batadv_recv_handler_init();
 
-	batadv_iv_init();
-	batadv_nc_init();
+	ret = batadv_iv_init();
+	if (ret)
+		return ret;
+
+	ret = batadv_nc_init();
+	if (ret)
+		return ret;
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
-
 	if (!batadv_event_workqueue)
 		return -ENOMEM;
 
 	batadv_socket_init();
 	batadv_debugfs_init();
 
-	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
+	ret = register_netdevice_notifier(&batadv_hard_if_notifier);
+	if (ret)
+		goto err_netdev_notifier;
+
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret)
+		goto err_link_register;
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
 
 	return 0;
+
+err_link_register:
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+err_netdev_notifier:
+	batadv_debugfs_destroy();
+
+	return ret;
 }
 
 static void __exit batadv_exit(void)
-- 
2.1.3

