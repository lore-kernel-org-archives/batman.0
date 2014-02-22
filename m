Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Feb 2014 17:02:38 +0100
Message-Id: <1393084958-2133-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: improve DAT documentation
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Add missing documentation for BATADV_DAT_ADDR_MAX and
convert an existing documentation to kerneldoc

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 distributed-arp-table.h | 3 +++
 types.h                 | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index ac9be9b..d76e1d0 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -25,6 +25,9 @@
 
 #include <linux/if_arp.h>
 
+/**
+ * BATADV_DAT_ADDR_MAX - maximum address value in the DHT space
+ */
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
 
 void batadv_dat_status_update(struct net_device *net_dev);
diff --git a/types.h b/types.h
index d4b923c..34891a5 100644
--- a/types.h
+++ b/types.h
@@ -24,8 +24,9 @@
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
-/* batadv_dat_addr_t is the type used for all DHT addresses. If it is changed,
- * BATADV_DAT_ADDR_MAX is changed as well.
+/**
+ * batadv_dat_addr_t - it is the type used for all DHT addresses. If it is
+ *  changed, BATADV_DAT_ADDR_MAX is changed as well.
  *
  * *Please be careful: batadv_dat_addr_t must be UNSIGNED*
  */
-- 
1.8.4.5

