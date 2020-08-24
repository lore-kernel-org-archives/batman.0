Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/3] batman-adv: Avoid uninitialized chaddr when handling DHCP
Date: Mon, 24 Aug 2020 18:21:09 +0200
Message-Id: <20200824162111.29220-2-sw@simonwunderlich.de>
In-Reply-To: <20200824162111.29220-1-sw@simonwunderlich.de>
References: <20200824162111.29220-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, syzbot+ab16e463b903f5a37036@syzkaller.appspotmail.com, Antonio Quartulli <a@unstable.cc>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The gateway client code can try to optimize the delivery of DHCP packets to
avoid broadcasting them through the whole mesh. But also transmissions to
the client can be optimized by looking up the destination via the chaddr of
the DHCP packet.

But the chaddr is currently only done when chaddr is fully inside the
non-paged area of the skbuff. Otherwise it will not be initialized and the
unoptimized path should have been taken.

But the implementation didn't handle this correctly. It didn't retrieve the
correct chaddr but still tried to perform the TT lookup with this
uninitialized memory.

Reported-by: syzbot+ab16e463b903f5a37036@syzkaller.appspotmail.com
Fixes: 6c413b1c22a2 ("batman-adv: send every DHCP packet as bat-unicast")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a18dcc686dc3..ef3f85b576c4 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -703,8 +703,10 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 
 	chaddr_offset = *header_len + BATADV_DHCP_CHADDR_OFFSET;
 	/* store the client address if the message is going to a client */
-	if (ret == BATADV_DHCP_TO_CLIENT &&
-	    pskb_may_pull(skb, chaddr_offset + ETH_ALEN)) {
+	if (ret == BATADV_DHCP_TO_CLIENT) {
+		if (!pskb_may_pull(skb, chaddr_offset + ETH_ALEN))
+			return BATADV_DHCP_NO;
+
 		/* check if the DHCP packet carries an Ethernet DHCP */
 		p = skb->data + *header_len + BATADV_DHCP_HTYPE_OFFSET;
 		if (*p != BATADV_DHCP_HTYPE_ETHERNET)
-- 
2.20.1

