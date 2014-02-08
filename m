Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat,  8 Feb 2014 23:28:18 +0800
Message-Id: <1391873298-3639-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: call unregister_netdev() to have
	it handle the locking for us
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 soft-interface.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index db3e467..633e9d6 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -652,10 +652,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 	}
 
 	batadv_sysfs_del_meshif(soft_iface);
-
-	rtnl_lock();
-	unregister_netdevice(soft_iface);
-	rtnl_unlock();
+	unregister_netdev(soft_iface);
 }
 
 /**
-- 
1.8.5.3

