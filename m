Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 14 Jul 2009 11:27:40 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090714092740.GK19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv]: schedule_forward_packet(): Remove
	unused parameter
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

send.c:schedule_forward_packet() takes a parameter unsigned char
*hna_buff which is not used in the function. Remove this unused
parameter. No functional change otherwise.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/send.c
===================================================================
--- batman-adv-kernelland/send.c	(revision 1341)
+++ batman-adv-kernelland/send.c	(working copy)
@@ -207,7 +207,7 @@
 	add_bat_packet_to_list(batman_if->packet_buff, batman_if->packet_len, batman_if, 1, send_time);
 }
 
-void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, unsigned char *hna_buff, int hna_buff_len, struct batman_if *if_incoming)
+void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, int hna_buff_len, struct batman_if *if_incoming)
 {
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
Index: batman-adv-kernelland/send.h
===================================================================
--- batman-adv-kernelland/send.h	(revision 1341)
+++ batman-adv-kernelland/send.h	(working copy)
@@ -28,7 +28,7 @@
 void send_own_packet_work(struct work_struct *work);
 void send_raw_packet(unsigned char *pack_buff, int pack_buff_len, uint8_t *src_addr, uint8_t *dst_addr, struct batman_if *batman_if);
 void schedule_own_packet(struct batman_if *batman_if);
-void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, unsigned char *hna_buff, int hna_buff_len, struct batman_if *if_outgoing);
+void schedule_forward_packet(struct orig_node *orig_node, struct ethhdr *ethhdr, struct batman_packet *batman_packet, uint8_t directlink, int hna_buff_len, struct batman_if *if_outgoing);
 void add_bcast_packet_to_list(unsigned char *packet_buff, int packet_len);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revision 1341)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -469,7 +469,7 @@
 	if (is_single_hop_neigh) {
 
 		/* mark direct link on incoming interface */
-		schedule_forward_packet(orig_node, ethhdr, batman_packet, 1, hna_buff, hna_buff_len, if_incoming);
+		schedule_forward_packet(orig_node, ethhdr, batman_packet, 1, hna_buff_len, if_incoming);
 
 		debug_log(LOG_TYPE_BATMAN, "Forwarding packet: rebroadcast neighbour packet with direct link flag \n");
 		return;
@@ -487,7 +487,7 @@
 	}
 
 	debug_log(LOG_TYPE_BATMAN, "Forwarding packet: rebroadcast originator packet \n");
-	schedule_forward_packet(orig_node, ethhdr, batman_packet, 0, hna_buff, hna_buff_len, if_incoming);
+	schedule_forward_packet(orig_node, ethhdr, batman_packet, 0, hna_buff_len, if_incoming);
 }
 
 void purge_orig(struct work_struct *work)
