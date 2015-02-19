Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 Feb 2015 00:02:45 +0800
Message-Id: <1424361765-25248-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: checkpatch - wrong alignment
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Introduced by fe67bb41f0e1647c3b05aeb4b736a1171bff496b
("batman-adv: debugfs, avoid compiling for !DEBUG_FS")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 debugfs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/debugfs.h b/debugfs.h
index 5db336a..421f092 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -48,14 +48,14 @@ static inline void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 }
 
-static inline int batadv_debugfs_add_hardif(
-		struct batadv_hard_iface *hard_iface)
+static inline
+int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 {
 	return 0;
 }
 
-static inline void batadv_debugfs_del_hardif(
-		struct batadv_hard_iface *hard_iface)
+static inline
+void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 {
 }
 
-- 
2.1.4

