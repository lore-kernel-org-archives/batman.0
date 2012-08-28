Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Tue, 28 Aug 2012 21:06:08 +0800
Message-ID: <CAPgLHd8jAk-4C1w4Z-q=WeMT_SgB99HCrGCtEPa5Xe4VYnZCOA@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove pointless conditional
	before kfree_skb()
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
To: lindner_marek@yahoo.de, siwu@hrz.tu-chemnitz.de, ordex@autistici.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn, b.a.t.m.a.n@lists.open-mesh.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove pointless conditional before kfree_skb().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/batman-adv/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 3b4b2da..534dc46 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -99,8 +99,7 @@ void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 
 static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
-	if (forw_packet->skb)
-		kfree_skb(forw_packet->skb);
+	kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
 	kfree(forw_packet);

