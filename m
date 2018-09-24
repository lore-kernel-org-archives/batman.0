Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Sep 2018 11:16:08 +0200
Message-Id: <20180924091609.20794-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix colliding redefinition
 of file_dentry
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

Linux >=4.4.8 have the function file_dentry already defined while Linux 4.5
only got it with v4.5.2. Older stable kernel versions might also have
gotten this function. Maintaining a full list of kernel versions which have
this functionality is too much of a burden and thus the calls to this
function are simply replaced with calls to a new private function
batadv_file_dentry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/fs.h b/compat-include/linux/fs.h
index 4d6bb1d7..e0d6f7c7 100644
--- a/compat-include/linux/fs.h
+++ b/compat-include/linux/fs.h
@@ -27,11 +27,20 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
 
-static inline struct dentry *file_dentry(const struct file *file)
+static inline struct dentry *batadv_file_dentry(const struct file *file)
 {
-	return file->f_path.dentry;
+	struct dentry *dentry = file->f_path.dentry;
+
+#ifdef DCACHE_OP_REAL
+	if (unlikely(dentry->d_flags & DCACHE_OP_REAL))
+		return dentry->d_op->d_real(dentry, file_inode(file));
+#endif
+
+	return dentry;
 }
 
+#define file_dentry batadv_file_dentry
+
 #endif /* < KERNEL_VERSION(4, 6, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_FS_H_ */
-- 
2.11.0

