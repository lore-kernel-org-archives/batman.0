Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  7 Oct 2012 09:05:36 +0200
Message-Id: <1349593536-21213-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix new line alignment
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

Introduced with ("batman-adv: Distributed ARP Table - create DHT helper
functions")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 22dd983..63a13a5 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -60,7 +60,7 @@ batadv_dat_init_orig_node_addr(struct batadv_orig_node *orig_node)
  */
 static inline void
 batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
-			     struct batadv_hard_iface *primary_if)
+			 struct batadv_hard_iface *primary_if)
 {
 	uint32_t addr;
 
-- 
1.7.12

