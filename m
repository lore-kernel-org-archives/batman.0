Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  7 Dec 2011 18:02:50 +0800
Message-Id: <1323252170-13257-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: warn if added interface is part
	of a bridge
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---

Thanks to Sven we even have a 'nice' compat.h workaround. :)

 compat.h         |    1 +
 hard-interface.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/compat.h b/compat.h
index 964c066..dcd92d1 100644
--- a/compat.h
+++ b/compat.h
@@ -52,6 +52,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
 #define __rcu
+#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
diff --git a/hard-interface.c b/hard-interface.c
index d3e0e32..68b667c 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -281,6 +281,14 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
 		goto out;
 
+	/* hard-interface is part of a bridge */
+	if (hard_iface->net_dev->priv_flags & IFF_BRIDGE_PORT)
+		pr_err("You are about to enable batman-adv on '%s' which "
+		       "already is part of a bridge. Unless you know exactly "
+		       "what you are doing this is probably wrong and won't "
+		       "work the way you think it would.\n",
+		       hard_iface->net_dev->name);
+
 	soft_iface = dev_get_by_name(&init_net, iface_name);
 
 	if (!soft_iface) {
-- 
1.7.5.4

