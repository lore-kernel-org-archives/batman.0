Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:09 +0100
Message-Id: <1266592691-13090-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-5-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
	<1266592691-13090-2-git-send-email-andrew@lunn.ch>
	<1266592691-13090-3-git-send-email-andrew@lunn.ch>
	<1266592691-13090-4-git-send-email-andrew@lunn.ch>
	<1266592691-13090-5-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] Staging: batman-adv: Fix skbuff leak in
	VIS code.
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
To: gregkh@suse.de
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net

The vis code takes a copy of the data inside the skbuf if it is interesting
for us, so we always need to release the skbuf.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/routing.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 7dc9aef..d89048b 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -939,7 +939,6 @@ int recv_vis_packet(struct sk_buff *skb)
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct vis_packet);
-	int ret;
 
 	if (skb_headlen(skb) < hdr_size)
 		return NET_RX_DROP;
@@ -962,18 +961,18 @@ int recv_vis_packet(struct sk_buff *skb)
 	case VIS_TYPE_SERVER_SYNC:
 		/* TODO: handle fragmented skbs properly */
 		receive_server_sync_packet(vis_packet, skb_headlen(skb));
-		ret = NET_RX_SUCCESS;
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
 		/* TODO: handle fragmented skbs properly */
 		receive_client_update_packet(vis_packet, skb_headlen(skb));
-		ret = NET_RX_SUCCESS;
 		break;
 
 	default:	/* ignore unknown packet */
-		ret = NET_RX_DROP;
 		break;
 	}
-	return ret;
+
+	/* We take a copy of the data in the packet, so we should
+	   always free the skbuf. */
+	return NET_RX_DROP;
 }
-- 
1.6.6.2

