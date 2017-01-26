Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jan 2017 17:44:00 +0100
Message-Id: <20170126164404.16074-4-sw@simonwunderlich.de>
In-Reply-To: <20170126164404.16074-1-sw@simonwunderlich.de>
References: <20170126164404.16074-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] uapi: install batman_adv.h header
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

09748a22f4ab ("batman-adv: add generic netlink family for batman-adv")
introduced the new batman_adv.h which describes the netlink attributes and
commands of batman-adv. But the Kbuild entry to install the header was not
added.

All currently known tools ship their own copy of batman_adv.h but it should
be installed anyway to later be able to migrate to the system batman_adv.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index a8b93e685239..7fdceb2ac5b7 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -64,6 +64,7 @@ header-y += auto_fs.h
 header-y += auxvec.h
 header-y += ax25.h
 header-y += b1lli.h
+header-y += batman_adv.h
 header-y += baycom.h
 header-y += bcm933xx_hcs.h
 header-y += bfs_fs.h
-- 
2.11.0

