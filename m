Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:18 +0100
Message-Id: <1291761150-29818-8-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 08/20] batman-adv: Add length check for
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
 multicast.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/multicast.c b/multicast.c
index bfb1410..2b3d613 100644
--- a/multicast.c
+++ b/multicast.c
@@ -293,25 +293,46 @@ free:
 	return 1;
 }
 
-/* Collect nexthops for all dest entries specified in this tracker packet */
+/* Collect nexthops for all dest entries specified in this tracker packet.
+ * It also reduces the number of elements in the tracker packet if they exceed
+ * the buffers length (i.g. because of a received, broken tracker packet) to
+ * avoid writing in unallocated memory. */
 static int tracker_next_hops(struct mcast_tracker_packet *tracker_packet,
+			     int tracker_packet_len,
 			     struct dest_entries_list *next_hops,
 			     struct bat_priv *bat_priv)
 {
 	int num_next_hops = 0, mcast_num, dest_num, ret;
 	struct mcast_entry *mcast_entry;
 	uint8_t *dest_entry;
+	uint8_t *tail = (uint8_t *)tracker_packet + tracker_packet_len;
 
 	INIT_LIST_HEAD(&next_hops->list);
 
 	tracker_packet_for_each_dest(mcast_entry, dest_entry,
 				     mcast_num, dest_num, tracker_packet) {
+		/* avoid writing outside of unallocated memory later */
+		if (dest_entry + ETH_ALEN > tail) {
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"mcast tracker packet is broken, too many "
+				"entries claimed for its length, repairing");
+
+			tracker_packet->num_mcast_entries = mcast_num;
+
+			if (dest_num) {
+				tracker_packet->num_mcast_entries++;
+				mcast_entry->num_dest = dest_num;
+			}
+
+			goto out;
+		}
+
 		ret = add_router_of_dest(next_hops, dest_entry,
 					 bat_priv);
 		if (!ret)
 			num_next_hops++;
 	}
-
+out:
 	return num_next_hops;
 }
 
@@ -450,8 +471,8 @@ void route_mcast_tracker_packet(
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
1.7.1

