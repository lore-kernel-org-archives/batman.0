Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 22 Jan 2017 21:40:41 +0100
Message-Id: <20170122204043.29668-2-linus.luessing@c0d3.blue>
In-Reply-To: <20170122204043.29668-1-linus.luessing@c0d3.blue>
References: <20170122204043.29668-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: compat: fix warning in
	hard-interface.c for < 4.0
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

This fixes the following warning:

hard-interface.c:104:39: warning: incorrect type in return expression (different base types)
hard-interface.c:104:39:    expected struct net *
hard-interface.c:104:39:    got bool

Which allows compiling with -Werror again on kernels < 4.0.

Fixes: bea804dbde21 ("batman-adv: Handle parent interfaces in a different netns")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 8e23911..8628cf5 100644
--- a/compat.h
+++ b/compat.h
@@ -153,8 +153,8 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
-/* WARNING for batadv_getlink_net */
-#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
+/* wild hack for batadv_getlink_net only */
+#define get_link_net get_xstats_size || 1 ? fallback_net : (struct net*)netdev->rtnl_link_ops->get_xstats_size
 
 #endif /* < KERNEL_VERSION(4, 0, 0) */
 
-- 
2.1.4

