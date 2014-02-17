Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:49 +0100
Message-Id: <1392670129-2498-11-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: fix potential kernel
	paging error for unicast transmissions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>

batadv_send_skb_prepare_unicast(_4addr) might reallocate the
skb's data. If it does then our ethhdr pointer is not valid
anymore in batadv_send_skb_unicast(), resulting in a kernel
paging error.

Fixing this by refetching the ethhdr pointer after the
potential reallocation.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 579f5f0..843febd 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -254,9 +254,9 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node,
 				   unsigned short vid)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct ethhdr *ethhdr;
 	struct batadv_unicast_packet *unicast_packet;
-	int ret = NET_XMIT_DROP;
+	int ret = NET_XMIT_DROP, hdr_size;
 
 	if (!orig_node)
 		goto out;
@@ -265,12 +265,16 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	case BATADV_UNICAST:
 		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
 			goto out;
+
+		hdr_size = sizeof(*unicast_packet);
 		break;
 	case BATADV_UNICAST_4ADDR:
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
 							   orig_node,
 							   packet_subtype))
 			goto out;
+
+		hdr_size = sizeof(struct batadv_unicast_4addr_packet);
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
@@ -279,6 +283,7 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
 	/* inform the destination node that we are still missing a correct route
-- 
1.8.5.3

