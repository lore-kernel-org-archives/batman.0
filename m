Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 21:19:03 +0200
Message-Id: <1379877543-435-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix wrong kernel doc
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

The name of the function does not match the kernel doc. Fix it.

Introduced by 6228419df3a53d09a2ba1f3e7b32bcd7cd59c968
("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 1198aea..d1840dd 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2729,7 +2729,7 @@ out:
 }
 
 /**
- * batadv_dat_status_update - process incoming tt reply
+ * batadv_handle_tt_response - process incoming tt reply
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: tt data containing the tt request information
  * @resp_src: mac address of tt reply sender
-- 
1.8.1.5

