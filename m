Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  2 Apr 2015 08:34:36 +0200
Message-Id: <1427956477-20220-3-git-send-email-sven@narfation.org>
In-Reply-To: <1427956477-20220-1-git-send-email-sven@narfation.org>
References: <1427956477-20220-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 3/4] batman-adv: Remove unused
	IFF_BRIDGE_PORT live patching hack
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3: no change
v2: no change

 compat.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/compat.h b/compat.h
index ed90e2e..80a1543 100644
--- a/compat.h
+++ b/compat.h
@@ -59,8 +59,6 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
-#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
-
 /* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
 #define addr_assign_type ifindex
 
-- 
2.1.4

