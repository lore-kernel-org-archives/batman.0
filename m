Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Nov 2010 17:45:59 +0100
Message-Id: <1289148361-16019-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Allow promiscuous reception
	of unicast packets
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

From: Linus Lüssing <linus.luessing@ascom.ch>

A very mobile node may want to enable this to increase the probability
of unicast data reception on the last hop, especially when such a mobile
node moves towards the sender.

The mobile node needs to place its hard-interfaces utilized by
batman-adv into promisc-mode to let this optimization take effect. Be
aware, that doing so will cost your devices more processing power.

It also increases the probability of succesful reception a lot, if there
are (multiple) shorter, alternate but slightly "worse" paths, too. As
WiFi is a broadcast medium, there can be a quite good chance to receive
a packet from one of the nodes on the path to the receiver already.

Luckily batman-adv is running in kernelspace, therefore it does not make
much of a performance difference, even on embedded devices.

To let this feature take effect, place your WiFi interface in
promiscuous mode (e.g. 'ip link set wlan0 promisc on'/'ifconfig wlan0
promisc').

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 routing.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index e75337d..b61821a 100644
--- a/routing.c
+++ b/routing.c
@@ -1124,7 +1124,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return -1;
+		return 1;
 
 	return 0;
 }
@@ -1214,8 +1214,10 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_packet);
+	int check_ret;
 
-	if (check_unicast_packet(skb, hdr_size) < 0)
+	check_ret = check_unicast_packet(skb, hdr_size);
+	if (check_ret < 0)
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
@@ -1226,6 +1228,9 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	if (check_ret)
+		return NET_RX_DROP;
+
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
@@ -1235,9 +1240,10 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
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
@@ -1259,6 +1265,9 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	if (check_ret)
+		return NET_RX_DROP;
+
 	return route_unicast_packet(skb, recv_if, hdr_size);
 }
 
-- 
1.7.1

