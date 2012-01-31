Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 31 Jan 2012 22:35:10 +0100
Message-Id: <1328045710-32600-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the correct header size to
	interface_rx
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

in recv_unicast_frag(), the third parameter of the interface_rx() invocation,
which is the size of the current header, is wrongly computed.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/routing.c b/routing.c
index f961cc5..cf8fe0a 100644
--- a/routing.c
+++ b/routing.c
@@ -990,7 +990,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 			return NET_RX_SUCCESS;
 
 		interface_rx(recv_if->soft_iface, new_skb, recv_if,
-			     sizeof(struct unicast_packet));
+			     sizeof(*unicast_packet));
 		return NET_RX_SUCCESS;
 	}
 
-- 
1.7.3.4

