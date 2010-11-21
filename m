Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:56:04 +0100
Message-Id: <1290383767-32602-27-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 26/29] Staging: batman-adv: best gw DHCP
	filter 802.1Q support
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

The DHCP filter inspects packets to determine whether or not to send
them via ethernet unicast. This patch adds 802.1Q (vlan) support for
this check.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/gateway_client.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/gateway_client.c b/drivers/staging/batman-adv/gateway_client.c
index 3d4e109..fde1d8a 100644
--- a/drivers/staging/batman-adv/gateway_client.c
+++ b/drivers/staging/batman-adv/gateway_client.c
@@ -415,6 +415,14 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	ethhdr = (struct ethhdr *)skb->data;
 	header_len += ETH_HLEN;
 
+	/* check for initial vlan header */
+	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+		if (!pskb_may_pull(skb, header_len + VLAN_HLEN))
+			return 0;
+		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
+		header_len += VLAN_HLEN;
+	}
+
 	/* check for ip header */
 	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
 		return 0;
-- 
1.7.2.3

