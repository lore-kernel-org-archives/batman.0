Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 12 Oct 2013 16:17:36 +0200
Message-Id: <1381587456-1709-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in ICMP header kernel
	doc
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

Introduced by 1897ab719862eb43e0a6edd3a20b8d9fa7a2173d
("batman-adv: create common header for ICMP packets")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index f4bbb05..9fbcaac 100644
--- a/packet.h
+++ b/packet.h
@@ -195,7 +195,7 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
- * batadc_icmp_header - common ICMP header
+ * batadv_icmp_header - common ICMP header
  * @header: common batman header
  * @msg_type: ICMP packet type
  * @dst: address of the destination node
-- 
1.8.3.2

