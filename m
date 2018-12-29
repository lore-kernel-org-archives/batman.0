Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 29 Dec 2018 04:10:40 +0100
Message-Id: <20181229031040.7207-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v7] batman-adv: Snoop DHCPACKs for DAT
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

In a 1000 nodes mesh network (Freifunk Hamburg) we can still see
30KBit/s of ARP traffic (equalling about 25% of all layer two
specific overhead, remaining after some filtering) flooded through
the mesh. These 30KBit/s are mainly ARP Requests from the
gateways / DHCP servers.

By snooping DHCPACKs we can learn about MAC/IP address pairs
in the DHCP range without relying on ARP. This patch is in preparation
to eliminate the need for mesh wide message flooding for IPv4 address
resolution.

Also this allows to quickly update a MAC/IP pair at least in the DHT when
DHCP reassigns an IP address to a new host.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Changen in v7:
* fixed a memory access bug in batadv_dat_snoop_outgoing_dhcp_ack():
  ip_hdr(skb)->saddr is unsafe because we never ensured linear skb data;
  -> refactored functions to take an ip_src paramter instead
* fixed a memory access bug in batadv_dat_check_dhcp_ipudp():
  ip_hdrlen(skb) is unsafe on potentially non-linear skb data
* fixed a memory access bug in batadv_dat_get_dhcp_chaddr():
  the len parameter provided to skb_header_pointer() is 16 bytes long
  but we only reserved 6 bytes (ETH_ALEN) in
  batadv_dat_snoop_outgoing_dhcp_ack()
  -> increased the buffer length to the full DHCP chaddr size
* renamed batadv_dat_put_pairs() to batadv_dat_put_dhcp(), renamed
  its parameters and moved the batadv_dbg() functions into it,
  to make the naming and the function's purpose a bit more specific
  and meaningful
* added parsing of DHCPACKs on the mesh-ingress side, too, and if
  successful adding retrieved values to the local DAT cache;
  similar to what is done for incoming ARP replies, too
* removed unnecessary and unused hdr_size calculation in
  former batadv_dat_put_pairs()
* batadv_dat_dhcp_get_yiaddr() and batadv_dat_get_dhcp_chaddr()
  now always return a copy of the yiaddr chaddr so that callers
  have one less pointer to play with and do not need to worry about
  memory alignment anymore themselves
* rebased to master
* sorted variables to reverse Christmas tree

Changes in v6:
* moved dhcp packet definition from batadv_packet.h to
  distributed-arp-table.c

Changes in v5:
* fixed unaligned access issues (that is, enforce a two step
  load via "get_unaligned") for DHCP magic and yiaddr fields
* simplified batadv_dat_put_pairs():
  there is no need to check that arp_create() set the ARP
  type correctly. It always does or returns NULL otherwise.
  (this also fixes another unaligned access)

Changes in v4:
* Removed @proto from kerneldoc
* Less enum values in batadv_packet.h
* Moved skb_set_network_header() call
* Updated commit message

Changes in v3:
* Rebase to master
* Shortened commit message

Changes in v2:
* Rebase to master
* Fix compilation with CONFIG_BATMAN_ADV=n (added stubs)

Changes in RFC -> non-RFC

 * Added kerneldoc
 * Added Signed-off-by
 * More IP Header checks
   (iph->hlen considered, ip version checked, ...)
 * Parsing & checking DHCP Message Type Option,
   only snooping DHCPACKs now
 * Moved ethernet protocol check from batadv_dat_check_dhcp to
   batadv_dat_check_dhcp_ipudp
 * Removed buffer-length parameter from
   batadv_dat_dhcp_get_{yiaddr,chaddr}()
 * Renamed batadv_dat_put() to batadv_dat_put_pairs()

fixup DAT DHCP snooping
---
 net/batman-adv/distributed-arp-table.c | 410 +++++++++++++++++++++++++++++++++
 net/batman-adv/distributed-arp-table.h |  13 ++
 net/batman-adv/routing.c               |   4 +
 net/batman-adv/soft-interface.c        |  11 +-
 4 files changed, 436 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b9ffe182..d03184ec 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -29,6 +29,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -42,9 +43,11 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/udp.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
