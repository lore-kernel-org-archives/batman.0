Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 18 May 2014 19:58:09 +0200
Message-Id: <1400435890-6667-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400435890-6667-1-git-send-email-antonio@meshcoding.com>
References: <1400435890-6667-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: remove semi-colon after
	macro definition
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

Reported by checkpatch with the following warning:
"WARNING: macros should not use a trailing semicolon"

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/debugfs.c | 4 ++--
 net/batman-adv/sysfs.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 99f2ba0..a12e25e 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -342,7 +342,7 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 		  .llseek = seq_lseek,			\
 		  .release = single_release,		\
 		}					\
-};
+}
 
 /* the following attributes are general and therefore they will be directly
  * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
@@ -404,7 +404,7 @@ struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
 		.llseek = seq_lseek,				\
 		.release = single_release,			\
 	},							\
-};
+}
 static BATADV_HARDIF_DEBUGINFO(originators, S_IRUGO,
 			       batadv_originators_hardif_open);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f51b484..fc47baa 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -108,7 +108,7 @@ struct batadv_attribute batadv_attr_vlan_##_name = {	\
 		 .mode = _mode },			\
 	.show   = _show,				\
 	.store  = _store,				\
-};
+}
 
 /* Use this, if you have customized show and store functions */
 #define BATADV_ATTR(_name, _mode, _show, _store)	\
@@ -117,7 +117,7 @@ struct batadv_attribute batadv_attr_##_name = {		\
 		 .mode = _mode },			\
 	.show   = _show,				\
 	.store  = _store,				\
-};
+}
 
 #define BATADV_ATTR_SIF_STORE_BOOL(_name, _post_func)			\
 ssize_t batadv_store_##_name(struct kobject *kobj,			\
-- 
1.8.5.5

