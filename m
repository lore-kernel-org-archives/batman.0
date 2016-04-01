Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Apr 2016 15:17:36 +0200
Message-Id: <1459516656-4404-2-git-send-email-sven@narfation.org>
In-Reply-To: <1459516656-4404-1-git-send-email-sven@narfation.org>
References: <1459516656-4404-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] MAINTAINERS: Add BATMAN ADVANCED
	documentation files
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

The sysfs ABI documentation files and the batman-adv.txt are maintained by
the BATMAN ADVANCED maintainers and patches for them should therefore be
sent to them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 835a520..6846df4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2210,6 +2210,9 @@ L:	b.a.t.m.a.n@lists.open-mesh.org (moderated for non-subscribers)
 W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
+F:	Documentation/ABI/testing/sysfs-class-net-mesh
+F:	Documentation/networking/batman-adv.txt
 F:	net/batman-adv/
 
 BAYCOM/HDLCDRV DRIVERS FOR AX.25
-- 
2.8.0.rc3

