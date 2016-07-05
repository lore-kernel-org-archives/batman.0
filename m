Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue,  5 Jul 2016 20:01:37 +0200
Message-Id: <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
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

In a typical mesh network, when a new client connects then it will
usually first try to grab an IPv4 address via DHCP. Afterwards in
public mesh networks a client will try to contact the internet over
the server.

While the IPv4 address of the DHCP-Server is usually well propagated
in the DHT, the IPv4 address of a newly joining client is not.

This can lead to a considerable amount of ARP broadcasts not caught
by DAT from the servers.

In a 1000 nodes mesh network (Freifunk Hamburg) we can still see
30KBit/s of ARP traffic (equalling about 25% of all layer two
specific overhead, remaining after some filtering) flooded through
the mesh. These 30KBit/s are mainly ARP Requests from the
gateways / DHCP servers.

Through snooping DHCPACKs we can actually learn about MAC/IP address
pairs without the need of any flooded ARP messages in advance. This
allows servers to fill their local DAT cache with according entries
before any communciation with a client can possibly have taken place.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

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

 net/batman-adv/distributed-arp-table.c | 296 +++++++++++++++++++++++++++++++++
 net/batman-adv/distributed-arp-table.h |  11 ++
 net/batman-adv/packet.h                |  48 ++++++
 net/batman-adv/soft-interface.c        |  11 +-
 4 files changed, 364 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 081b1dc..b6b94e2 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -40,8 +41,10 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/udp.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
+#include <net/ip.h>
 
 #include "hard-interface.h"
 #include "hash.h"
@@ -974,6 +977,7 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 		return NULL;
 
 	skb_reset_mac_header(skb);
+	skb_set_network_header(skb, ETH_HLEN);
 
 	if (vid & BATADV_VLAN_HAS_TAG)
 		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