+#include <net/ip.h>
 #include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
@@ -60,6 +63,49 @@
 #include "translation-table.h"
 #include "tvlv.h"
 
+enum batadv_bootpop {
+	BATADV_BOOTREPLY	= 2,
+};
+
+enum batadv_boothtype {
+	BATADV_HTYPE_ETHERNET	= 1,
+};
+
+enum batadv_dhcpoptioncode {
+	BATADV_DHCP_OPT_PAD		= 0,
+	BATADV_DHCP_OPT_MSG_TYPE	= 53,
+	BATADV_DHCP_OPT_END		= 255,
+};
+
+enum batadv_dhcptype {
+	BATADV_DHCPACK		= 5,
+};
+
+/* { 99, 130, 83, 99 } */
+#define BATADV_DHCP_MAGIC 1669485411
+
+struct batadv_dhcp_packet {
+	__u8 op;
+	__u8 htype;
+	__u8 hlen;
+	__u8 hops;
+	__be32 xid;
+	__be16 secs;
+	__be16 flags;
+	__be32 ciaddr;
+	__be32 yiaddr;
+	__be32 siaddr;
+	__be32 giaddr;
+	__u8 chaddr[16];
+	__u8 sname[64];
+	__u8 file[128];
+	__be32 magic;
+	__u8 options[0];
+};
+
+#define BATADV_DHCP_YIADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
+#define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
+
 static void batadv_dat_purge(struct work_struct *work);
 
 /**
@@ -1440,6 +1486,370 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_dat_check_dhcp_ipudp() - check skb for IP+UDP headers valid for DHCP
+ * @skb: the packet to check
+ * @ip_src: a buffer to store the IPv4 source address in
+ *
+ * Checks whether the given skb has an IP and UDP header valid for a DHCP
+ * message from a DHCP server. And if so, stores the IPv4 source address in
+ * the provided buffer.
+ *
+ * Return: True if valid, false otherwise.
+ */
+static bool
+batadv_dat_check_dhcp_ipudp(struct sk_buff *skb, __be32 *ip_src)
+{
+	unsigned int offset = skb_network_offset(skb);
+	struct udphdr *udphdr, _udphdr;
+	struct iphdr *iphdr, _iphdr;
+
+	iphdr = skb_header_pointer(skb, offset, sizeof(_iphdr), &_iphdr);
+	if (!iphdr || iphdr->version != 4 || iphdr->ihl * 4 < sizeof(_iphdr))
+		return false;
+
+	if (iphdr->protocol != IPPROTO_UDP)
+		return false;
+
+	offset += iphdr->ihl * 4;
+	skb_set_transport_header(skb, offset);
+
+	udphdr = skb_header_pointer(skb, offset, sizeof(_udphdr), &_udphdr);
+	if (!udphdr || udphdr->source != htons(67))
+		return false;
+
+	*ip_src = get_unaligned(&iphdr->saddr);
+
+	return true;
+}
+
+/**
+ * batadv_dat_check_dhcp() - examine packet for valid DHCP message
+ * @skb: the packet to check
+ * @proto: ethernet protocol hint (behind a potential vlan)
+ * @ip_src: a buffer to store the IPv4 source address in
+ *
+ * Checks whether the given skb is a valid DHCP packet. And if so, stores the
+ * IPv4 source address in the provided buffer.
+ *
+ * Caller needs to ensure that the skb network header is set correctly.
+ *
+ * Return: If skb is a valid DHCP packet, then returns its op code
+ * (e.g. BOOTREPLY vs. BOOTREQUEST). Otherwise returns -EINVAL.
+ */
+static int
+batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto, __be32 *ip_src)
+{
+	unsigned int dhcp_offset;
+	__be32 *magic, _magic;
+	unsigned int offset;
+	u8 *htype, _htype;
+	u8 *hlen, _hlen;
+	u8 *op, _op;
+
+	if (proto != htons(ETH_P_IP))
+		return -EINVAL;
+
+	if (!batadv_dat_check_dhcp_ipudp(skb, ip_src))
+		return -EINVAL;
+
+	dhcp_offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	if (skb->len < dhcp_offset + sizeof(struct batadv_dhcp_packet))
+		return -EINVAL;
+
+	offset = dhcp_offset + offsetof(struct batadv_dhcp_packet, op);
+
+	op = skb_header_pointer(skb, offset, sizeof(_op), &_op);
+	if (!op)
+		return -EINVAL;
+
+	offset = dhcp_offset + offsetof(struct batadv_dhcp_packet, htype);
+
+	htype = skb_header_pointer(skb, offset, sizeof(_htype), &_htype);
+	if (!htype || *htype != BATADV_HTYPE_ETHERNET)
+		return -EINVAL;
+
+	offset = dhcp_offset + offsetof(struct batadv_dhcp_packet, hlen);
+
+	hlen = skb_header_pointer(skb, offset, sizeof(_hlen), &_hlen);
+	if (!hlen || *hlen != ETH_ALEN)
+		return -EINVAL;
+
+	offset = dhcp_offset + offsetof(struct batadv_dhcp_packet, magic);
+
+	magic = skb_header_pointer(skb, offset, sizeof(_magic), &_magic);
+	if (!magic || get_unaligned(magic) != htonl(BATADV_DHCP_MAGIC))
+		return -EINVAL;
+
+	return *op;
+}
+
+/**
+ * batadv_dat_get_dhcp_message_type() - get message type of a DHCP packet
+ * @skb: the DHCP packet to parse
+ *
+ * Iterates over the DHCP options of the given DHCP packet to find a
+ * DHCP Message Type option and parse it.
+ *
+ * Caller needs to ensure that the given skb is a valid DHCP packet and
+ * that the skb transport header is set correctly.
+ *
+ * Return: The found DHCP message type value, if found. -EINVAL otherwise.
+ */
+static int batadv_dat_get_dhcp_message_type(struct sk_buff *skb)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	u8 *type, _type;
+	struct {
+		u8 type;
+		u8 len;
+	} *tl, _tl;
+
+	offset += sizeof(struct batadv_dhcp_packet);
+
+	while ((tl = skb_header_pointer(skb, offset, sizeof(_tl), &_tl))) {
+		if (tl->type == BATADV_DHCP_OPT_MSG_TYPE)
+			break;
+
+		if (tl->type == BATADV_DHCP_OPT_END)
+			break;
+
+		if (tl->type == BATADV_DHCP_OPT_PAD)
+			offset++;
+		else
+			offset += tl->len + sizeof(_tl);
+	}
+
+	/* Option Overload Code not supported */
+	if (!tl || tl->type != BATADV_DHCP_OPT_MSG_TYPE ||
+	    tl->len != sizeof(_type))
+		return -EINVAL;
+
+	offset += sizeof(_tl);
+
+	type = skb_header_pointer(skb, offset, sizeof(_type), &_type);
+	if (!type)
+		return -EINVAL;
+
+	return *type;
+}
+
+/**
+ * batadv_dat_get_dhcp_yiaddr() - get yiaddr from a DHCP packet
+ * @skb: the DHCP packet to parse
+ * @buf: a buffer to store the yiaddr in
+ *
+ * Caller needs to ensure that the given skb is a valid DHCP packet and
+ * that the skb transport header is set correctly.
+ *
+ * Return: True on success, false otherwise.
+ */
+static bool batadv_dat_dhcp_get_yiaddr(struct sk_buff *skb, __be32 *buf)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	__be32 *yiaddr;
+
+	offset += offsetof(struct batadv_dhcp_packet, yiaddr);
+	yiaddr = skb_header_pointer(skb, offset, BATADV_DHCP_YIADDR_LEN, buf);
+
+	if (!yiaddr)
+		return false;
+
+	if (yiaddr != buf)
+		*buf = get_unaligned(yiaddr);
+
+	return true;
+}
+
+/**
+ * batadv_dat_get_dhcp_chaddr() - get chaddr from a DHCP packet
+ * @skb: the DHCP packet to parse
+ * @buf: a buffer to store the chaddr in
+ *
+ * Caller needs to ensure that the given skb is a valid DHCP packet and
+ * that the skb transport header is set correctly.
+ *
+ * Return: True on success, false otherwise
+ */
+static bool batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buf)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	u8 *chaddr;
+
+	offset += offsetof(struct batadv_dhcp_packet, chaddr);
+	chaddr = skb_header_pointer(skb, offset, BATADV_DHCP_CHADDR_LEN, buf);
+
+	if (!chaddr)
+		return false;
+
+	if (chaddr != buf)
+		memcpy(buf, chaddr, BATADV_DHCP_CHADDR_LEN);
+
+	return true;
+}
+
+/**
+ * batadv_dat_put_dhcp() - puts addresses from a DHCP packet into the DHT and
+ *  DAT cache
+ * @bat_priv: the bat priv with all the soft interface information
+ * @chaddr: the DHCP client MAC address
+ * @yiaddr: the DHCP client IP address
+ * @hw_dst: the DHCP server MAC address
+ * @ip_dst: the DHCP server IP address
+ * @vid: VLAN identifier
+ *
+ * Adds given MAC/IP pairs to the local DAT cache and propagates them further
+ * into the DHT.
+ *
+ * For the DHT propagation, client MAC + IP will appear as the ARP Reply
+ * transmitter (and hw_dst/ip_dst as the target).
+ */
+static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
+				__be32 yiaddr, u8 *hw_dst, __be32 ip_dst,
+				unsigned short vid)
+{
+	struct sk_buff *skb;
+
+	skb = batadv_dat_arp_create_reply(bat_priv, yiaddr, ip_dst, chaddr,
+					  hw_dst, vid);
+	if (!skb)
+		return;
+
+	skb_set_network_header(skb, ETH_HLEN);
+
+	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+
+	batadv_dat_send_data(bat_priv, skb, yiaddr, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from outgoing DHCPACK (server address): %pI4, %pM (vid: %i)\n",
+		   &ip_dst, hw_dst, batadv_print_vid(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from outgoing DHCPACK (client address): %pI4, %pM (vid: %i)\n",
+		   &yiaddr, chaddr, batadv_print_vid(vid));
+}
+
+/**
+ * batadv_dat_check_dhcp_ack() - examine packet for valid DHCP message
+ * @skb: the packet to check
+ * @proto: ethernet protocol hint (behind a potential vlan)
+ * @ip_src: a buffer to store the IPv4 source address in
+ * @chaddr: a buffer to store the DHCP Client Hardware Address in
+ * @yiaddr: a buffer to store the DHCP Your IP Address in
+ *
+ * Checks whether the given skb is a valid DHCPACK. And if so, stores the
+ * IPv4 server source address (ip_src), client MAC address (chaddr) and client
+ * IPv4 address (yiaddr) in the provided buffers.
+
+ * Caller needs to ensure that the skb network header is set correctly.
+ *
+ * Return: True if the skb is a valid DHCPACK. False otherwise.
+ */
+static bool
+batadv_dat_check_dhcp_ack(struct sk_buff *skb, __be16 proto, __be32 *ip_src,
+			  u8 *chaddr, __be32 *yiaddr)
+{
+	int type;
+
+	type = batadv_dat_check_dhcp(skb, proto, ip_src);
+	if (type != BATADV_BOOTREPLY)
+		return false;
+
+	type = batadv_dat_get_dhcp_message_type(skb);
+	if (type != BATADV_DHCPACK)
+		return false;
+
+	if (!batadv_dat_dhcp_get_yiaddr(skb, yiaddr))
+		return false;
+
+	if (!batadv_dat_get_dhcp_chaddr(skb, chaddr))
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_dat_snoop_outgoing_dhcp_ack() - snoop DHCPACK and fill DAT with it
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the packet to snoop
+ * @proto: ethernet protocol hint (behind a potential vlan)
+ * @vid: VLAN identifier
+ *
+ * This function first checks whether the given skb is a valid DHCPACK. If
+ * so then its source MAC and IP as well as its DHCP Client Hardware Address
+ * field and DHCP Your IP Address field are added to the local DAT cache and
+ * propagated into the DHT.
+ *
+ * Caller needs to ensure that the skb mac and network headers are set
+ * correctly.
+ */
+void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					__be16 proto,
+					unsigned short vid)
+{
+	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
+	__be32 ip_src, yiaddr;
+
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return;
+
+	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
+		return;
+
+	batadv_dat_put_dhcp(bat_priv, chaddr, yiaddr, eth_hdr(skb)->h_source,
+			    ip_src, vid);
+}
+
+/**
+ * batadv_dat_snoop_incoming_dhcp_ack() - snoop DHCPACK and fill DAT cache
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the packet to snoop
+ * @hdr_size: header size, up to the tail of the batman-adv header
+ *
+ * This function first checks whether the given skb is a valid DHCPACK. If
+ * so then its source MAC and IP as well as its DHCP Client Hardware Address
+ * field and DHCP Your IP Address field are added to the local DAT cache.
+ */
+void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
+					struct sk_buff *skb, int hdr_size)
+{
+	u8 chaddr[BATADV_DHCP_CHADDR_LEN];
+	struct ethhdr *ethhdr;
+	__be32 ip_src, yiaddr;
+	unsigned short vid;
+	__be16 proto;
+	u8 *hw_src;
+
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return;
+
+	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
+		return;
+
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+	skb_set_network_header(skb, hdr_size + ETH_HLEN);
+	proto = ethhdr->h_proto;
+
+	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
+		return;
+
+	hw_src = ethhdr->h_source;
+	vid = batadv_dat_get_vid(skb, &hdr_size);
+
+	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from incoming DHCPACK (server address): %pI4, %pM (vid: %i)\n",
+		   &ip_src, hw_src, batadv_print_vid(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from incoming DHCPACK (client address): %pI4, %pM (vid: %i)\n",
+		   &yiaddr, chaddr, batadv_print_vid(vid));
+}
+
+/**
  * batadv_dat_drop_broadcast_packet() - check if an ARP request has to be
  *  dropped (because the node has already obtained the reply via DAT) or not
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index a0459602..6c2c87d7 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -46,6 +46,12 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size);
+void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					__be16 proto,
+					unsigned short vid);
+void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
+					struct sk_buff *skb, int hdr_size);
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet);
 
@@ -140,6 +146,13 @@ batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	return false;
 }
 
+static inline void
+batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb, __be16 proto,
+				   unsigned short vid)
+{
+}
+
 static inline bool
 batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cc3ed93a..469fa97d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1043,6 +1043,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							hdr_size))
 			goto rx_success;
 
+		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
+
 		batadv_interface_rx(recv_if->soft_iface, skb, hdr_size,
 				    orig_node);
 
@@ -1278,6 +1280,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
 		goto rx_success;
 
+	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
+
 	/* broadcast for me */
 	batadv_interface_rx(recv_if->soft_iface, skb, hdr_size, orig_node);
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5db5a0a4..94307100 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -212,6 +212,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	enum batadv_forw_mode forw_mode;
 	struct batadv_orig_node *mcast_single_orig = NULL;
 	int network_offset = ETH_HLEN;
+	__be16 proto;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -223,12 +224,15 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
 
-	switch (ntohs(ethhdr->h_proto)) {
+	proto = ethhdr->h_proto;
+
+	switch (ntohs(proto)) {
 	case ETH_P_8021Q:
 		vhdr = vlan_eth_hdr(skb);
+		proto = vhdr->h_vlan_encapsulated_proto;
 
 		/* drop batman-in-batman packets to prevent loops */
-		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN)) {
+		if (proto != htons(ETH_P_BATMAN)) {
 			network_offset += VLAN_HLEN;
 			break;
 		}
@@ -256,6 +260,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			goto dropped;
 	}
 
+	/* Snoop address candidates from DHCPACKs for early DAT filling */
+	batadv_dat_snoop_outgoing_dhcp_ack(bat_priv, skb, proto, vid);
+
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
 	 *
-- 
2.11.0

