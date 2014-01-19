Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 20 Jan 2014 00:26:08 +0100
Message-Id: <1390173968-8670-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: fix potential kernel
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
To: b.a.t.m.a.n@lists.open-mesh.org

batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
data. If it does then our ethhdr pointer is not valid anymore in
batadv_send_skb_unicast(), resulting in a kernel paging error.

Fixing this by refetching the ethhdr pointer after the potential
reallocation.

~~~
NOTE TO LINUX STABLE MAINTAINERS:

For kernels < 3.9 you will need an additional skb_reset_mac_header(skb)
call in the beginning of batadv_send_skb_unicast().

For kernels >= 3.9 this is not necessary thanks to:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)
~~~

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Note: this patch shouldn't be used in an off-tree module on
kernels < 3.9 without the compat hunk provided by:

"batman-adv: use vlan_/eth_hdr() instead of skb->data in interface_tx path"


 send.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/send.c b/send.c
index 579f5f0..8b312e3 100644
--- a/send.c
+++ b/send.c
@@ -279,6 +279,10 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
+	/* skb->data might have been reallocated by
+	 * batadv_send_skb_prepare_unicast*
+	 */
+	ethhdr = eth_hdr(skb);
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
 	/* inform the destination node that we are still missing a correct route
-- 
1.7.10.4

