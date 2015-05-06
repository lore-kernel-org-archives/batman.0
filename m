Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Wed,  6 May 2015 21:29:22 +0200
Message-Id: <1430940562-12148-4-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
References: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 3/3] compat: Compat code for IGMP/MLD
 report unicast forwarding
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

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile                              |    4 +
 compat-include/linux/igmp.h           |   13 ++
 compat-include/linux/skbuff.h         |   14 +++
 compat-include/net/addrconf.h         |   13 ++
 compat-include/net/ip6_checksum.h     |   18 +++
 compat-include/net/ipv6.h             |   17 +++
 compat-include/net/mld.h              |   52 ++++++++
 compat-sources/Makefile               |    3 +
 compat-sources/net/core/skbuff.c      |  136 +++++++++++++++++++++
 compat-sources/net/ipv4/igmp.c        |  169 ++++++++++++++++++++++++++
 compat-sources/net/ipv6/mcast_snoop.c |  216 +++++++++++++++++++++++++++++++++
 11 files changed, 655 insertions(+)
 create mode 100644 compat-include/linux/igmp.h
 create mode 100644 compat-include/net/addrconf.h
 create mode 100644 compat-include/net/ip6_checksum.h
 create mode 100644 compat-include/net/ipv6.h
 create mode 100644 compat-include/net/mld.h
 create mode 100644 compat-sources/Makefile
 create mode 100644 compat-sources/net/core/skbuff.c
 create mode 100644 compat-sources/net/ipv4/igmp.c
 create mode 100644 compat-sources/net/ipv6/mcast_snoop.c

diff --git a/Makefile b/Makefile
index ee3be1d..69056d7 100644
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,10 @@ ifneq ($(REVISION),)
 NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
+include $(PWD)/compat-sources/Makefile
+
+export batman-adv-y
+
 BUILD_FLAGS := \
 	M=$(PWD)/net/batman-adv \
 	CONFIG_BATMAN_ADV=m \
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
new file mode 100644
index 0000000..f61ab79
--- /dev/null
+++ b/compat-include/linux/igmp.h
@@ -0,0 +1,13 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_
+
+#include <linux/version.h>
+#include_next <linux/igmp.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IGMP_H_ */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index d363cc0..1d4f569 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -89,6 +89,20 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
 #define pskb_copy_for_clone pskb_copy
 
+__sum16 skb_checksum_simple_validate(struct sk_buff *skb);
+
+__sum16
+skb_checksum_validate(struct sk_buff *skb, int proto,
+		      __wsum (*compute_pseudo)(struct sk_buff *skb, int proto));
+
 #endif /* < KERNEL_VERSION(3, 16, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
