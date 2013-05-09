Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 16:28:07 +0200
Message-Id: <1368109687-3780-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1368109687-3780-1-git-send-email-ordex@autistici.org>
References: <1368109687-3780-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: use VLAN_VID_MASK when
	printing the vid
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
Cc: Antonio Quartulli <ordex@autistici.org>

Introduced in 454b849c7de18a7b44eecebe889f5f3149d24780
("batman-adv: print the VID properly")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 68c7ee0..834b1a0 100644
--- a/main.h
+++ b/main.h
@@ -173,7 +173,7 @@ enum batadv_vlan_flags {
 };
 
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
-			       (int)(vid & BATADV_VID_MASK) : -1)
+			       (int)(vid & VLAN_VID_MASK) : -1)
 
 extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
-- 
1.8.1.5

