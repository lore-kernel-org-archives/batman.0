Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:41:49 +0100
Message-Id: <20190328154152.20552-10-sw@simonwunderlich.de>
In-Reply-To: <20190328154152.20552-1-sw@simonwunderlich.de>
References: <20190328154152.20552-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/12] MAINTAINERS: Add T(ree) field for
 batman-adv
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The linux-merge.git repository on git.open-mesh.org is used since 8 years
to send PRs for net.git and net-next.git. It is time to officially specify
list it as SCM tree.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 828dc1bd5a16..01eb5225e4ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2796,6 +2796,7 @@ W:	https://www.open-mesh.org/
 B:	https://www.open-mesh.org/projects/batman-adv/issues
 C:	irc://chat.freenode.net/batman
 Q:	https://patchwork.open-mesh.org/project/batman/list/
+T:	git https://git.open-mesh.org/linux-merge.git
 S:	Maintained
 F:	Documentation/ABI/obsolete/sysfs-class-net-batman-adv
 F:	Documentation/ABI/obsolete/sysfs-class-net-mesh
-- 
2.11.0

