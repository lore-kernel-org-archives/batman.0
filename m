Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 21 Nov 2013 14:17:45 +0100
Message-Id: <1385039865-7570-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix debuginfo macro style issue
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Structure initialization within the macros should follow the general
coding style used in the kernel: put the initialization of the first
variable and the closing brace on a separate line.

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 debugfs.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index cd5d24a..92d9d83 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -322,14 +322,17 @@ static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 
 #define BATADV_DEBUGINFO(_name, _mode, _open)		\
 struct batadv_debuginfo batadv_debuginfo_##_name = {	\
-	.attr = { .name = __stringify(_name),		\
-		  .mode = _mode, },			\
-	.fops = { .owner = THIS_MODULE,			\
-		  .open = _open,			\
-		  .read	= seq_read,			\
-		  .llseek = seq_lseek,			\
-		  .release = single_release,		\
-		}					\
+	.attr = {					\
+		.name = __stringify(_name),		\
+		.mode = _mode,				\
+	},						\
+	.fops = {					\
+		.owner = THIS_MODULE,			\
+		.open = _open,				\
+		.read	= seq_read,			\
+		.llseek = seq_lseek,			\
+		.release = single_release,		\
+	},						\
 };
 
 /* the following attributes are general and therefore they will be directly
-- 
1.7.10.4

