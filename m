Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:43 +0300
Message-Id: <1373242365-763-4-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 4/6] batman-adv: Adds necessary functions for
	NDP, like checking if a packet is valid or creating a Neighbor
	Advertisement
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

From: Mihail Costea <mihail.costea90@gmail.com>

Adds functions needed for NDP snooping, like getting the IPv6 addresses
or getting the target HW address from an Neighbor Advertisement (NA).
Also added functions to create NA for Neighbor Solicitations
that have already the HW address in DAT.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  319 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f941913..d0b9e95 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -20,7 +20,9 @@
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <linux/if_vlan.h>
+#include <net/addrconf.h>
 #include <net/arp.h>
+#include <net/ipv6.h>
 
 #include "main.h"
 #include "hash.h"
@@ -981,6 +983,323 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 	return vid;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+/**
+ * batadv_ndisc_hw_src - get source hw address from a packet
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns source hw address of the skb packet.
+ */
+static uint8_t *batadv_ndisc_hw_src(struct sk_buff *skb, int hdr_size)
+{
+	struct ethhdr *ethhdr;
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+	return (uint8_t *)ethhdr->h_source;
+}
+
+/**
+ * batadv_ndisc_hw_dst - get destination hw address from a packet
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns destination hw address of the skb packet.
+ */
+static uint8_t *batadv_ndisc_hw_dst(struct sk_buff *skb, int hdr_size)
+{
+	struct ethhdr *ethhdr;
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+	return (uint8_t *)ethhdr->h_dest;
+}
+
+/**
+ * batadv_ndisc_ipv6_src - get source IPv6 address from a packet
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns source IPv6 address of the skb packet.
+ */
+static struct in6_addr *batadv_ndisc_ipv6_src(struct sk_buff *skb,
+					      int hdr_size)
+{
+	struct ipv6hdr *ipv6hdr;
+	ipv6hdr = (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
+	return &ipv6hdr->saddr;
+}
+
+/**
+ * batadv_ndisc_ipv6_dst - get destination IPv6 address from a packet
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns destination IPv6 address of the skb packet.
+ */
+static struct in6_addr *batadv_ndisc_ipv6_dst(struct sk_buff *skb,
+					      int hdr_size)
+{
+	struct ipv6hdr *ipv6hdr;
+	ipv6hdr = (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
+	return &ipv6hdr->daddr;
+}
+
+/**
+ * batadv_ndisc_ipv6_target - get target IPv6 address from a NS/NA packet
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns target IPv6 address of the skb packet.
+ */
+static struct in6_addr *batadv_ndisc_ipv6_target(struct sk_buff *skb,
+						 int hdr_size)
+{
+	return (struct in6_addr *)(skb->data + hdr_size + ETH_HLEN +
+			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));
+}
+
+/**
+ * batadv_ndisc_hw_opt - get hw address from NS/NA packet options
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ * @type: type of the address (ND_OPT_SOURCE_LL_ADDR or ND_OPT_TARGET_LL_ADDR)
+ *
+ * The address can be either the source link-layer address
+ * or the target link-layer address.
+ * For more info see RFC2461.
+ *
+ * Returns hw address from packet options.
+ */
+static uint8_t *batadv_ndisc_hw_opt(struct sk_buff *skb, int hdr_size,
+				    uint8_t type)
+{
+	unsigned char *opt_addr;
+
+	opt_addr = skb->data + hdr_size + ETH_HLEN +
+			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr) +
+			sizeof(struct in6_addr);
+
+	/* test if option header is ok */
+	if (*opt_addr != type || *(opt_addr + 1) != 1)
+		return NULL;
+	return (uint8_t *)(opt_addr + 2);
+}
+
+/**
+ * batadv_ndisc_get_type - get icmp6 packet type
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns the icmp6 type, or 0 if packet is not a valid icmp6 packet.
+ */
+static __u8 batadv_ndisc_get_type(struct batadv_priv *bat_priv,
+				  struct sk_buff *skb, int hdr_size)
+{
+	struct ethhdr *ethhdr;
+	struct ipv6hdr *ipv6hdr;
+	struct icmp6hdr *icmp6hdr;
+	__u8 type = 0;
+
+	/* pull headers */
+	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
+			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))))
+		goto out;
+
+	/* get the ethernet header */
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+	if (ethhdr->h_proto != htons(ETH_P_IPV6))
+		goto out;
+
+	/* get the ipv6 header */
+	ipv6hdr = (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
+	if (ipv6hdr->nexthdr != IPPROTO_ICMPV6)
+		goto out;
+
+	/* get the icmpv6 header */
+	icmp6hdr = (struct icmp6hdr *)(skb->data + hdr_size + ETH_HLEN +
+			sizeof(struct ipv6hdr));
+
+	/* check whether the ndisc packet carries a valid icmp6 header */
+	if (ipv6hdr->hop_limit != 255)
+		goto out;
+
+	if (icmp6hdr->icmp6_code != 0)
+		goto out;
+
+	type = icmp6hdr->icmp6_type;
+out:
+	return type;
+}
+
+/**
+ * batadv_ndisc_is_valid - check if a ndisc packet is valid
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ * @ndisc_type: type of ndisc packet to check
+ *
+ * Check if all IPs are valid (source, destination, target) and if
+ * options hw address is valid too.
+ * Some options might be ignored, like NS packets sent automatically
+ * for verification of the reachability of a neighbor.
+ *
+ * Returns true if packet is valid, otherwise false if invalid or ignored.
+ */
+static bool batadv_ndisc_is_valid(struct batadv_priv *bat_priv,
+				  struct sk_buff *skb, int hdr_size,
+				  int ndisc_type)
+{
+	uint8_t *hw_target = NULL;
+	struct in6_addr *ipv6_src, *ipv6_dst, *ipv6_target;
+	__u8 type = batadv_ndisc_get_type(bat_priv, skb, hdr_size);
+	int ndisc_hdr_len = hdr_size + ETH_HLEN + sizeof(struct ipv6hdr) +
+			    sizeof(struct icmp6hdr) + sizeof(struct in6_addr) +
+			    8; /* ndisc options length */
+
+	if (type != ndisc_type)
+		return false;
+	if (unlikely(!pskb_may_pull(skb, ndisc_hdr_len)))
+		return false;
+
+	/* Check for bad NA/NS. If the ndisc message is not sane, DAT
+	 * will simply ignore it
+	 */
+	if (type == NDISC_NEIGHBOUR_SOLICITATION)
+		hw_target = batadv_ndisc_hw_opt(skb, hdr_size,
+						ND_OPT_SOURCE_LL_ADDR);
+	else if (type == NDISC_NEIGHBOUR_ADVERTISEMENT)
+		hw_target = batadv_ndisc_hw_opt(skb, hdr_size,
+						ND_OPT_TARGET_LL_ADDR);
+
+	if (!hw_target || is_zero_ether_addr(hw_target) ||
+	    is_multicast_ether_addr(hw_target))
+		return false;
+
+	ipv6_src = batadv_ndisc_ipv6_src(skb, hdr_size);
+	ipv6_dst = batadv_ndisc_ipv6_dst(skb, hdr_size);
+	ipv6_target = batadv_ndisc_ipv6_target(skb, hdr_size);
+	if (ipv6_addr_loopback(ipv6_src) || ipv6_addr_loopback(ipv6_dst) ||
+	    ipv6_addr_is_multicast(ipv6_src) ||
+	    ipv6_addr_is_multicast(ipv6_target))
+		return false;
+
+	/* ignore messages with unspecified address */
+	if (ipv6_addr_any(ipv6_src) || ipv6_addr_any(ipv6_dst) ||
+	    ipv6_addr_any(ipv6_target))
+		return false;
+
+	/* ignore the verification of the reachability of a neighbor */
+	if (type == NDISC_NEIGHBOUR_SOLICITATION &&
+	    !ipv6_addr_is_multicast(ipv6_dst))
+		return false;
+
+	return true;
+}
+
+static void batadv_ndisc_ip6_hdr(struct sock *sk, struct sk_buff *skb,
+				 struct net_device *dev,
+				 const struct in6_addr *ipv6_src,
+				 const struct in6_addr *ipv6_dst,
+				 int proto, int len)
+{
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6hdr *hdr;
+
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->dev = dev;
+
+	skb_reset_network_header(skb);
+	skb_put(skb, sizeof(struct ipv6hdr));
+	hdr = ipv6_hdr(skb);
+
+	*(__be32 *)hdr = htonl(0x60000000);
+
+	hdr->payload_len = htons(len);
+	hdr->nexthdr = proto;
+	hdr->hop_limit = np->hop_limit;
+
+	hdr->saddr = *ipv6_src;
+	hdr->daddr = *ipv6_dst;
+}
+
+/**
+ * batadv_ndisc_create_na - create an NA for a solicited NS
+ * @net_device: the devices for which the packet is created
+ * @ipv6_dst: destination IPv6
+ * @ipv6_target: target IPv6 (same with source IPv6)
+ * @hw_dst: destination HW Address
+ * @hw_target: target HW Address (same with source HW Address)
+ * @router: 1 if target is a router, else 0
+ * @solicited: 1 if this is a solicited NA, else 0
+ * @override: 1 if the target entry should be override, else 0
+ *
+ * For more info see RFC2461.
+ *
+ * Returns the newly created skb, otherwise NULL.
+ */
+static struct
+sk_buff *batadv_ndisc_create_na(struct net_device *dev,
+				const struct in6_addr *ipv6_dst,
+				const struct in6_addr *ipv6_target,
+				const uint8_t *hw_dst,
+				const uint8_t *hw_target,
+				int router, int solicited, int override)
+{
+	struct net *net = dev_net(dev);
+	struct sock *sk = net->ipv6.ndisc_sk;
+	struct sk_buff *skb;
+	struct icmp6hdr *icmp6hdr;
+	int hlen = LL_RESERVED_SPACE(dev);
+	int tlen = dev->needed_tailroom;
+	int len, err;
+	u8 *opt;
+
+	/* alloc space for skb */
+	len = sizeof(struct icmp6hdr) + sizeof(*ipv6_target) + 8;
+	skb = sock_alloc_send_skb(sk,
+				  (MAX_HEADER + sizeof(struct ipv6hdr) +
+				   len + hlen + tlen),
+				  1, &err);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, hlen);
+	batadv_ndisc_ip6_hdr(sk, skb, dev, ipv6_target, ipv6_dst,
+			     IPPROTO_ICMPV6, len);
+
+	skb->transport_header = skb->tail;
+	skb_put(skb, len);
+
+	/* fill the device header for the NA frame */
+	if (dev_hard_header(skb, dev, ETH_P_IPV6, hw_dst,
+			    hw_target, skb->len) < 0) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* set icmpv6 header */
+	icmp6hdr = (struct icmp6hdr *)skb_transport_header(skb);
+	icmp6hdr->icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
+	icmp6hdr->icmp6_router = router;
+	icmp6hdr->icmp6_solicited = solicited;
+	icmp6hdr->icmp6_override = override;
+
+	/* set NA target and options */
+	opt = skb_transport_header(skb) + sizeof(*icmp6hdr);
+	*(struct in6_addr *)opt = *ipv6_target;
+	opt += sizeof(*ipv6_target);
+
+	opt[0] = ND_OPT_TARGET_LL_ADDR;
+	opt[1] = 1;
+	memcpy(opt + 2, hw_target, dev->addr_len);
+
+	icmp6hdr->icmp6_cksum = csum_ipv6_magic(ipv6_target, ipv6_dst, len,
+						IPPROTO_ICMPV6,
+						csum_partial(icmp6hdr, len, 0));
+
+	return skb;
+}
+#endif
+
 /**
  * batadv_dat_snoop_outgoing_pkt_request - snoop the ARP request and try to
  * answer using DAT
-- 
1.7.10.4

