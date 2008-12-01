From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:57:01 +0100
Message-Id: <1228157822-29406-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Remove unused functions isDuplicate and
	isBntog
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

---
 batman/batman.c |   37 -------------------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index ebe5aab..0c17f33 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -666,43 +666,6 @@ unsigned char get_gw_class(int down, int up)
 
 
 
-int isDuplicate(struct orig_node *orig_node, uint16_t seqno)
-{
-	struct list_head *neigh_pos;
-	struct neigh_node *neigh_node;
-
-	prof_start( PROF_is_duplicate );
-
-	list_for_each( neigh_pos, &orig_node->neigh_list ) {
-
-		neigh_node = list_entry( neigh_pos, struct neigh_node, list );
-
-		if ( get_bit_status( neigh_node->real_bits, orig_node->last_real_seqno, seqno ) ) {
-
-			prof_stop( PROF_is_duplicate );
-			return 1;
-
-		}
-
-	}
-
-	prof_stop( PROF_is_duplicate );
-
-	return 0;
-}
-
-
-
-int isBntog(uint32_t neigh, struct orig_node *orig_tog_node)
-{
-	if ( ( orig_tog_node->router != NULL ) && ( orig_tog_node->router->addr == neigh ) )
-		return 1;
-
-	return 0;
-}
-
-
-
 static int isBidirectionalNeigh(struct orig_node *orig_node, struct orig_node *orig_neigh_node, struct bat_packet *in, uint32_t recv_time, struct batman_if *if_incoming)
 {
 
-- 
1.6.0.4

