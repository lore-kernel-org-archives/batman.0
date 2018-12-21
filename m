Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 21 Dec 2018 16:15:09 +0100
Message-Id: <20181221151511.14923-3-linus.luessing@c0d3.blue>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH net-next 2/4] bridge: simplify
 ip_mc_check_igmp() and ipv6_mc_check_mld() internals
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

With this patch the internal use of the skb_trimmed is reduced to
the ICMPv6/IGMP checksum verification. And for the length checks
the newly introduced helper functions are used instead of calculating
and checking with skb->len directly.

These changes should hopefully make it easier to verify that length
checks are performed properly.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/ipv4/igmp.c        | 51 ++++++++++++++++++-----------------------
 net/ipv6/mcast_snoop.c | 62 ++++++++++++++++++++++++--------------------------
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b1f6d93282d7..a40e48ded10d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1493,22 +1493,22 @@ static int ip_mc_check_igmp_reportv3(struct sk_buff *skb)
 
 	len += sizeof(struct igmpv3_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ip_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ip_mc_check_igmp_query(struct sk_buff *skb)
 {
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct igmphdr);
-	if (skb->len < len)
-		return -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	unsigned int len;
 
 	/* IGMPv{1,2}? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct igmphdr)) {
 		/* or IGMPv3? */
-		len += sizeof(struct igmpv3_query) - sizeof(struct igmphdr);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct igmpv3_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct igmpv3_query);
+		if (!ip_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -1544,35 +1544,24 @@ static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_simple_validate(skb);
 }
 
-static int __ip_mc_check_igmp(struct sk_buff *skb)
-
+static int ip_mc_check_igmp_csum(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk;
-	unsigned int transport_len;
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
-	int ret = -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
+	if (!ip_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ip_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ip_mc_check_igmp_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1600,7 +1589,11 @@ int ip_mc_check_igmp(struct sk_buff *skb)
 	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
 		return -ENOMSG;
 
-	return __ip_mc_check_igmp(skb);
+	ret = ip_mc_check_igmp_csum(skb);
+	if (ret < 0)
+		return ret;
+
+	return ip_mc_check_igmp_msg(skb);
 }
 EXPORT_SYMBOL(ip_mc_check_igmp);
 
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index 1a917dc80d5e..a72ddfc40eb3 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -77,27 +77,27 @@ static int ipv6_mc_check_mld_reportv2(struct sk_buff *skb)
 
 	len += sizeof(struct mld2_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ipv6_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 {
+	unsigned int transport_len = ipv6_transport_len(skb);
 	struct mld_msg *mld;
-	unsigned int len = skb_transport_offset(skb);
+	unsigned int len;
 
 	/* RFC2710+RFC3810 (MLDv1+MLDv2) require link-local source addresses */
 	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL))
 		return -EINVAL;
 
-	len += sizeof(struct mld_msg);
-	if (skb->len < len)
-		return -EINVAL;
-
 	/* MLDv1? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct mld_msg)) {
 		/* or MLDv2? */
-		len += sizeof(struct mld2_query) - sizeof(struct mld_msg);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct mld2_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct mld2_query);
+		if (!ipv6_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -115,7 +115,13 @@ static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 
 static int ipv6_mc_check_mld_msg(struct sk_buff *skb)
 {
-	struct mld_msg *mld = (struct mld_msg *)skb_transport_header(skb);
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
+	struct mld_msg *mld;
+
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
+
+	mld = (struct mld_msg *)skb_transport_header(skb);
 
 	switch (mld->mld_type) {
 	case ICMPV6_MGM_REDUCTION:
@@ -136,36 +142,24 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int __ipv6_mc_check_mld(struct sk_buff *skb)
-
+static int ipv6_mc_check_icmpv6(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk = NULL;
-	unsigned int transport_len;
-	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
-	int ret = -EINVAL;
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	unsigned int transport_len = ipv6_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
-	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ipv6_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ipv6_mc_check_mld_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -195,6 +189,10 @@ int ipv6_mc_check_mld(struct sk_buff *skb)
 	if (ret < 0)
 		return ret;
 
-	return __ipv6_mc_check_mld(skb);
+	ret = ipv6_mc_check_icmpv6(skb);
+	if (ret < 0)
+		return ret;
+
+	return ipv6_mc_check_mld_msg(skb);
 }
 EXPORT_SYMBOL(ipv6_mc_check_mld);
-- 
2.11.0

