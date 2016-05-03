Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  4 May 2016 06:23:37 +0800
Message-Id: <1462314230-16257-3-git-send-email-a@unstable.cc>
In-Reply-To: <1462314230-16257-1-git-send-email-a@unstable.cc>
References: <1462314230-16257-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 02/15] MAINTAINERS: Add BATMAN ADVANCED
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

From: Sven Eckelmann <sven@narfation.org>

The sysfs ABI documentation files and the batman-adv.txt are maintained by
the BATMAN ADVANCED maintainers and patches for them should therefore be
sent to them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22688419873f..8f32094f6922 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2207,6 +2207,9 @@ L:	b.a.t.m.a.n@lists.open-mesh.org (moderated for non-subscribers)
 W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
+F:	Documentation/ABI/testing/sysfs-class-net-mesh
+F:	Documentation/networking/batman-adv.txt
 F:	net/batman-adv/
 
 BAYCOM/HDLCDRV DRIVERS FOR AX.25
-- 
2.8.2

