Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:56:04 +0200
Message-Id: <1403034964-6737-7-git-send-email-sven@narfation.org>
In-Reply-To: <1403034964-6737-1-git-send-email-sven@narfation.org>
References: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batmand: Don't dereference orig_node
	before checking for NULL
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
Cc: Sven Eckelmann <sven@narfation.org>

The update_route functions first stores the orig_node->router in an extra
variable and later checks if orig_node is NULL. This is not only a potential
cause of a crash but can also cause new compilers to drop the NULL check
completely [1].

[1] https://gcc.gnu.org/onlinedocs/gcc-3.4.3/gcc/Optimize-Options.html#index-fdelete_002dnull_002dpointer_002dchecks-399

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/batman.c b/batman.c
index 89b3bf1..c3dfa7f 100644
--- a/batman.c
+++ b/batman.c
@@ -353,10 +353,9 @@ void update_routes(struct orig_node *orig_node, struct neigh_node *neigh_node, u
 	prof_start(PROF_update_routes);
 	debug_output(4, "update_routes() \n");
 
-	old_router = orig_node->router;
-
 	/* also handles orig_node->router == NULL and neigh_node == NULL */
 	if ((orig_node != NULL) && (orig_node->router != neigh_node)) {
+		old_router = orig_node->router;
 
 		if ( ( orig_node != NULL ) && ( neigh_node != NULL ) ) {
 			addr_to_string( orig_node->orig, orig_str, ADDR_STR_LEN );
@@ -415,7 +414,8 @@ void update_routes(struct orig_node *orig_node, struct neigh_node *neigh_node, u
 		orig_node->router = neigh_node;
 
 	} else if (orig_node != NULL) {
-		hna_global_update(orig_node, hna_recv_buff, hna_buff_len, old_router);
+		hna_global_update(orig_node, hna_recv_buff, hna_buff_len,
+				  orig_node->router);
 	}
 
 	prof_stop(PROF_update_routes);
-- 
2.0.0

