Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 20 Jan 2014 11:00:19 +0100
Message-Id: <1390212019-9681-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: fix potential kernel
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

Introduced-by: b46c60b9e1ee7a1909c542413a85875a750955d6
("batman-adv: improve unicast packet (re)routing")

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Changes v3:
* now rebased on maint
* added "Introduced-by"
* removed "NOTE TO..." paragraph
  (still can't be applied as is to kernels < 3.9)

 send.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/send.c b/send.c
index b0a3d76..50df184 100644
--- a/send.c
+++ b/send.c
@@ -281,6 +281,10 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
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

