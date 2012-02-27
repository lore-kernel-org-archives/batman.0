Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Feb 2012 13:36:40 +0100
Message-Id: <1330346200-23727-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unused variable
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

Actually unicast_4addr_packet in interface_rx() is set but never used and
therefore can be safely be removed.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 8b68e01..92137af 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -259,7 +259,6 @@ void interface_rx(struct net_device *soft_iface,
 		  int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	struct unicast_4addr_packet *unicast_4addr_packet;
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid __maybe_unused = -1;
@@ -268,8 +267,6 @@ void interface_rx(struct net_device *soft_iface,
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
 
-	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
-
 	if (dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto out;
 
-- 
1.7.3.4

