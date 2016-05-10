Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 10 May 2016 18:41:24 +0200
Message-Id: <1462898487-9696-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv15 1/4] batman-adv: Always flood IGMP/MLD
	reports
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

With this patch IGMP or MLD reports are always flooded. This is
necessary for the upcoming bridge integration to function without
multicast packet loss.

With the report handling so far bridges might miss interested multicast
listeners, leading to wrongly excluding ports from multicast packet
forwarding.

Currently we are treating IGMP/MLD reports, the messages bridges use to
learn about interested multicast listeners, just as any other multicast
packet: We try to send them to nodes matching its multicast destination.

Unfortunately, the destination address of reports of the older
IGMPv2/MLDv1 protocol families do not strictly adhere to their own
protocol: More precisely, the interested receiver, an IGMPv2 or MLDv1
querier, itself usually does not listen to the multicast destination
address of any reports.

Therefore with this patch we are simply excluding IGMP/MLD reports from
the multicast forwarding code path and keep flooding them. By that
any bridge receives them and can properly learn about listeners.

To avoid compatibility issues with older nodes not yet implementing this
report handling, we need to force them to flood reports: We do this by
bumping the multicast TVLV version to 2, effectively disabling their
multicast optimization.

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile                              |    4 +
 compat-include/linux/igmp.h           |   13 ++
 compat-include/linux/skbuff.h         |   14 ++
 compat-include/net/addrconf.h         |   13 ++
 compat-include/net/ip6_checksum.h     |   18 +++
 compat-include/net/ipv6.h             |   17 +++
 compat-sources/Makefile               |    3 +
 compat-sources/net/core/skbuff.c      |  212 +++++++++++++++++++++++++++++
 compat-sources/net/ipv4/igmp.c        |  241 +++++++++++++++++++++++++++++++++
 compat-sources/net/ipv6/mcast_snoop.c |  216 +++++++++++++++++++++++++++++
 net/batman-adv/Kconfig                |    2 +-
 net/batman-adv/multicast.c            |   85 ++++++++++--
 12 files changed, 825 insertions(+), 13 deletions(-)
 create mode 100644 compat-include/linux/igmp.h
 create mode 100644 compat-include/net/addrconf.h
 create mode 100644 compat-include/net/ip6_checksum.h
 create mode 100644 compat-include/net/ipv6.h
 create mode 100644 compat-sources/Makefile
 create mode 100644 compat-sources/net/core/skbuff.c
 create mode 100644 compat-sources/net/ipv4/igmp.c
 create mode 100644 compat-sources/net/ipv6/mcast_snoop.c

