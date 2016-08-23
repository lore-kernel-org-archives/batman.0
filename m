Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 23 Aug 2016 03:13:03 +0200
Message-Id: <20160823011303.18487-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix elp packet data
	reservation
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

The skb_reserve() call only reserved headroom for the mac header, but
not the elp packet header itself.

Fixing this by using skb_put()'ing towards the skb tail instead of
skb_push()'ing towards the skb head.

Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Changes in v2:
* just switch from skb_push() to skb_put()
  => skb_put() actually returns the right point in the skb and is
     equivalent to a second skb->data assignment after skb_put() in this case
* batamn-adv -> batman-adv
* explicitly directed to maint
 

 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index df42eb1..63762b3 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -334,7 +334,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_push(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_buff = skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
 	memset(elp_packet, 0, BATADV_ELP_HLEN);
 
-- 
2.1.4

