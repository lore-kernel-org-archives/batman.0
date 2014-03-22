Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Mar 2014 09:56:15 +0100
Message-Id: <1395478576-10999-16-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
References: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: improve DAT documentation
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Add missing documentation for BATADV_DAT_ADDR_MAX and
convert an existing documentation to kerneldoc

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/distributed-arp-table.h | 3 +++
 net/batman-adv/types.h                 | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index ac9be9b..d76e1d0 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -25,6 +25,9 @@
 
 #include <linux/if_arp.h>
 
+/**
+ * BATADV_DAT_ADDR_MAX - maximum address value in the DHT space
+ */
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
 
 void batadv_dat_status_update(struct net_device *net_dev);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d4b923c..34891a5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
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
1.8.3.2

