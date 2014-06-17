Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:56:03 +0200
Message-Id: <1403034964-6737-6-git-send-email-sven@narfation.org>
In-Reply-To: <1403034964-6737-1-git-send-email-sven@narfation.org>
References: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] batmand: Don't try to
	schedule_own_packet with no if_incoming
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

send_outstanding_packets checks if a forw_node has a correct if_incoming.
Otherwise it jumps to packet_free to deallocate the packet infrastructure. But
this also schedules packets with the batman interfaces as target incoming_if.
This is known to be NULL but is dereferenced in schedule_own_packet.

This NULL dereference should be avoided.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 schedule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedule.c b/schedule.c
index 3e65d68..03cdb78 100644
--- a/schedule.c
+++ b/schedule.c
@@ -359,7 +359,7 @@ void send_outstanding_packets(uint32_t curr_time)
 
 packet_free:	list_del((struct list_head *)&forw_list, forw_pos, &forw_list);
 
-		if (forw_node->own)
+		if (forw_node->own && forw_node->if_incoming)
 			schedule_own_packet(forw_node->if_incoming);
 
 		debugFree(forw_node->pack_buff, 1501);
-- 
2.0.0

