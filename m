Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Jun 2017 09:20:30 +0200
Message-Id: <20170618072032.23937-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: convert many more places to
 skb_put_zero()
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

There were many places that my previous spatch didn't find,
as pointed out by yuan linyu in various patches.

The following spatch found many more and also removes the
now unnecessary casts:

    @@
    identifier p, p2;
    expression len;
    expression skb;
    type t, t2;
    @@
    (
    -p = skb_put(skb, len);
    +p = skb_put_zero(skb, len);
    |
    -p = (t)skb_put(skb, len);
    +p = skb_put_zero(skb, len);
    )
    ... when != p
    (
    p2 = (t2)p;
    -memset(p2, 0, len);
    |
    -memset(p, 0, len);
    )

    @@
    type t, t2;
    identifier p, p2;
    expression skb;
    @@
    t *p;
    ...
    (
    -p = skb_put(skb, sizeof(t));
    +p = skb_put_zero(skb, sizeof(t));
    |
    -p = (t *)skb_put(skb, sizeof(t));
    +p = skb_put_zero(skb, sizeof(t));
    )
    ... when != p
    (
    p2 = (t2)p;
    -memset(p2, 0, sizeof(*p));
    |
    -memset(p, 0, sizeof(*p));
    )

    @@
    expression skb, len;
    @@
    -memset(skb_put(skb, len), 0, len);
    +skb_put_zero(skb, len);

Apply it to the tree (with one manual fixup to keep the
comment in vxlan.c, which spatch removed.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is already part of net-next. Only the compat code is new.

 compat-include/linux/skbuff.h | 13 +++++++++++++
 net/batman-adv/bat_v_elp.c    |  3 +--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 95f645ad..02bc11de 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -76,4 +76,17 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 13, 0)
+
+static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
+{
+	void *tmp = skb_put(skb, len);
+
+	memset(tmp, 0, len);
+
+	return tmp;
+}
+
+#endif /* < KERNEL_VERSION(4, 13, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_ */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index b58007b7..bd1064d9 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -346,9 +346,8 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
-	memset(elp_packet, 0, BATADV_ELP_HLEN);
 
 	elp_packet->packet_type = BATADV_ELP;
 	elp_packet->version = BATADV_COMPAT_VERSION;
-- 
2.11.0