+				     unsigned int transport_len,
+				     __sum16(*skb_chkf)(struct sk_buff *skb));
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_SKBUFF_H_ */
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
new file mode 100644
index 0000000..69c45d0
--- /dev/null
+++ b/compat-include/net/addrconf.h
@@ -0,0 +1,13 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_
+
+#include <linux/version.h>
+#include_next <net/addrconf.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed);
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_ */
diff --git a/compat-include/net/ip6_checksum.h b/compat-include/net/ip6_checksum.h
new file mode 100644
index 0000000..fda0c07
--- /dev/null
+++ b/compat-include/net/ip6_checksum.h
@@ -0,0 +1,18 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_
+
+#include <linux/version.h>
+#include_next <net/ip6_checksum.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+static inline __wsum ip6_compute_pseudo(struct sk_buff *skb, int proto)
+{
+	return ~csum_unfold(csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+					    &ipv6_hdr(skb)->daddr,
+					    skb->len, proto, 0));
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_NET_IP6_CHECKSUM_H_ */
diff --git a/compat-include/net/ipv6.h b/compat-include/net/ipv6.h
new file mode 100644
index 0000000..1e190d8
--- /dev/null
+++ b/compat-include/net/ipv6.h
@@ -0,0 +1,17 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_
+
+#include <linux/version.h>
+#include_next <net/ipv6.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
+
+#define ipv6_skip_exthdr(skb, start, nexthdrp, frag_offp) \
+	({ \
+		(void)frag_offp; \
+		ipv6_skip_exthdr(skb, start, nexthdrp); \
+	})
+
+#endif /* < KERNEL_VERSION(3, 3, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_NET_IPV6_H_ */
diff --git a/compat-include/net/mld.h b/compat-include/net/mld.h
new file mode 100644
index 0000000..e041eb6
--- /dev/null
+++ b/compat-include/net/mld.h
@@ -0,0 +1,52 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_MLD_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_MLD_H_
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 35)
+#include_next <net/mld.h>
+#endif /* >= KERNEL_VERSION(2, 6, 35) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
+struct mld_msg {
+	struct icmp6hdr		mld_hdr;
+	struct in6_addr		mld_mca;
+};
+
+#define mld_type		mld_hdr.icmp6_type
+
+struct mld2_grec {
+	__u8		grec_type;
+	__u8		grec_auxwords;
+	__be16		grec_nsrcs;
+	struct in6_addr	grec_mca;
+	struct in6_addr	grec_src[0];
+};
+
+struct mld2_report {
+	struct icmp6hdr		mld2r_hdr;
+	struct mld2_grec	mld2r_grec[0];
+};
+
+struct mld2_query {
+	struct icmp6hdr		mld2q_hdr;
+	struct in6_addr		mld2q_mca;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8			mld2q_qrv:3,
+				mld2q_suppress:1,
+				mld2q_resv2:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8			mld2q_resv2:4,
+				mld2q_suppress:1,
+				mld2q_qrv:3;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	__u8			mld2q_qqic;
+	__be16			mld2q_nsrcs;
+	struct in6_addr		mld2q_srcs[0];
+};
+
+#endif /* < KERNEL_VERSION(2, 6, 35) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_NET_MLD_H_ */
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
new file mode 100644
index 0000000..c364ded
--- /dev/null
+++ b/compat-sources/Makefile
@@ -0,0 +1,3 @@
+batman-adv-y += ../../compat-sources/net/core/skbuff.o
+batman-adv-y += ../../compat-sources/net/ipv4/igmp.o
+batman-adv-y += ../../compat-sources/net/ipv6/mcast_snoop.o
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
new file mode 100644
index 0000000..eb15adf
--- /dev/null
+++ b/compat-sources/net/core/skbuff.c
@@ -0,0 +1,136 @@
+#include <linux/ipv6.h>
+#include <linux/skbuff.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+__sum16 skb_checksum_simple_validate(struct sk_buff *skb)
+{
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		if (!csum_fold(skb->csum))
+			break;
+		/* fall through */
+	case CHECKSUM_NONE:
+		skb->csum = 0;
+		if (skb_checksum_complete(skb))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+__sum16
+skb_checksum_validate(struct sk_buff *skb, int proto,
+		      __wsum (*compute_pseudo)(struct sk_buff *skb, int proto))
+{
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		if (!csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr, skb->len,
+				     IPPROTO_ICMPV6, skb->csum))
+			break;
+		/*FALLTHROUGH*/
+	case CHECKSUM_NONE:
+		skb->csum = ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
+							 &ip6h->daddr,
+							 skb->len,
+							 IPPROTO_ICMPV6, 0));
+		if (__skb_checksum_complete(skb))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+/**
+ * skb_checksum_maybe_trim - maybe trims the given skb
+ * @skb: the skb to check
+ * @transport_len: the data length beyond the network header
+ *
+ * Checks whether the given skb has data beyond the given transport length.
+ * If so, returns a cloned skb trimmed to this transport length.
+ * Otherwise returns the provided skb. Returns NULL in error cases
+ * (e.g. transport_len exceeds skb length or out-of-memory).
+ *
+ * Caller needs to set the skb transport header and release the returned skb.
+ * Provided skb is consumed.
+ */
+static struct sk_buff *skb_checksum_maybe_trim(struct sk_buff *skb,
+					       unsigned int transport_len)
+{
+	struct sk_buff *skb_chk;
+	unsigned int len = skb_transport_offset(skb) + transport_len;
+	int ret;
+
+	if (skb->len < len) {
+		kfree_skb(skb);
+		return NULL;
+	} else if (skb->len == len) {
+		return skb;
+	}
+
+	skb_chk = skb_clone(skb, GFP_ATOMIC);
+	kfree_skb(skb);
+
+	if (!skb_chk)
+		return NULL;
+
+	ret = pskb_trim_rcsum(skb_chk, len);
+	if (ret) {
+		kfree_skb(skb_chk);
+		return NULL;
+	}
+
+	return skb_chk;
+}
+
+/**
+ * skb_checksum_trimmed - validate checksum of an skb
+ * @skb: the skb to check
+ * @transport_len: the data length beyond the network header
+ * @skb_chkf: checksum function to use
+ *
+ * Applies the given checksum function skb_chkf to the provided skb.
+ * Returns a checked and maybe trimmed skb. Returns NULL on error.
+ *
+ * If the skb has data beyond the given transport length, then a
+ * trimmed & cloned skb is checked and returned.
+ *
+ * Caller needs to set the skb transport header and release the returned skb.
+ * Provided skb is consumed.
+ */
+struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
+				     unsigned int transport_len,
+				     __sum16(*skb_chkf)(struct sk_buff *skb))
+{
+	struct sk_buff *skb_chk;
+	unsigned int offset = skb_transport_offset(skb);
+	__sum16 ret;
+
+	skb_chk = skb_checksum_maybe_trim(skb, transport_len);
+	if (!skb_chk)
+		return NULL;
+
+	if (!pskb_may_pull(skb_chk, offset)) {
+		kfree_skb(skb_chk);
+		return NULL;
+	}
+
+	__skb_pull(skb_chk, offset);
+	ret = skb_chkf(skb_chk);
+	__skb_push(skb_chk, offset);
+
+	if (ret) {
+		kfree_skb(skb_chk);
+		return NULL;
+	}
+
+	return skb_chk;
+}
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
new file mode 100644
index 0000000..7dd69d7
--- /dev/null
+++ b/compat-sources/net/ipv4/igmp.c
@@ -0,0 +1,169 @@
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+#include <linux/igmp.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+
+static int ip_mc_check_iphdr(struct sk_buff *skb)
+{
+	const struct iphdr *iph;
+	unsigned int len;
+	unsigned int offset = skb_network_offset(skb) + sizeof(*iph);
+
+	if (!pskb_may_pull(skb, offset))
+		return -EINVAL;
+
+	iph = ip_hdr(skb);
+
+	if (iph->version != 4 || ip_hdrlen(skb) < sizeof(*iph))
+		return -EINVAL;
+
+	offset += ip_hdrlen(skb) - sizeof(*iph);
+
+	if (!pskb_may_pull(skb, offset))
+		return -EINVAL;
+
+	iph = ip_hdr(skb);
+
+	if (unlikely(ip_fast_csum((u8 *)iph, iph->ihl)))
+		return -EINVAL;
+
+	len = skb_network_offset(skb) + ntohs(iph->tot_len);
+	if (skb->len < len || len < offset)
+		return -EINVAL;
+
+	skb_set_transport_header(skb, offset);
+
+	return 0;
+}
+
+static int ip_mc_check_igmp_reportv3(struct sk_buff *skb)
+{
+	unsigned int len = skb_transport_offset(skb);
+
+	len += sizeof(struct igmpv3_report);
+
+	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+}
+
+static int ip_mc_check_igmp_query(struct sk_buff *skb)
+{
+	unsigned int len = skb_transport_offset(skb);
+
+	len += sizeof(struct igmphdr);
+	if (skb->len < len)
+		return -EINVAL;
+
+	/* IGMPv{1,2}? */
+	if (skb->len != len) {
+		/* or IGMPv3? */
+		len += sizeof(struct igmpv3_query) - sizeof(struct igmphdr);
+		if (skb->len < len || !pskb_may_pull(skb, len))
+			return -EINVAL;
+	}
+
+	/* RFC2236+RFC3376 (IGMPv2+IGMPv3) require the multicast link layer
+	 * all-systems destination addresses (224.0.0.1) for general queries
+	 */
+	if (!igmp_hdr(skb)->group &&
+	    ip_hdr(skb)->daddr != htonl(INADDR_ALLHOSTS_GROUP))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ip_mc_check_igmp_msg(struct sk_buff *skb)
+{
+	switch (igmp_hdr(skb)->type) {
+	case IGMP_HOST_LEAVE_MESSAGE:
+	case IGMP_HOST_MEMBERSHIP_REPORT:
+	case IGMPV2_HOST_MEMBERSHIP_REPORT:
+		/* fall through */
+		return 0;
+	case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		return ip_mc_check_igmp_reportv3(skb);
+	case IGMP_HOST_MEMBERSHIP_QUERY:
+		return ip_mc_check_igmp_query(skb);
+	default:
+		return -ENOMSG;
+	}
+}
+
+static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
+{
+	return skb_checksum_simple_validate(skb);
+}
+
+static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+
+{
+	struct sk_buff *skb_chk;
+	unsigned int transport_len;
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
+	int ret;
+
+	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
+
+	skb_get(skb);
+	skb_chk = skb_checksum_trimmed(skb, transport_len,
+				       ip_mc_validate_checksum);
+	if (!skb_chk)
+		return -EINVAL;
+
+	if (!pskb_may_pull(skb_chk, len)) {
+		kfree_skb(skb_chk);
+		return -EINVAL;
+	}
+
+	ret = ip_mc_check_igmp_msg(skb_chk);
+	if (ret) {
+		kfree_skb(skb_chk);
+		return ret;
+	}
+
+	if (skb_trimmed)
+		*skb_trimmed = skb_chk;
+	else
+		kfree_skb(skb_chk);
+
+	return 0;
+}
+
+/**
+ * ip_mc_check_igmp - checks whether this is a sane IGMP packet
+ * @skb: the skb to validate
+ * @skb_trimmed: to store an skb pointer trimmed to IPv4 packet tail (optional)
+ *
+ * Checks whether an IPv4 packet is a valid IGMP packet. If so sets
+ * skb network and transport headers accordingly and returns zero.
+ *
+ * -EINVAL: A broken packet was detected, i.e. it violates some internet
+ *  standard
+ * -ENOMSG: IP header validation succeeded but it is not an IGMP packet.
+ * -ENOMEM: A memory allocation failure happened.
+ *
+ * Optionally, an skb pointer might be provided via skb_trimmed (or set it
+ * to NULL): After parsing an IGMP packet successfully it will point to
+ * an skb which has its tail aligned to the IP packet end. This might
+ * either be the originally provided skb or a trimmed, cloned version if
+ * the skb frame had data beyond the IP packet. A cloned skb allows us
+ * to leave the original skb and its full frame unchanged (which might be
+ * desirable for layer 2 frame jugglers).
+ *
+ * The caller needs to release a reference count from any returned skb_trimmed.
+ */
+int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+{
+	int ret = ip_mc_check_iphdr(skb);
+
+	if (ret < 0)
+		return ret;
+
+	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
+		return -ENOMSG;
+
+	return __ip_mc_check_igmp(skb, skb_trimmed);
+}
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
new file mode 100644
index 0000000..32a57bc
--- /dev/null
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -0,0 +1,216 @@
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+/* Copyright (C) 2010: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
+ * Copyright (C) 2015: Linus Lüssing <linus.luessing@c0d3.blue>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *
+ * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
+ */
+
+#include <linux/skbuff.h>
+#include <net/ipv6.h>
+#include <net/mld.h>
+#include <net/addrconf.h>
+#include <net/ip6_checksum.h>
+
+static int ipv6_mc_check_ip6hdr(struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6h;
+	unsigned int len;
+	unsigned int offset = skb_network_offset(skb) + sizeof(*ip6h);
+
+	if (!pskb_may_pull(skb, offset))
+		return -EINVAL;
+
+	ip6h = ipv6_hdr(skb);
+
+	if (ip6h->version != 6)
+		return -EINVAL;
+
+	len = offset + ntohs(ip6h->payload_len);
+	if (skb->len < len || len <= offset)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ipv6_mc_check_exthdrs(struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6h;
+	int offset;
+	u8 nexthdr;
+	__be16 frag_off;
+
+	ip6h = ipv6_hdr(skb);
+
+	if (ip6h->nexthdr != IPPROTO_HOPOPTS)
+		return -ENOMSG;
+
+	nexthdr = ip6h->nexthdr;
+	offset = skb_network_offset(skb) + sizeof(*ip6h);
+	offset = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
+
+	if (offset < 0)
+		return -EINVAL;
+
+	if (nexthdr != IPPROTO_ICMPV6)
+		return -ENOMSG;
+
+	skb_set_transport_header(skb, offset);
+
+	return 0;
+}
+
+static int ipv6_mc_check_mld_reportv2(struct sk_buff *skb)
+{
+	unsigned int len = skb_transport_offset(skb);
+
+	len += sizeof(struct mld2_report);
+
+	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+}
+
+static int ipv6_mc_check_mld_query(struct sk_buff *skb)
+{
+	struct mld_msg *mld;
+	unsigned int len = skb_transport_offset(skb);
+
+	/* RFC2710+RFC3810 (MLDv1+MLDv2) require link-local source addresses */
+	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL))
+		return -EINVAL;
+
+	len += sizeof(struct mld_msg);
+	if (skb->len < len)
+		return -EINVAL;
+
+	/* MLDv1? */
+	if (skb->len != len) {
+		/* or MLDv2? */
+		len += sizeof(struct mld2_query) - sizeof(struct mld_msg);
+		if (skb->len < len || !pskb_may_pull(skb, len))
+			return -EINVAL;
+	}
+
+	mld = (struct mld_msg *)skb_transport_header(skb);
+
+	/* RFC2710+RFC3810 (MLDv1+MLDv2) require the multicast link layer
+	 * all-nodes destination address (ff02::1) for general queries
+	 */
+	if (ipv6_addr_any(&mld->mld_mca) &&
+	    !ipv6_addr_is_ll_all_nodes(&ipv6_hdr(skb)->daddr))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ipv6_mc_check_mld_msg(struct sk_buff *skb)
+{
+	struct mld_msg *mld = (struct mld_msg *)skb_transport_header(skb);
+
+	switch (mld->mld_type) {
+	case ICMPV6_MGM_REDUCTION:
+	case ICMPV6_MGM_REPORT:
+		/* fall through */
+		return 0;
+	case ICMPV6_MLD2_REPORT:
+		return ipv6_mc_check_mld_reportv2(skb);
+	case ICMPV6_MGM_QUERY:
+		return ipv6_mc_check_mld_query(skb);
+	default:
+		return -ENOMSG;
+	}
+}
+
+static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
+{
+	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
+}
+
+static int __ipv6_mc_check_mld(struct sk_buff *skb,
+			       struct sk_buff **skb_trimmed)
+
+{
+	struct sk_buff *skb_chk = NULL;
+	unsigned int transport_len;
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
+	int ret;
+
+	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
+	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
+
+	skb_get(skb);
+	skb_chk = skb_checksum_trimmed(skb, transport_len,
+				       ipv6_mc_validate_checksum);
+	if (!skb_chk)
+		return -EINVAL;
+
+	if (!pskb_may_pull(skb_chk, len)) {
+		kfree_skb(skb_chk);
+		return -EINVAL;
+	}
+
+	ret = ipv6_mc_check_mld_msg(skb_chk);
+	if (ret) {
+		kfree_skb(skb_chk);
+		return ret;
+	}
+
+	if (skb_trimmed)
+		*skb_trimmed = skb_chk;
+	else
+		kfree_skb(skb_chk);
+
+	return 0;
+}
+
+/**
+ * ipv6_mc_check_mld - checks whether this is a sane MLD packet
+ * @skb: the skb to validate
+ * @skb_trimmed: to store an skb pointer trimmed to IPv6 packet tail (optional)
+ *
+ * Checks whether an IPv6 packet is a valid MLD packet. If so sets
+ * skb network and transport headers accordingly and returns zero.
+ *
+ * -EINVAL: A broken packet was detected, i.e. it violates some internet
+ *  standard
+ * -ENOMSG: IP header validation succeeded but it is not an MLD packet.
+ * -ENOMEM: A memory allocation failure happened.
+ *
+ * Optionally, an skb pointer might be provided via skb_trimmed (or set it
+ * to NULL): After parsing an MLD packet successfully it will point to
+ * an skb which has its tail aligned to the IP packet end. This might
+ * either be the originally provided skb or a trimmed, cloned version if
+ * the skb frame had data beyond the IP packet. A cloned skb allows us
+ * to leave the original skb and its full frame unchanged (which might be
+ * desirable for layer 2 frame jugglers).
+ *
+ * The caller needs to release a reference count from any returned skb_trimmed.
+ */
+int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
+{
+	int ret;
+
+	ret = ipv6_mc_check_ip6hdr(skb);
+	if (ret < 0)
+		return ret;
+
+	ret = ipv6_mc_check_exthdrs(skb);
+	if (ret < 0)
+		return ret;
+
+	return __ipv6_mc_check_mld(skb, skb_trimmed);
+}
+
+#endif /* < KERNEL_VERSION(4, 2, 0) */
-- 
1.7.10.4

