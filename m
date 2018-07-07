Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Jul 2018 22:01:21 +0200
Message-Id: <20180707200121.2684-4-sven@narfation.org>
In-Reply-To: <20180707200121.2684-1-sven@narfation.org>
References: <20180707200121.2684-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Convert batadv_dat_addr_t to
 proper type
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

The #define for batadv_dat_addr_t is doing nothing else than giving u16 a
new typename. But C already has the special keyword "typedef" which is also
better supported by kernel-doc.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 360357f8..343d3048 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -43,12 +43,13 @@ struct seq_file;
 #ifdef CONFIG_BATMAN_ADV_DAT
 
 /**
- * batadv_dat_addr_t - it is the type used for all DHT addresses. If it is
- *  changed, BATADV_DAT_ADDR_MAX is changed as well.
+ * typedef batadv_dat_addr_t - type used for all DHT addresses
+ *
+ * If it is changed, BATADV_DAT_ADDR_MAX is changed as well.
  *
  * *Please be careful: batadv_dat_addr_t must be UNSIGNED*
  */
-#define batadv_dat_addr_t u16
+typedef u16 batadv_dat_addr_t;
 
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
-- 
2.18.0

