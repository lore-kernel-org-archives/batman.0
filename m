Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 06:17:49 +0800
Message-Id: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: ignore protocol packets if
	the interface did not enable this protocol
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index eca2b44..819ae49 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1186,6 +1186,7 @@ out:
 static int bat_iv_ogm_receive(struct sk_buff *skb,
 			      struct hard_iface *if_incoming)
 {
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batman_ogm_packet *batman_ogm_packet;
 	struct ethhdr *ethhdr;
 	int buff_pos = 0, packet_len;
@@ -1196,6 +1197,11 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 	if (!ret)
 		return NET_RX_DROP;
 
+	/* did we receive a B.A.T.M.A.N. IV OGM packet on an interface
+	 * that does not have B.A.T.M.A.N. IV enabled ? */
+	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_iv_ogm_emit)
+		return NET_RX_DROP;
+
 	packet_len = skb_headlen(skb);
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	packet_buff = skb->data;
-- 
1.7.9.1

