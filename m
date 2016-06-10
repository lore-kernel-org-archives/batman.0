Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 23:00:55 +0200
Message-Id: <1465592459-9474-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 1/5] batman-adv: Define module rtnl link
	name
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

The batman-adv module can automatically be loaded when operations over the
rtnl link are triggered. This requires only the correct rtnl link name in
the module header.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v4:
 - rebase on top of current master
v3:
 - rebased on top of current master to fix conflicts with newest patches
v2:
 - rebased on top of current master to fix conflicts with newest patches
---
 net/batman-adv/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index fe4c5e2..f61479b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -638,3 +638,4 @@ MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
 MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
 MODULE_VERSION(BATADV_SOURCE_VERSION);
+MODULE_ALIAS_RTNL_LINK("batadv");
-- 
2.8.1