@@ -1237,6 +1241,298 @@ out:
 }
 
 /**
+ * batadv_dat_check_dhcp_ipudp - check skb for IP+UDP headers valid for DHCP
+ * @skb: the packet to check
+ * @proto: ethernet protocol hint (behind a potential vlan)
+ *
+ * Checks whether the given skb has an IP and UDP header valid for a DHCP
+ * message from a DHCP server.
+ *
+ * Return: True if valid, false otherwise.
+ */
+static bool batadv_dat_check_dhcp_ipudp(struct sk_buff *skb)
+{
+	struct iphdr *iphdr, _iphdr;
+	struct udphdr *udphdr, _udphdr;
+	unsigned int offset = skb_network_offset(skb);
+
+	iphdr = skb_header_pointer(skb, offset, sizeof(_iphdr), &_iphdr);
+	if (!iphdr || iphdr->version != 4 || ip_hdrlen(skb) < sizeof(_iphdr))
+		return false;
+
+	if (iphdr->protocol != IPPROTO_UDP)
+		return false;
+
+	offset += ip_hdrlen(skb);
+	skb_set_transport_header(skb, offset);
+
+	udphdr = skb_header_pointer(skb, offset, sizeof(_udphdr), &_udphdr);
+	if (!udphdr || udphdr->source != htons(67))
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_dat_check_dhcp - examine packet for valid DHCP message
+ * @skb: the packet to check
+ * @proto: ethernet protocol hint (behind a potential vlan)
+ *
+ * Checks whether the given skb is a valid DHCP packet.
+ *
+ * Caller needs to ensure that the skb network header is set correctly.
+ *
+ * Return: If skb is a valid DHCP packet, then returns its op code
+ * (e.g. BOOTREPLY vs. BOOTREQUEST). Otherwise returns -EINVAL.
+ */
+static int batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto)
+{
+	u8 *op, _op;
+	u8 *htype, _htype;
+	u8 *hlen, _hlen;
+	__be32 *magic, _magic;
+	unsigned int dhcp_offset;
+	unsigned int offset;
+
+	if (proto != htons(ETH_P_IP))
+		return -EINVAL;
+
+	if (!batadv_dat_check_dhcp_ipudp(skb))
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
+	if (!magic || *magic != htonl(BATADV_DHCP_MAGIC))
+		return -EINVAL;
+
+	return *op;
+}
+
+/**
+ * batadv_dat_get_dhcp_message_type - get message type of a DHCP packet
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
+ * batadv_dat_get_dhcp_yiaddr - get yiaddr from a DHCP packet
+ * @skb: the DHCP packet to parse
+ * @buffer: a buffer to store the yiaddr in (if necessary / skb is non-linear)
+ *
+ * Caller needs to ensure that the given skb is a valid DHCP packet and
+ * that the skb transport header is set correctly.
+ *
+ * Return: A safely accessible "Your IP Address" field from the provided DHCP
+ * packet.
+ */
+static __be32 *batadv_dat_dhcp_get_yiaddr(struct sk_buff *skb, __be32 *buffer)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	unsigned int len = sizeof(((struct batadv_dhcp_packet *)0)->yiaddr);
+
+	offset += offsetof(struct batadv_dhcp_packet, yiaddr);
+
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
+/**
+ * batadv_dat_get_dhcp_chaddr - get chaddr from a DHCP packet
+ * @skb: the DHCP packet to parse
+ * @buffer: a buffer to store the chaddr in (if necessary / skb is non-linear)
+ *
+ * Caller needs to ensure that the given skb is a valid DHCP packet and
+ * that the skb transport header is set correctly.
+ *
+ * Return: A safely accessible "Client Hardware Address" field from the provided
+ * DHCP packet.
+ */
+static u8 *batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buffer)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct udphdr);
+	unsigned int len = sizeof(((struct batadv_dhcp_packet *)0)->chaddr);
+
+	offset += offsetof(struct batadv_dhcp_packet, chaddr);
+
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
+/**
+ * batadv_dat_put_pairs - puts two MAC/IP pairs into the DHT and DAT cache
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hw_src: first value of DHT and ARP sender MAC
+ * @ip_src: first key of DHT and ARP sender IP
+ * @hw_dst: second value of DHT and ARP target MAC
+ * @ip_dst: second key of DHT and ARP target IP
+ * @vid: VLAN identifier
+ *
+ * First checks whether the given MAC/IP pairs are suitable for DAT. If so, adds
+ * them to the local DAT cache and propagates them further into the DHT.
+ *
+ * For the DHT propagation, hw_src/ip_src will appear as the ARP Reply
+ * transmitter (and hw_dst/ip_dst as the target).
+ *
+ * Return: True on success, false otherwise.
+ */
+static bool batadv_dat_put_pairs(struct batadv_priv *bat_priv, u8 *hw_src,
+				 __be32 ip_src, u8 *hw_dst, __be32 ip_dst,
+				 unsigned short vid)
+{
+	struct sk_buff *skb;
+	int hdr_size;
+	u16 type;
+	int ret = false;
+
+	skb = batadv_dat_arp_create_reply(bat_priv, ip_src, ip_dst, hw_src,
+					  hw_dst, vid);
+	if (!skb)
+		return false;
+
+	/* Check for validity of provided addresses */
+	hdr_size = skb_network_offset(skb) - ETH_HLEN;
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
+	if (type != ARPOP_REPLY)
+		goto err_skip_commit;
+
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+
+	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+
+	ret = true;
+
+err_skip_commit:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
+/**
+ * batadv_dat_snoop_outgoing_dhcp_ack - snoop DHCPACK and fill DAT with it
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
+	int type;
+	u8 *chaddr, _chaddr[ETH_ALEN];
+	__be32 *yiaddr, _yiaddr;
+
+	if (!atomic_read(&bat_priv->distributed_arp_table))
+		return;
+
+	if (batadv_dat_check_dhcp(skb, proto) != BATADV_BOOTREPLY)
+		return;
+
+	type = batadv_dat_get_dhcp_message_type(skb);
+	if (type != BATADV_DHCPACK)
+		return;
+
+	yiaddr = batadv_dat_dhcp_get_yiaddr(skb, &_yiaddr);
+	if (!yiaddr)
+		return;
+
+	chaddr = batadv_dat_get_dhcp_chaddr(skb, _chaddr);
+	if (!chaddr)
+		return;
+
+	/* ARP sender MAC + IP -> DHCP Client (chaddr+yiaddr),
+	 * ARP target MAC + IP -> DHCP Server (ethhdr/iphdr sources)
+	 */
+	if (!batadv_dat_put_pairs(bat_priv, chaddr, *yiaddr,
+				  eth_hdr(skb)->h_source, ip_hdr(skb)->saddr,
+				  vid))
+		return;
+
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from DHCPACK (server-side): %pI4, %pM (vid: %i)\n",
+		   &ip_hdr(skb)->saddr, eth_hdr(skb)->h_source,
+		   BATADV_PRINT_VID(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "Snooped from DHCPACK (client-side): %pI4, %pM (vid: %i)\n",
+		   yiaddr, chaddr, BATADV_PRINT_VID(vid));
+}
+
+/**
  * batadv_dat_drop_broadcast_packet - check if an ARP request has to be dropped
  * (because the node has already obtained the reply via DAT) or not
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 813ecea..cab1172 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -44,6 +44,10 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size);
+void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
+					struct sk_buff *skb,
+					__be16 proto,
+					unsigned short vid);
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet);
 
@@ -137,6 +141,13 @@ batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
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
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6b011ff..d8afbfa 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -664,4 +664,52 @@ struct batadv_tvlv_mcast_data {
 	u8 reserved[3];
 };
 
+enum batadv_bootpop {
+	BATADV_BOOTREQUEST	= 1,
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
+	BATADV_DHCPDISCOVER	= 1,
+	BATADV_DHCPOFFER	= 2,
+	BATADV_DHCPREQUEST	= 3,
+	BATADV_DHCPDECLINE	= 4,
+	BATADV_DHCPACK		= 5,
+	BATADV_DHCPNAK		= 6,
+	BATADV_DHCPRELEASE	= 7,
+	BATADV_DHCPINFORM	= 8,
+};
+
+/* { 99, 130, 83, 99 } */
+#define BATADV_DHCP_MAGIC 1669485411
+
+struct batadv_dhcp_packet {
+	u8 op;
+	u8 htype;
+	u8 hlen;
+	u8 hops;
+	__be32 xid;
+	__be16 secs;
+	__be16 flags;
+	__be32 ciaddr;
+	__be32 yiaddr;
+	__be32 siaddr;
+	__be32 giaddr;
+	u8 chaddr[16];
+	u8 sname[64];
+	u8 file[128];
+	__be32 magic;
+	u8 options[0];
+};
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 216ac03..12bc41b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -204,6 +204,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	enum batadv_forw_mode forw_mode;
 	struct batadv_orig_node *mcast_single_orig = NULL;
 	int network_offset = ETH_HLEN;
+	__be16 proto;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -212,12 +213,15 @@ static int batadv_interface_tx(struct sk_buff *skb,
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
@@ -244,6 +248,9 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			goto dropped;
 	}
 
+	/* Snoop address candidates from DHCPACKs for early DAT filling */
+	batadv_dat_snoop_outgoing_dhcp_ack(bat_priv, skb, proto, vid);
+
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
 	 *
-- 
2.1.4

