Return-Path: <linus.luessing@ascom.CH>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.CH>
Date: Thu,  3 Feb 2011 15:43:20 +0100
Message-Id: <1296744201-11542-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
References: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: add __rcu annotations for
	gw_node
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.CH>

Add __rcu annotations for rcu protected pointers in the gateway code
to allow sparse checking.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 compat.h |    6 ++++++
 types.h  |    4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index a76d0be..4e89049 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -270,4 +270,10 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
+
+#define __rcu
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 30d10c0..2cb0c31 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -98,7 +98,7 @@ struct orig_node {
 
 struct gw_node {
 	struct hlist_node list;
-	struct orig_node *orig_node;
+	struct orig_node __rcu *orig_node;	/* rcu protected pointer */
 	unsigned long deleted;
 	atomic_t refcount;
 	struct rcu_head rcu;
@@ -172,7 +172,7 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
-	struct gw_node *curr_gw;
+	struct gw_node __rcu *curr_gw;	/* rcu protected pointer */
 	struct vis_info *my_vis_info;
 };
 
-- 
1.7.2.3

