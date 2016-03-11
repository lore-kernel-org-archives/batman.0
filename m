Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 14:01:11 +0100
Message-Id: <1457701271-24248-2-git-send-email-sven@narfation.org>
In-Reply-To: <1457701271-24248-1-git-send-email-sven@narfation.org>
References: <1457701271-24248-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix debuginfo macro style
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <simon.wunderlich@open-mesh.com>

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

Structure initialization within the macros should follow the general
coding style used in the kernel: put the initialization of the first
variable and the closing brace on a separate line.

Reported-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch was resurrected from https://patchwork.open-mesh.org/patch/3769/

I've requested an rebased version at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014638.html
but done it myself because it was rather trivial.
---
 net/batman-adv/debugfs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3dc5208..9529004 100644
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
2.7.0