diff --git a/Makefile b/Makefile
index 5d2c058..fd6237c 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,10 @@ ifneq ($(REVISION),)
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
index b2cb161..9dd92a5 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -60,6 +60,20 @@
 
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
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
new file mode 100644
index 0000000..a45c202
--- /dev/null
+++ b/compat-sources/Makefile
@@ -0,0 +1,3 @@
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/core/skbuff.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv4/igmp.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv6/mcast_snoop.o
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
new file mode 100644
index 0000000..44d59dc
--- /dev/null
+++ b/compat-sources/net/core/skbuff.c
@@ -0,0 +1,212 @@
+/*
+ *	Routines having to do with the 'struct sk_buff' memory handlers.
+ *
+ *	Authors:	Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *			Florian La Roche <rzsfl@rz.uni-sb.de>
+ *
+ *	Fixes:
+ *		Alan Cox	:	Fixed the worst of the load
+ *					balancer bugs.
+ *		Dave Platt	:	Interrupt stacking fix.
+ *	Richard Kooijman	:	Timestamp fixes.
+ *		Alan Cox	:	Changed buffer format.
+ *		Alan Cox	:	destructor hook for AF_UNIX etc.
+ *		Linus Torvalds	:	Better skb_clone.
+ *		Alan Cox	:	Added skb_copy.
+ *		Alan Cox	:	Added all the changed routines Linus
+ *					only put in the headers
+ *		Ray VanTassle	:	Fixed --skb->lock in free
+ *		Alan Cox	:	skb_copy copy arp field
+ *		Andi Kleen	:	slabified it.
+ *		Robert Olsson	:	Removed skb_head_pool
+ *
+ *	NOTE:
+ *		The __skb_ routines should be called with interrupts
+ *	disabled, or you better be *real* sure that the operation is atomic
+ *	with respect to whatever list is being frobbed (e.g. via lock_sock()
+ *	or via disabling bottom half handlers, etc).
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/ipv6.h>
+#include <linux/skbuff.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+/* Compare with:
+ * "bridge: multicast: call skb_checksum_{simple_, }validate"
+ */
+__sum16 skb_checksum_simple_validate(struct sk_buff *skb)
+{
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		if (!csum_fold(skb->csum))
+			break;
+		/* fall through */
+	case CHECKSUM_NONE:
+		skb->csum = 0;
+		return skb_checksum_complete(skb);
+	}
+
+	return 0;
+}
+
+/* Watch out: Not as generic as upstream
+ * - redefines this method to only fit with ICMPV6
+ *
+ * Compare with:
+ * "bridge: multicast: call skb_checksum_{simple_, }validate"
+ */
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
+		return __skb_checksum_complete(skb);
+	}
+
+	return 0;
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
+
+static inline void skb_postpush_rcsum(struct sk_buff *skb,
+				      const void *start, unsigned int len)
+{
+	/* For performing the reverse operation to skb_postpull_rcsum(),
+	 * we can instead of ...
+	 *
+	 *   skb->csum = csum_add(skb->csum, csum_partial(start, len, 0));
+	 *
+	 * ... just use this equivalent version here to save a few
+	 * instructions. Feeding csum of 0 in csum_partial() and later
+	 * on adding skb->csum is equivalent to feed skb->csum in the
+	 * first place.
+	 */
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		skb->csum = csum_partial(start, len, skb->csum);
+}
+
+/**
+ *	skb_push_rcsum - push skb and update receive checksum
+ *	@skb: buffer to update
+ *	@len: length of data pulled
+ *
+ *	This function performs an skb_push on the packet and updates
+ *	the CHECKSUM_COMPLETE checksum.  It should be used on
+ *	receive path processing instead of skb_push unless you know
+ *	that the checksum difference is zero (e.g., a valid IP header)
+ *	or you are setting ip_summed to CHECKSUM_NONE.
+ */
+static unsigned char *skb_push_rcsum(struct sk_buff *skb, unsigned len)
+{
+	skb_push(skb, len);
+	skb_postpush_rcsum(skb, skb->data, len);
+	return skb->data;
+}
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
+	skb_pull_rcsum(skb_chk, offset);
+	ret = skb_chkf(skb_chk);
+	skb_push_rcsum(skb_chk, offset);
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
index 0000000..457a05e
--- /dev/null
+++ b/compat-sources/net/ipv4/igmp.c
@@ -0,0 +1,241 @@
+/*
+ *	Linux NET3:	Internet Group Management Protocol  [IGMP]
+ *
+ *	This code implements the IGMP protocol as defined in RFC1112. There has
+ *	been a further revision of this protocol since which is now supported.
+ *
+ *	If you have trouble with this module be careful what gcc you have used,
+ *	the older version didn't come out right using gcc 2.5.8, the newer one
+ *	seems to fall out with gcc 2.6.2.
+ *
+ *	Authors:
+ *		Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Fixes:
+ *
+ *		Alan Cox	:	Added lots of __inline__ to optimise
+ *					the memory usage of all the tiny little
+ *					functions.
+ *		Alan Cox	:	Dumped the header building experiment.
+ *		Alan Cox	:	Minor tweaks ready for multicast routing
+ *					and extended IGMP protocol.
+ *		Alan Cox	:	Removed a load of inline directives. Gcc 2.5.8
+ *					writes utterly bogus code otherwise (sigh)
+ *					fixed IGMP loopback to behave in the manner
+ *					desired by mrouted, fixed the fact it has been
+ *					broken since 1.3.6 and cleaned up a few minor
+ *					points.
+ *
+ *		Chih-Jen Chang	:	Tried to revise IGMP to Version 2
+ *		Tsu-Sheng Tsao		E-mail: chihjenc@scf.usc.edu and tsusheng@scf.usc.edu
+ *					The enhancements are mainly based on Steve Deering's
+ * 					ipmulti-3.5 source code.
+ *		Chih-Jen Chang	:	Added the igmp_get_mrouter_info and
+ *		Tsu-Sheng Tsao		igmp_set_mrouter_info to keep track of
+ *					the mrouted version on that device.
+ *		Chih-Jen Chang	:	Added the max_resp_time parameter to
+ *		Tsu-Sheng Tsao		igmp_heard_query(). Using this parameter
+ *					to identify the multicast router version
+ *					and do what the IGMP version 2 specified.
+ *		Chih-Jen Chang	:	Added a timer to revert to IGMP V2 router
+ *		Tsu-Sheng Tsao		if the specified time expired.
+ *		Alan Cox	:	Stop IGMP from 0.0.0.0 being accepted.
+ *		Alan Cox	:	Use GFP_ATOMIC in the right places.
+ *		Christian Daudt :	igmp timer wasn't set for local group
+ *					memberships but was being deleted,
+ *					which caused a "del_timer() called
+ *					from %p with timer not initialized\n"
+ *					message (960131).
+ *		Christian Daudt :	removed del_timer from
+ *					igmp_timer_expire function (960205).
+ *             Christian Daudt :       igmp_heard_report now only calls
+ *                                     igmp_timer_expire if tm->running is
+ *                                     true (960216).
+ *		Malcolm Beattie :	ttl comparison wrong in igmp_rcv made
+ *					igmp_heard_query never trigger. Expiry
+ *					miscalculation fixed in igmp_heard_query
+ *					and random() made to return unsigned to
+ *					prevent negative expiry times.
+ *		Alexey Kuznetsov:	Wrong group leaving behaviour, backport
+ *					fix from pending 2.1.x patches.
+ *		Alan Cox:		Forget to enable FDDI support earlier.
+ *		Alexey Kuznetsov:	Fixed leaving groups on device down.
+ *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
+ *		David L Stevens:	IGMPv3 support, with help from
+ *					Vinay Kulkarni
+ */
+
+#include <linux/igmp.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
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
index 0000000..3f46ed3
--- /dev/null
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -0,0 +1,216 @@
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
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0)
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
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f66930e..b7ba97d 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -66,7 +66,7 @@ config BATMAN_ADV_NC
 
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
-	depends on BATMAN_ADV
+	depends on BATMAN_ADV && INET
 	default n
 	help
 	  This option enables the multicast optimisation which aims to
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index c32f24f..b8662f1 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,7 +25,9 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
+#include <linux/icmpv6.h>
 #include <linux/if_ether.h>
