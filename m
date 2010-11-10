Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed, 10 Nov 2010 01:48:13 +0100
Message-Id: <1289350093-5782-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Allow promiscuous reception of
	unicast packets
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This commits adds the possibility for the final destination node to also
receive and accept unicast data packets promiscuously already from an
arbitrary previous hop along the path, and not only the last previous hop.

This feature is especially useful in the following two scenarios:

Firstly, a very mobile node moving towards the sender along the hop path
benefits from this as for such a mobility pattern the reception probability
increases, no matter how slow the topology convergence speed is.

It also increases the probability of succesful reception a lot, if there
are (multiple) shorter, alternate but slightly "worse" paths, too (like
in a circular topology). As WiFi is a broadcast medium, there can be a
quite good chance to receive a packet from one of the nodes on the path
to the receiver already.

On smaller embedded devices, I would advice to run your own measurements
before activating this feature. Depending on wifi chipset
and driver as well as cpu, this can negatively affect your throughput.

To let this feature take effect, place your WiFi interface in
promiscuous mode (e.g. 'ip link set wlan0 promisc on'/'ifconfig wlan0
promisc').

Also note, that higher layers might receive a data packet more than
once. So if you have a special higher layer protocol that cannot deal
with that, then do not activate the promisc mode on this node.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 routing.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 9f31167..082eb59 100644
--- a/routing.c
+++ b/routing.c
@@ -1127,7 +1127,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return -1;
+		return 1;
 
 	return 0;
 }
@@ -1217,8 +1217,10 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_packet);
+	int check_ret;
 
-	if (check_unicast_packet(skb, hdr_size) < 0)
+	check_ret = check_unicast_packet(skb, hdr_size);
+	if (check_ret < 0)
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
@@ -1229,6 +1231,9 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	if (check_ret)
+		return NET_RX_DROP;
+
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
@@ -1238,9 +1243,10 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct unicast_frag_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_frag_packet);
 	struct sk_buff *new_skb = NULL;
-	int ret;
+	int ret, check_ret;
 
-	if (check_unicast_packet(skb, hdr_size) < 0)
+	check_ret = check_unicast_packet(skb, hdr_size);
+	if (check_ret < 0)
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_frag_packet *)skb->data;
@@ -1262,6 +1268,9 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	if (check_ret)
+		return NET_RX_DROP;
+
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
-- 
1.7.1

