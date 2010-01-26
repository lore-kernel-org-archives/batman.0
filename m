Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 26 Jan 2010 15:16:38 +0800
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
In-Reply-To: <20100126061311.GA12697@Sellars>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XbpXLpPr9mHCqQo"
Message-Id: <201001261516.39057.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--Boundary-00=_XbpXLpPr9mHCqQo
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Tuesday 26 January 2010 14:13:11 Linus L=FCssing wrote:
> I'm now able to reproduce the second problem as well:
> Activating the vis-server on one node causes the vis-clients to
> throw this call trace with its slow path warning imediately.
> Nevertheless, vis output works anyway, clients are sending
> vis-packets and the server is drawing nice graphs.
> See the attachment for an example call trace.

Please try the attached patch and see if it helps.

Regards,
Marek

--Boundary-00=_XbpXLpPr9mHCqQo
Content-Type: text/x-patch;
  charset="UTF-8";
  name="no_lock_while_send.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="no_lock_while_send.patch"

diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index b118d1e..a6c235f 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -405,6 +405,9 @@ static void purge_vis_packets(void)
 {
 	HASHIT(hashit);
 	struct vis_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vis_hash_lock, flags);
 
 	while (hash_iterate(vis_hash, &hashit)) {
 		info = hashit.bucket->data;
@@ -416,13 +419,17 @@ static void purge_vis_packets(void)
 			free_info(info);
 		}
 	}
+
+	spin_unlock_irqrestore(&vis_hash_lock, flags);
 }
 
 static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
+	struct batman_if *batman_if;
 	unsigned long flags;
+	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 
@@ -431,45 +438,60 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
-		if (orig_node &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    orig_node->batman_if &&
-		    orig_node->router) {
+		if ((!orig_node) || (!orig_node->batman_if) ||
+		    (!orig_node->router))
+			continue;
 
-			/* don't send it if we already received the packet from
-			 * this node. */
-			if (recv_list_is_in(&info->recv_list, orig_node->orig))
-				continue;
+		if (!(orig_node->flags & VIS_SERVER))
+			continue;
 
-			memcpy(info->packet.target_orig,
-			       orig_node->orig, ETH_ALEN);
+		/* don't send it if we already received the packet from
+		 * this node. */
+		if (recv_list_is_in(&info->recv_list, orig_node->orig))
+			continue;
 
-			send_raw_packet((unsigned char *) &info->packet,
-					packet_length,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		}
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
+		batman_if = orig_node->batman_if;
+		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+
+		send_raw_packet((unsigned char *)&info->packet,
+				packet_length, batman_if, dstaddr);
+
+		spin_lock_irqsave(&orig_hash_lock, flags);
 	}
-	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 }
 
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
+	struct batman_if *batman_if;
 	unsigned long flags;
+	uint8_t dstaddr[ETH_ALEN];
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, info->packet.target_orig));
 
-	if ((orig_node != NULL) &&
-	    (orig_node->batman_if != NULL) &&
-	    (orig_node->router != NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
-				orig_node->batman_if,
-				orig_node->router->addr);
-	}
+	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
+		goto out;
+
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
+	batman_if = orig_node->batman_if;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	send_raw_packet((unsigned char *)&info->packet,
+			packet_length, batman_if, dstaddr);
+
+	return;
+
+out:
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
 
@@ -502,17 +524,18 @@ static void send_vis_packets(struct work_struct *work)
 	struct vis_info *info, *temp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&vis_hash_lock, flags);
 	purge_vis_packets();
 
 	if (generate_vis_packet() == 0)
 		/* schedule if generation was successful */
 		list_add_tail(&my_vis_info->send_list, &send_list);
 
+	spin_lock_irqsave(&vis_hash_lock, flags);
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
 		list_del_init(&info->send_list);
 		send_vis_packet(info);
 	}
+
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 	start_vis_timer();
 }

--Boundary-00=_XbpXLpPr9mHCqQo--
