Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:31 +0100
Message-Id: <1295659302-7171-9-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 08/19] batman-adv: Add length check for
	(received) tracker packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

Before/while a tracker packet is being searched for next hops for its
destination entries, it will also be checked if the number of
destination and mcast entries might exceed the tracker_packet_len.
Otherwise we might read/write in unallocated memory.
Such a broken tracker packet could potentially occure when we are going
to reuse route_mcast_tracker_packet for tracker packets received from a
neighbour node.

In such a case, we are just reducing the stated mcast / dest numbers in
the tracker packet to fit the size of the allocated buffer.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index 34e89a8..c06035f 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -366,17 +366,38 @@ free:
 	return 1;
 }
 
-/* Collect nexthops for all dest entries specified in this tracker packet */
+/* Collect nexthops for all dest entries specified in this tracker packet.
+ * It also reduces the number of elements in the tracker packet if they exceed
+ * the buffers length (e.g. because of a received, broken tracker packet) to
+ * avoid writing in unallocated memory. */
 static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
+			     int tracker_packet_len,
 			     struct dest_entries_list *next_hops,
 			     struct bat_priv *bat_priv)
 {
 	int num_next_hops = 0, ret;
 	struct tracker_packet_state state;
+	uint8_t *tail = (uint8_t *)tracker_packet + tracker_packet_len;
 
 	INIT_LIST_HEAD(&next_hops->list);
 
 	tracker_packet_for_each_dest(&state, tracker_packet) {
+		/* avoid writing outside of unallocated memory later */
+		if (state.dest_entry + ETH_ALEN > tail) {
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"mcast tracker packet is broken, too many "
+				"entries claimed for its length, repairing");
+
+			tracker_packet->num_mcast_entries = state.mcast_num;
+
+			if (state.dest_num) {
+				tracker_packet->num_mcast_entries++;
+				state.mcast_entry->num_dest = state.dest_num;
+			}
+
+			break;
+		}
+
 		ret = add_router_of_dest(next_hops, state.dest_entry,
 					 bat_priv);
 		if (!ret)
@@ -528,8 +549,8 @@ void route_mcast_tracker_packet(
 	int *tracker_packet_lengths;
 
 	rcu_read_lock();
-	num_next_hops = tracker_next_hops(tracker_packet, &next_hops,
-					  bat_priv);
+	num_next_hops = tracker_next_hops(tracker_packet, tracker_packet_len,
+					  &next_hops, bat_priv);
 	if (!num_next_hops)
 		goto out;
 	next_hop_tracker_packets = kmalloc(tracker_packet_len * num_next_hops,
-- 
1.7.2.3

