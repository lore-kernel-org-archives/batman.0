Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  4 Jul 2013 17:54:51 +0200
Message-Id: <1372953291-1632-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix vlan compat code
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

A define has been accidentally put inside a wrong ifdef block.
Move it out.

Introduced by 952cebb57518ec18dfdebfcb2b85539f58f20779
("batman-adv: add per VLAN interface attribute framework")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index fd6ee46..9944081 100644
--- a/compat.h
+++ b/compat.h
@@ -326,10 +326,10 @@ static int __batadv_interface_set_mac_addr(x, y)
 #include <linux/if_vlan.h>
 #define vlan_insert_tag(skb, proto, vid) vlan_insert_tag(skb, vid)
 
-#define NETIF_F_HW_VLAN_CTAG_FILTER NETIF_F_HW_VLAN_FILTER
-
 #endif /* vlan_insert_tag */
 
+#define NETIF_F_HW_VLAN_CTAG_FILTER NETIF_F_HW_VLAN_FILTER
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
 
 #define batadv_interface_add_vid(x, y, z) \
-- 
1.8.1.5

