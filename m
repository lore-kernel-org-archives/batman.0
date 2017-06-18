Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Jun 2017 09:20:31 +0200
Message-Id: <20170618072032.23937-2-sven@narfation.org>
In-Reply-To: <20170618072032.23937-1-sven@narfation.org>
References: <20170618072032.23937-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: introduce and use
 skb_put_data()
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

From: Johannes Berg <johannes.berg@intel.com>

A common pattern with skb_put() is to just want to memcpy()
some data into the new space, introduce skb_put_data() for
this.

An spatch similar to the one for skb_put_zero() converts many
of the places using it:

    @@
    identifier p, p2;
    expression len, skb, data;
    type t, t2;
    @@
    (
    -p = skb_put(skb, len);
    +p = skb_put_data(skb, data, len);
    |
    -p = (t)skb_put(skb, len);
    +p = skb_put_data(skb, data, len);
    )
    (
    p2 = (t2)p;
    -memcpy(p2, data, len);
    |
    -memcpy(p, data, len);
    )

    @@
    type t, t2;
    identifier p, p2;
    expression skb, data;
    @@
    t *p;
    ...
    (
    -p = skb_put(skb, sizeof(t));
    +p = skb_put_data(skb, data, sizeof(t));
    |
    -p = (t *)skb_put(skb, sizeof(t));
    +p = skb_put_data(skb, data, sizeof(t));
    )
    (
    p2 = (t2)p;
    -memcpy(p2, data, sizeof(*p));
    |
    -memcpy(p, data, sizeof(*p));
    )

    @@
    expression skb, len, data;
    @@
    -memcpy(skb_put(skb, len), data, len);
    +skb_put_data(skb, data, len);

(again, manually post-processed to retain some comments)

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is already part of net-next. Only the compat code is new.

 compat-include/linux/skbuff.h  | 10 ++++++++++
 net/batman-adv/bat_iv_ogm.c    |  4 ++--
 net/batman-adv/bat_v_ogm.c     |  6 ++----
 net/batman-adv/fragmentation.c |  3 +--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 02bc11de..23677e27 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -87,6 +87,16 @@ static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
 	return tmp;
 }
 
+static inline void *skb_put_data(struct sk_buff *skb, const void *data,
+				 unsigned int len)
+{
+	void *tmp = skb_put(skb, len);
+
+	memcpy(tmp, data, len);
+
+	return tmp;
+}
+
 #endif /* < KERNEL_VERSION(4, 13, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index fa8d6b47..a3501173 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -732,8 +732,8 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 	unsigned char *skb_buff;
 	unsigned long new_direct_link_flag;
 
-	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
-	memcpy(skb_buff, packet_buff, packet_len);
+	skb_buff = skb_put_data(forw_packet_aggr->skb, packet_buff,
+				packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03a35c9f..1e3dc374 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -166,8 +166,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	pkt_buff = skb_put(skb, ogm_buff_len);
-	memcpy(pkt_buff, ogm_buff, ogm_buff_len);
+	pkt_buff = skb_put_data(skb, ogm_buff, ogm_buff_len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
@@ -382,8 +381,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		goto out;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_buff = skb_put(skb, packet_len);
-	memcpy(skb_buff, ogm_received, packet_len);
+	skb_buff = skb_put_data(skb, ogm_received, packet_len);
 
 	/* apply forward penalty */
 	ogm_forward = (struct batadv_ogm2_packet *)skb_buff;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 8f964bea..a98cf110 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -296,8 +296,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	/* Copy the payload of the each fragment into the last skb */
 	hlist_for_each_entry(entry, chain, list) {
 		size = entry->skb->len - hdr_size;
-		memcpy(skb_put(skb_out, size), entry->skb->data + hdr_size,
-		       size);
+		skb_put_data(skb_out, entry->skb->data + hdr_size, size);
 	}
 
 free:
-- 
2.11.0

