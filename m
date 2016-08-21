Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 21 Aug 2016 05:25:32 +0200
Message-Id: <20160821032534.11074-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH (maint?) 1/3] batamn-adv: fix elp packet data
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

Looking at some tests today, we might have been lucky so far:
dev_alloc_skb(size = 32) seems to actually round the head- and tailroom
reservation to 64 bytes. So there actually is enough headroom for the
skb_push(). Not sure whether this is always the case though, so
unsure whether this should go to maint/stable.

Also switching skb_push() with skb_pull() instead of simply increasing
skb_reserve() by ELP_HLEN, because of the next patch in this series.
---
 net/batman-adv/bat_v_elp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index df42eb1..ea463bf 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -323,7 +323,6 @@ out:
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_elp_packet *elp_packet;
-	unsigned char *elp_buff;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
@@ -334,8 +333,9 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_push(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
-	elp_packet = (struct batadv_elp_packet *)elp_buff;
+	skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_packet = (struct batadv_elp_packet *)
+			hard_iface->bat_v.elp_skb->data;
 	memset(elp_packet, 0, BATADV_ELP_HLEN);
 
 	elp_packet->packet_type = BATADV_ELP;
-- 
2.1.4

