Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 11:54:02 +0200
Message-Id: <1371203642-2224-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: (style) fix for switched
	vid-ifiindex parameter order
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

batadv_tt_local_add() first takes the vid and then the interface index
parameter. One of these calls had the order switched.

However in this case it is not a functional, but just a style fix
because at the moment BATADV_NO_FLAGS is equal to BATADV_NULL_IFINDEX.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index f2f1137..a7ad6cb 100644
--- a/main.c
+++ b/main.c
@@ -128,7 +128,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 		goto err;
 
 	batadv_tt_local_add(soft_iface, soft_iface->dev_addr,
-			    BATADV_NULL_IFINDEX, BATADV_NO_FLAGS);
+			    BATADV_NO_FLAGS, BATADV_NULL_IFINDEX);
 
 	ret = batadv_bla_init(bat_priv);
 	if (ret < 0)
-- 
1.7.10.4

