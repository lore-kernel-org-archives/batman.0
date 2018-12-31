Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Dec 2018 22:46:09 +0100
Message-Id: <20181231214609.22378-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Force mac header to start
 of data on xmit
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
Cc: Sven Eckelmann <sven@narfation.org>, syzkaller-bugs@googlegroups.com

The caller of ndo_start_xmit may not already have called
skb_reset_mac_header. The returned value of skb_mac_header/eth_hdr
therefore can be in the wrong position and even outside the current skbuff.
This for example happens when the user binds to the device using a
PF_PACKET-SOCK_RAW with enabled qdisc-bypass:

  int opt = 4;
  setsockopt(sock, SOL_PACKET, PACKET_QDISC_BYPASS, &opt, sizeof(opt));

Since eth_hdr is used all over the codebase, the batadv_interface_tx
function must always take care of resetting it.

Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs")
Reported-by: syzbot+9d7405c7faa390e60b4e@syzkaller.appspotmail.com
Reported-by: syzbot+7d20bc3f1ddddc0f9079@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: syzkaller-bugs@googlegroups.com
---
 net/batman-adv/soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5db5a0a4..b85ca809 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -221,6 +221,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 	netif_trans_update(soft_iface);
 	vid = batadv_get_vid(skb, 0);
+
+	skb_reset_mac_header(skb);
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
-- 
2.19.2

