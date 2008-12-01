From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:56:57 +0100
Message-Id: <1228157822-29406-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Remove unused variable debug_level_info in
	posix/posix.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/posix.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index 1a67e13..048cf94 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -523,7 +523,6 @@ void segmentation_fault(int32_t BATMANUNUSED(sig)) {
 void cleanup(void) {
 
 	int8_t i;
-	struct debug_level_info *debug_level_info;
 	struct list_head *debug_pos, *debug_pos_tmp;
 
 
@@ -533,8 +532,6 @@ void cleanup(void) {
 
 			list_for_each_safe( debug_pos, debug_pos_tmp, (struct list_head *)debug_clients.fd_list[i] ) {
 
-				debug_level_info = list_entry(debug_pos, struct debug_level_info, list);
-
 				list_del( (struct list_head *)debug_clients.fd_list[i], debug_pos, (struct list_head_first *)debug_clients.fd_list[i] );
 				debugFree( debug_pos, 1218 );
 
-- 
1.6.0.4

