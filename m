Date: Sun, 28 Sep 2008 11:18:14 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080928091814.GA7497@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Remove dead stores in batmand
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
 batman/batman.c     |    4 ++--
 batman/originator.c |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index d7e2389..eda5774 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -897,7 +897,7 @@ int8_t batman(void)
 	char orig_str[ADDR_STR_LEN], neigh_str[ADDR_STR_LEN], ifaddr_str[ADDR_STR_LEN], oldorig_str[ADDR_STR_LEN];
 	int16_t hna_buff_count, hna_buff_len, packet_len, curr_packet_len;
 	uint8_t forward_old, if_rp_filter_all_old, if_rp_filter_default_old, if_send_redirects_all_old, if_send_redirects_default_old;
-	uint8_t is_my_addr, is_my_orig, is_my_oldorig, is_broadcast, is_duplicate, is_bidirectional, is_bntog, has_directlink_flag;
+	uint8_t is_my_addr, is_my_orig, is_my_oldorig, is_broadcast, is_duplicate, is_bidirectional, has_directlink_flag;
 	int8_t res;
 
 
@@ -1005,7 +1005,7 @@ int8_t batman(void)
 				addr_to_string(bat_packet->orig, orig_str, sizeof(orig_str));
 				addr_to_string(bat_packet->old_orig, oldorig_str, sizeof(oldorig_str));
 
-				is_my_addr = is_my_orig = is_my_oldorig = is_broadcast = is_duplicate = is_bidirectional = is_bntog = 0;
+				is_my_addr = is_my_orig = is_my_oldorig = is_broadcast = 0;
 
 				has_directlink_flag = (bat_packet->flags & DIRECTLINK ? 1 : 0);
 
diff --git a/batman/originator.c b/batman/originator.c
index 8097d4a..7f13f3d 100644
--- a/batman/originator.c
+++ b/batman/originator.c
@@ -219,8 +219,6 @@ void update_orig( struct orig_node *orig_node, struct bat_packet *in, uint32_t n
 
 	if ( ( neigh_node->tq_avg > max_tq ) || ( ( neigh_node->tq_avg == max_tq ) && ( neigh_node->orig_node->bcast_own_sum[if_incoming->if_num] > max_bcast_own ) ) || ( ( orig_node->router == neigh_node ) && ( neigh_node->tq_avg == max_tq ) ) ) {
 
-		max_tq = neigh_node->tq_avg;
-		max_bcast_own = neigh_node->orig_node->bcast_own_sum[if_incoming->if_num];
 		best_neigh_node = neigh_node;
 
 	}
-- 
1.6.0.1


