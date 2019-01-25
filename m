Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Jan 2019 09:01:32 +0100
Message-Id: <20190125080132.10524-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: simplify ip_mc_check_igmp() and
 ipv6_mc_check_mld() calls
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

From: Linus Lüssing <linus.luessing@c0d3.blue>

This patch refactors ip_mc_check_igmp(), ipv6_mc_check_mld() and
their callers (more precisely, the Linux bridge) to not rely on
the skb_trimmed parameter anymore.

An skb with its tail trimmed to the IP packet length was initially
introduced for the following three reasons:

1) To be able to verify the ICMPv6 checksum.
2) To be able to distinguish the version of an IGMP or MLD query.
   They are distinguishable only by their size.
3) To avoid parsing data for an IGMPv3 or MLDv2 report that is
   beyond the IP packet but still within the skb.

The first case still uses a cloned and potentially trimmed skb to
verfiy. However, there is no need to propagate it to the caller.
For the second and third case explicit IP packet length checks were
added.

This hopefully makes ip_mc_check_igmp() and ipv6_mc_check_mld() easier
to read and verfiy, as well as easier to use.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Added compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/igmp.h           | 12 +++++++++++-
 compat-include/net/addrconf.h         | 12 +++++++++++-
 compat-sources/net/ipv4/igmp.c        | 22 ++++------------------
 compat-sources/net/ipv6/mcast_snoop.c | 23 ++++-------------------
 net/batman-adv/multicast.c            |  4 ++--
 5 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index 59f55522..3aa64197 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -27,7 +27,17 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
 
-int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+int ip_mc_check_igmp(struct sk_buff *skb);
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0)
+
+static inline int batadv_ip_mc_check_igmp(struct sk_buff *skb)
+{
+	return ip_mc_check_igmp(skb, NULL);
+}
+
+#define ip_mc_check_igmp(skb) \
+	batadv_ip_mc_check_igmp(skb)
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index ca9d6935..a37a8e9f 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -27,7 +27,17 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
 
-int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+int ipv6_mc_check_mld(struct sk_buff *skb);
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0)
+
+static inline int batadv_ipv6_mc_check_mld(struct sk_buff *skb)
+{
+	return ipv6_mc_check_mld(skb, NULL);
+}
+
+#define ipv6_mc_check_mld(skb) \
+	batadv_ipv6_mc_check_mld(skb)
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
index 5eb149b7..ecb987d1 100644
--- a/compat-sources/net/ipv4/igmp.c
+++ b/compat-sources/net/ipv4/igmp.c
@@ -168,7 +168,7 @@ static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_simple_validate(skb);
 }
 
-static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+static int __ip_mc_check_igmp(struct sk_buff *skb)
 
 {
 	struct sk_buff *skb_chk;
@@ -195,10 +195,7 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 		return ret;
 	}
 
-	if (skb_trimmed)
-		*skb_trimmed = skb_chk;
-	else
-		kfree_skb(skb_chk);
+	kfree_skb(skb_chk);
 
 	return 0;
 }
@@ -206,7 +203,6 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 /**
  * ip_mc_check_igmp - checks whether this is a sane IGMP packet
  * @skb: the skb to validate
- * @skb_trimmed: to store an skb pointer trimmed to IPv4 packet tail (optional)
  *
  * Checks whether an IPv4 packet is a valid IGMP packet. If so sets
  * skb network and transport headers accordingly and returns zero.
@@ -215,18 +211,8 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
  *  standard
  * -ENOMSG: IP header validation succeeded but it is not an IGMP packet.
  * -ENOMEM: A memory allocation failure happened.
- *
- * Optionally, an skb pointer might be provided via skb_trimmed (or set it
- * to NULL): After parsing an IGMP packet successfully it will point to
- * an skb which has its tail aligned to the IP packet end. This might
- * either be the originally provided skb or a trimmed, cloned version if
- * the skb frame had data beyond the IP packet. A cloned skb allows us
- * to leave the original skb and its full frame unchanged (which might be
- * desirable for layer 2 frame jugglers).
- *
- * The caller needs to release a reference count from any returned skb_trimmed.
  */
-int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+int ip_mc_check_igmp(struct sk_buff *skb)
 {
 	int ret = ip_mc_check_iphdr(skb);
 
@@ -236,7 +222,7 @@ int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
 		return -ENOMSG;
 
-	return __ip_mc_check_igmp(skb, skb_trimmed);
+	return __ip_mc_check_igmp(skb);
 }
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
index 8c380034..01b19969 100644
--- a/compat-sources/net/ipv6/mcast_snoop.c
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -139,8 +139,7 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int __ipv6_mc_check_mld(struct sk_buff *skb,
-			       struct sk_buff **skb_trimmed)
+static int __ipv6_mc_check_mld(struct sk_buff *skb)
 
 {
 	struct sk_buff *skb_chk = NULL;
@@ -168,10 +167,7 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
 		return ret;
 	}
 
-	if (skb_trimmed)
-		*skb_trimmed = skb_chk;
-	else
-		kfree_skb(skb_chk);
+	kfree_skb(skb_chk);
 
 	return 0;
 }
@@ -179,7 +175,6 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
 /**
  * ipv6_mc_check_mld - checks whether this is a sane MLD packet
  * @skb: the skb to validate
- * @skb_trimmed: to store an skb pointer trimmed to IPv6 packet tail (optional)
  *
  * Checks whether an IPv6 packet is a valid MLD packet. If so sets
  * skb network and transport headers accordingly and returns zero.
@@ -188,18 +183,8 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
  *  standard
  * -ENOMSG: IP header validation succeeded but it is not an MLD packet.
  * -ENOMEM: A memory allocation failure happened.
- *
- * Optionally, an skb pointer might be provided via skb_trimmed (or set it
- * to NULL): After parsing an MLD packet successfully it will point to
- * an skb which has its tail aligned to the IP packet end. This might
- * either be the originally provided skb or a trimmed, cloned version if
- * the skb frame had data beyond the IP packet. A cloned skb allows us
- * to leave the original skb and its full frame unchanged (which might be
- * desirable for layer 2 frame jugglers).
- *
- * The caller needs to release a reference count from any returned skb_trimmed.
  */
-int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+int ipv6_mc_check_mld(struct sk_buff *skb)
 {
 	int ret;
 
@@ -211,7 +196,7 @@ int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	if (ret < 0)
 		return ret;
 
-	return __ipv6_mc_check_mld(skb, skb_trimmed);
+	return __ipv6_mc_check_mld(skb);
 }
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 5de6a375..f91b1b62 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -674,7 +674,7 @@ static void batadv_mcast_mla_update(struct work_struct *work)
  */
 static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
 {
-	if (ip_mc_check_igmp(skb, NULL) < 0)
+	if (ip_mc_check_igmp(skb) < 0)
 		return false;
 
 	switch (igmp_hdr(skb)->type) {
@@ -741,7 +741,7 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  */
 static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
 {
-	if (ipv6_mc_check_mld(skb, NULL) < 0)
+	if (ipv6_mc_check_mld(skb) < 0)
 		return false;
 
 	switch (icmp6_hdr(skb)->icmp6_type) {
-- 
2.11.0

