Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  4 May 2016 06:23:47 +0800
Message-Id: <1462314230-16257-13-git-send-email-a@unstable.cc>
In-Reply-To: <1462314230-16257-1-git-send-email-a@unstable.cc>
References: <1462314230-16257-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 12/15] batman-adv: fix debuginfo macro style
	issue
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Simon Wunderlich <simon.wunderlich@open-mesh.com>

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

Structure initialization within the macros should follow the general
coding style used in the kernel: put the initialization of the first
variable and the closing brace on a separate line.

Reported-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/debugfs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 48253cf8341b..aa315da83429 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -365,14 +365,17 @@ static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 
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
 }
 
 /* the following attributes are general and therefore they will be directly
-- 
2.8.2