+#include <linux/igmp.h>
 #include <linux/in6.h>
 #include <linux/in.h>
 #include <linux/ip.h>
@@ -236,7 +238,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	if (batadv_mcast_has_bridge(bat_priv)) {
 		if (bat_priv->mcast.enabled) {
 			batadv_tvlv_container_unregister(bat_priv,
-							 BATADV_TVLV_MCAST, 1);
+							 BATADV_TVLV_MCAST, 2);
 			bat_priv->mcast.enabled = false;
 		}
 
@@ -245,7 +247,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
-		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 2,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
 		bat_priv->mcast.enabled = true;
@@ -283,6 +285,31 @@ out:
 }
 
 /**
+ * batadv_mcast_is_report_ipv4 - check for IGMP reports
+ * @skb: the ethernet frame destined for the mesh
+ *
+ * This call might reallocate skb data.
+ *
+ * Checks whether the given frame is a valid IGMP report.
+ *
+ * Return: If so then true, otherwise false.
+ */
+static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
+{
+	if (ip_mc_check_igmp(skb, NULL) < 0)
+		return false;
+
+	switch (igmp_hdr(skb)->type) {
+	case IGMP_HOST_MEMBERSHIP_REPORT:
+	case IGMPV2_HOST_MEMBERSHIP_REPORT:
+	case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		return true;
+	}
+
+	return false;
+}
+
+/**
  * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv4 packet to check
@@ -304,6 +331,9 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*iphdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv4(skb))
+		return -EINVAL;
+
 	iphdr = ip_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -320,6 +350,31 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+/**
+ * batadv_mcast_is_report_ipv6 - check for MLD reports
+ * @skb: the ethernet frame destined for the mesh
+ *
+ * This call might reallocate skb data.
+ *
+ * Checks whether the given frame is a valid MLD report.
+ *
+ * Return: If so then true, otherwise false.
+ */
+static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
+{
+	if (ipv6_mc_check_mld(skb, NULL) < 0)
+		return false;
+
+	switch (icmp6_hdr(skb)->icmp6_type) {
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MLD2_REPORT:
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * batadv_mcast_forw_mode_check_ipv6 - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
@@ -341,6 +396,9 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*ip6hdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv6(skb))
+		return -EINVAL;
+
 	ip6hdr = ipv6_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -357,6 +415,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 	return 0;
 }
+#endif
 
 /**
  * batadv_mcast_forw_mode_check - check for optimized forwarding potential
@@ -385,9 +444,11 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
 							 is_unsnoopable);
+#if IS_ENABLED(CONFIG_IPV6)
 	case ETH_P_IPV6:
 		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
 							 is_unsnoopable);
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -728,18 +789,18 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
+ * batadv_mcast_tvlv_ogm_handler - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the multicast data
  * @tvlv_value_len: tvlv buffer length
  */
-static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
-					     struct batadv_orig_node *orig,
-					     u8 flags,
-					     void *tvlv_value,
-					     u16 tvlv_value_len)
+static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  u8 flags,
+					  void *tvlv_value,
+					  u16 tvlv_value_len)
 {
 	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	u8 mcast_flags = BATADV_NO_FLAGS;
@@ -789,8 +850,8 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_MCAST, 1,
+	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
+				     NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 }
 
@@ -800,8 +861,8 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
-- 
1.7.10.4

