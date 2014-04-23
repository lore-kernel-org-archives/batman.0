Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 23 Apr 2014 14:05:16 +0200
Message-Id: <1398254716-22089-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix reference counting
	imbalance while sending fragment
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In the new fragmentation code the batadv_frag_send_packet()
function obtains a reference to the primary_if, but it does
not release it upon return.

This reference imbalance prevents the primary_if (and then
the related netdevice) to be properly released on shut down.

Fix this by releasing the primary_if in batadv_frag_send_packet().

Introduced by db56e4ecf5c2b179a0101138eacc2ec52b6ef45d
("batman-adv: Fragment and send skbs larger than mtu")

Cc: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 fragmentation.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fragmentation.c b/fragmentation.c
index 88df9b1..cc1cfd6 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -418,12 +418,13 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 			     struct batadv_neigh_node *neigh_node)
 {
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_frag_packet frag_header;
 	struct sk_buff *skb_fragment;
 	unsigned mtu = neigh_node->if_incoming->net_dev->mtu;
 	unsigned header_size = sizeof(frag_header);
 	unsigned max_fragment_size, max_packet_size;
+	bool ret = false;
 
 	/* To avoid merge and refragmentation at next-hops we never send
 	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
@@ -483,7 +484,11 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 			   skb->len + ETH_HLEN);
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 
-	return true;
+	ret = true;
+
 out_err:
-	return false;
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+
+	return ret;
 }
-- 
1.8.3.2

