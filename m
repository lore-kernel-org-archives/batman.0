Return-Path: <gfree.wind@foxmail.com>
From: gfree.wind@foxmail.com
Date: Tue, 25 Apr 2017 20:03:20 +0800
Message-Id: <1493121800-28066-1-git-send-email-gfree.wind@foxmail.com>
Subject: [B.A.T.M.A.N.] [PATCH net] net: batman-adv: Fix possible memleaks
	when fail to register_netdevice
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Cc: Gao Feng <fgao@ikuai8.com>

From: Gao Feng <fgao@ikuai8.com>

Because the func batadv_softif_init_late allocate some resources and
it would be invoked in register_netdevice. So we need to invoke the
func batadv_softif_free instead of free_netdev to cleanup when fail
to register_netdevice.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d042c99..90bf990 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1011,7 +1011,7 @@ struct net_device *batadv_softif_create(struct net *net, const char *name)
 	if (ret < 0) {
 		pr_err("Unable to register the batman interface '%s': %i\n",
 		       name, ret);
-		free_netdev(soft_iface);
+		batadv_softif_free(soft_iface);
 		return NULL;
 	}
 
-- 
1.9.1


