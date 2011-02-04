Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:35 +0100
Message-Id: <1296832896-30081-7-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: add __rcu annotations for
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

Add __rcu annotations for the rcu protected bat_priv::curr_gw pointer to
allow sparse checking.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 compat.h |    6 ++++++
 types.h  |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

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
index 4ae11c3..4dc5854 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -171,7 +171,7 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
-	struct gw_node *curr_gw;
+	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	struct vis_info *my_vis_info;
 };
 
-- 
1.7.2.3

