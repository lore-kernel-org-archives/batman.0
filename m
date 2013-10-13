Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 23:02:45 +0200
Message-Id: <1381698165-1146-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: properly rename define in
	distributed arp table header file
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 distributed-arp-table.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 60d853b..79a078b 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -17,8 +17,8 @@
  * 02110-1301, USA
  */
 
-#ifndef _NET_BATMAN_ADV_ARP_H_
-#define _NET_BATMAN_ADV_ARP_H_
+#ifndef _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
+#define _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
@@ -169,4 +169,4 @@ static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
 
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
-#endif /* _NET_BATMAN_ADV_ARP_H_ */
+#endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
-- 
1.8.3.2

