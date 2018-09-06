Return-Path: <a@unstable.cc>
References: <20180621162745.3408-1-linus.luessing@c0d3.blue>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <a76f77c8-70ba-ed75-87c4-042a079ca11b@unstable.cc>
Date: Thu, 6 Sep 2018 22:34:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180621162745.3408-1-linus.luessing@c0d3.blue>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JziTUFsPcT36YULziLElBNnkH53wvl4MW"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6] batman-adv: Snoop DHCPACKs for DAT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JziTUFsPcT36YULziLElBNnkH53wvl4MW
Content-Type: multipart/mixed; boundary="xd7Shl1vUU4IWY9GiSUtBt4HujjdUpw3t";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <a76f77c8-70ba-ed75-87c4-042a079ca11b@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v6] batman-adv: Snoop DHCPACKs for DAT
References: <20180621162745.3408-1-linus.luessing@c0d3.blue>
In-Reply-To: <20180621162745.3408-1-linus.luessing@c0d3.blue>

--xd7Shl1vUU4IWY9GiSUtBt4HujjdUpw3t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please see my comments inline,

On 22/06/18 00:27, Linus L=C3=BCssing wrote:
> In a 1000 nodes mesh network (Freifunk Hamburg) we can still see
> 30KBit/s of ARP traffic (equalling about 25% of all layer two
> specific overhead, remaining after some filtering) flooded through
> the mesh. These 30KBit/s are mainly ARP Requests from the
> gateways / DHCP servers.
>=20
> By snooping DHCPACKs we can learn about MAC/IP address pairs
> in the DHCP range without relying on ARP. This patch is in preparation
> to eliminate the need for mesh wide message flooding for IPv4 address
> resolution.
>=20
> Also this allows to quickly update a MAC/IP pair at least in the DHT wh=
en
> DHCP reassigns an IP address to a new host.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v6:
> * moved dhcp packet definition from batadv_packet.h to
>   distributed-arp-table.c
>=20
> Changes in v5:
> * fixed unaligned access issues (that is, enforce a two step
>   load via "get_unaligned") for DHCP magic and yiaddr fields
> * simplified batadv_dat_put_pairs():
>   there is no need to check that arp_create() set the ARP
>   type correctly. It always does or returns NULL otherwise.
>   (this also fixes another unaligned access)
>=20
> Changes in v4:
> * Removed @proto from kerneldoc
> * Less enum values in batadv_packet.h
> * Moved skb_set_network_header() call
> * Updated commit message
>=20
> Changes in v3:
> * Rebase to master
> * Shortened commit message
>=20
> Changes in v2:
> * Rebase to master
> * Fix compilation with CONFIG_BATMAN_ADV=3Dn (added stubs)
>=20
> Changes in RFC -> non-RFC
>=20
>  * Added kerneldoc
>  * Added Signed-off-by
>  * More IP Header checks
>    (iph->hlen considered, ip version checked, ...)
>  * Parsing & checking DHCP Message Type Option,
>    only snooping DHCPACKs now
>  * Moved ethernet protocol check from batadv_dat_check_dhcp to
>    batadv_dat_check_dhcp_ipudp
>  * Removed buffer-length parameter from
>    batadv_dat_dhcp_get_{yiaddr,chaddr}()
>  * Renamed batadv_dat_put() to batadv_dat_put_pairs()
>=20
> fixup DAT DHCP snooping
> ---
>  net/batman-adv/distributed-arp-table.c | 326 +++++++++++++++++++++++++=
++++++++
>  net/batman-adv/distributed-arp-table.h |  11 ++
>  net/batman-adv/soft-interface.c        |  11 +-
>  3 files changed, 346 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/di=
stributed-arp-table.c
> index a60bacf7..401f4065 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -29,6 +29,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
>  #include <linux/in.h>
> +#include <linux/ip.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> @@ -42,9 +43,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
> +#include <linux/udp.h>
>  #include <linux/workqueue.h>
>  #include <net/arp.h>
>  #include <net/genetlink.h>
> +#include <net/ip.h>
>  #include <net/netlink.h>
>  #include <net/sock.h>
>  #include <uapi/linux/batman_adv.h>
> @@ -60,6 +63,46 @@
>  #include "translation-table.h"
>  #include "tvlv.h"
> =20
> +enum batadv_bootpop {
> +	BATADV_BOOTREPLY	=3D 2,
> +};
> +
> +enum batadv_boothtype {
> +	BATADV_HTYPE_ETHERNET	=3D 1,
> +};
> +
> +enum batadv_dhcpoptioncode {
> +	BATADV_DHCP_OPT_PAD		=3D 0,
> +	BATADV_DHCP_OPT_MSG_TYPE	=3D 53,
> +	BATADV_DHCP_OPT_END		=3D 255,
> +};
> +
> +enum batadv_dhcptype {
> +	BATADV_DHCPACK		=3D 5,
> +};
> +
> +/* { 99, 130, 83, 99 } */
> +#define BATADV_DHCP_MAGIC 1669485411
> +
> +struct batadv_dhcp_packet {
> +	__u8 op;
> +	__u8 htype;
> +	__u8 hlen;
> +	__u8 hops;
> +	__be32 xid;
> +	__be16 secs;
> +	__be16 flags;
> +	__be32 ciaddr;
> +	__be32 yiaddr;
> +	__be32 siaddr;
> +	__be32 giaddr;
> +	__u8 chaddr[16];
> +	__u8 sname[64];
> +	__u8 file[128];
> +	__be32 magic;
> +	__u8 options[0];
> +};
> +
>  static void batadv_dat_purge(struct work_struct *work);
> =20
>  /**
> @@ -1436,6 +1479,289 @@ bool batadv_dat_snoop_incoming_arp_reply(struct=
 batadv_priv *bat_priv,
>  }
> =20
>  /**
> + * batadv_dat_check_dhcp_ipudp() - check skb for IP+UDP headers valid =
for DHCP
> + * @skb: the packet to check
> + *
> + * Checks whether the given skb has an IP and UDP header valid for a D=
HCP
> + * message from a DHCP server.
> + *
> + * Return: True if valid, false otherwise.
> + */
> +static bool batadv_dat_check_dhcp_ipudp(struct sk_buff *skb)
> +{
> +	struct iphdr *iphdr, _iphdr;
> +	struct udphdr *udphdr, _udphdr;
> +	unsigned int offset =3D skb_network_offset(skb);
> +
> +	iphdr =3D skb_header_pointer(skb, offset, sizeof(_iphdr), &_iphdr);
> +	if (!iphdr || iphdr->version !=3D 4 || ip_hdrlen(skb) < sizeof(_iphdr=
))
> +		return false;
> +
> +	if (iphdr->protocol !=3D IPPROTO_UDP)
> +		return false;
> +
> +	offset +=3D ip_hdrlen(skb);
> +	skb_set_transport_header(skb, offset);
> +
> +	udphdr =3D skb_header_pointer(skb, offset, sizeof(_udphdr), &_udphdr)=
;
> +	if (!udphdr || udphdr->source !=3D htons(67))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * batadv_dat_check_dhcp() - examine packet for valid DHCP message
> + * @skb: the packet to check
> + * @proto: ethernet protocol hint (behind a potential vlan)
> + *
> + * Checks whether the given skb is a valid DHCP packet.
> + *
> + * Caller needs to ensure that the skb network header is set correctly=
=2E
> + *
> + * Return: If skb is a valid DHCP packet, then returns its op code
> + * (e.g. BOOTREPLY vs. BOOTREQUEST). Otherwise returns -EINVAL.
> + */
> +static int batadv_dat_check_dhcp(struct sk_buff *skb, __be16 proto)
> +{
> +	u8 *op, _op;
> +	u8 *htype, _htype;
> +	u8 *hlen, _hlen;
> +	__be32 *magic, _magic;
> +	unsigned int dhcp_offset;
> +	unsigned int offset;
> +
> +	if (proto !=3D htons(ETH_P_IP))
> +		return -EINVAL;
> +
> +	if (!batadv_dat_check_dhcp_ipudp(skb))
> +		return -EINVAL;
> +
> +	dhcp_offset =3D skb_transport_offset(skb) + sizeof(struct udphdr);
> +	if (skb->len < dhcp_offset + sizeof(struct batadv_dhcp_packet))
> +		return -EINVAL;
> +
> +	offset =3D dhcp_offset + offsetof(struct batadv_dhcp_packet, op);
> +
> +	op =3D skb_header_pointer(skb, offset, sizeof(_op), &_op);
> +	if (!op)
> +		return -EINVAL;
> +
> +	offset =3D dhcp_offset + offsetof(struct batadv_dhcp_packet, htype);
> +
> +	htype =3D skb_header_pointer(skb, offset, sizeof(_htype), &_htype);
> +	if (!htype || *htype !=3D BATADV_HTYPE_ETHERNET)
> +		return -EINVAL;
> +
> +	offset =3D dhcp_offset + offsetof(struct batadv_dhcp_packet, hlen);
> +
> +	hlen =3D skb_header_pointer(skb, offset, sizeof(_hlen), &_hlen);
> +	if (!hlen || *hlen !=3D ETH_ALEN)
> +		return -EINVAL;
> +
> +	offset =3D dhcp_offset + offsetof(struct batadv_dhcp_packet, magic);
> +
> +	magic =3D skb_header_pointer(skb, offset, sizeof(_magic), &_magic);
> +	if (!magic || get_unaligned(magic) !=3D htonl(BATADV_DHCP_MAGIC))
> +		return -EINVAL;
> +
> +	return *op;
> +}
> +
> +/**
> + * batadv_dat_get_dhcp_message_type() - get message type of a DHCP pac=
ket
> + * @skb: the DHCP packet to parse
> + *
> + * Iterates over the DHCP options of the given DHCP packet to find a
> + * DHCP Message Type option and parse it.
> + *
> + * Caller needs to ensure that the given skb is a valid DHCP packet an=
d
> + * that the skb transport header is set correctly.
> + *
> + * Return: The found DHCP message type value, if found. -EINVAL otherw=
ise.
> + */
> +static int batadv_dat_get_dhcp_message_type(struct sk_buff *skb)
> +{
> +	unsigned int offset =3D skb_transport_offset(skb) + sizeof(struct udp=
hdr);
> +	u8 *type, _type;
> +	struct {
> +		u8 type;
> +		u8 len;
> +	} *tl, _tl;
> +
> +	offset +=3D sizeof(struct batadv_dhcp_packet);
> +
> +	while ((tl =3D skb_header_pointer(skb, offset, sizeof(_tl), &_tl))) {=

> +		if (tl->type =3D=3D BATADV_DHCP_OPT_MSG_TYPE)
> +			break;
> +
> +		if (tl->type =3D=3D BATADV_DHCP_OPT_END)
> +			break;
> +
> +		if (tl->type =3D=3D BATADV_DHCP_OPT_PAD)
> +			offset++;
> +		else
> +			offset +=3D tl->len + sizeof(_tl);
> +	}
> +
> +	/* Option Overload Code not supported */
> +	if (!tl || tl->type !=3D BATADV_DHCP_OPT_MSG_TYPE ||
> +	    tl->len !=3D sizeof(_type))
> +		return -EINVAL;
> +
> +	offset +=3D sizeof(_tl);
> +
> +	type =3D skb_header_pointer(skb, offset, sizeof(_type), &_type);
> +	if (!type)
> +		return -EINVAL;
> +
> +	return *type;
> +}
> +
> +/**
> + * batadv_dat_get_dhcp_yiaddr() - get yiaddr from a DHCP packet
> + * @skb: the DHCP packet to parse
> + * @buffer: a buffer to store the yiaddr in (if necessary / skb is non=
-linear)
> + *
> + * Caller needs to ensure that the given skb is a valid DHCP packet an=
d
> + * that the skb transport header is set correctly.
> + *
> + * Return: A safely accessible "Your IP Address" field from the provid=
ed DHCP
> + * packet.
> + */
> +static __be32 *batadv_dat_dhcp_get_yiaddr(struct sk_buff *skb, __be32 =
*buffer)
> +{
> +	unsigned int offset =3D skb_transport_offset(skb) + sizeof(struct udp=
hdr);
> +	unsigned int len =3D sizeof(((struct batadv_dhcp_packet *)0)->yiaddr)=
;
> +
> +	offset +=3D offsetof(struct batadv_dhcp_packet, yiaddr);
> +
> +	return skb_header_pointer(skb, offset, len, buffer);
> +}
> +
> +/**
> + * batadv_dat_get_dhcp_chaddr() - get chaddr from a DHCP packet
> + * @skb: the DHCP packet to parse
> + * @buffer: a buffer to store the chaddr in (if necessary / skb is non=
-linear)
> + *
> + * Caller needs to ensure that the given skb is a valid DHCP packet an=
d
> + * that the skb transport header is set correctly.
> + *
> + * Return: A safely accessible "Client Hardware Address" field from th=
e provided
> + * DHCP packet.
> + */
> +static u8 *batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buffer)=

> +{
> +	unsigned int offset =3D skb_transport_offset(skb) + sizeof(struct udp=
hdr);
> +	unsigned int len =3D sizeof(((struct batadv_dhcp_packet *)0)->chaddr)=
;
> +
> +	offset +=3D offsetof(struct batadv_dhcp_packet, chaddr);
> +
> +	return skb_header_pointer(skb, offset, len, buffer);
> +}
> +
> +/**
> + * batadv_dat_put_pairs() - puts two MAC/IP pairs into the DHT and DAT=
 cache
> + * @bat_priv: the bat priv with all the soft interface information
> + * @hw_src: first value of DHT and ARP sender MAC
> + * @ip_src: first key of DHT and ARP sender IP
> + * @hw_dst: second value of DHT and ARP target MAC
> + * @ip_dst: second key of DHT and ARP target IP
> + * @vid: VLAN identifier
> + *
> + * Adds given MAC/IP pairs to the local DAT cache and propagates them =
further
> + * into the DHT.
> + *
> + * For the DHT propagation, hw_src/ip_src will appear as the ARP Reply=

> + * transmitter (and hw_dst/ip_dst as the target).
> + *
> + * Return: True on success, false otherwise.
> + */
> +static bool batadv_dat_put_pairs(struct batadv_priv *bat_priv, u8 *hw_=
src,
> +				 __be32 ip_src, u8 *hw_dst, __be32 ip_dst,
> +				 unsigned short vid)

Forgive me if we have argued this point before, but why creating a new
function "put_pairs" to tackle something you do once only? Why not just
copying the body of this function at the proper place?

It feels to me you are creating a function for something that is not
really generic...tomorrow we'll have "put_triple" and so on...

> +{
> +	struct sk_buff *skb;
> +	int hdr_size;
> +
> +	skb =3D batadv_dat_arp_create_reply(bat_priv, ip_src, ip_dst, hw_src,=

> +					  hw_dst, vid);
> +	if (!skb)
> +		return false;
> +
> +	/* Check for validity of provided addresses */
> +	skb_set_network_header(skb, ETH_HLEN);
> +	hdr_size =3D skb_network_offset(skb) - ETH_HLEN;
> +
> +	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
> +	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
> +
> +	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT=
);
> +	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT=
);
> +
> +	return true;
> +}
> +
> +/**
> + * batadv_dat_snoop_outgoing_dhcp_ack() - snoop DHCPACK and fill DAT w=
ith it
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the packet to snoop
> + * @proto: ethernet protocol hint (behind a potential vlan)
> + * @vid: VLAN identifier
> + *
> + * This function first checks whether the given skb is a valid DHCPACK=
=2E If
> + * so then its source MAC and IP as well as its DHCP Client Hardware A=
ddress
> + * field and DHCP Your IP Address field are added to the local DAT cac=
he and
> + * propagated into the DHT.
> + *
> + * Caller needs to ensure that the skb mac and network headers are set=

> + * correctly.
> + */
> +void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
> +					struct sk_buff *skb,
> +					__be16 proto,
> +					unsigned short vid)
> +{
> +	int type;
> +	u8 *chaddr, _chaddr[ETH_ALEN];
> +	__be32 *yiaddr, _yiaddr;
> +
> +	if (!atomic_read(&bat_priv->distributed_arp_table))
> +		return;
> +
> +	if (batadv_dat_check_dhcp(skb, proto) !=3D BATADV_BOOTREPLY)
> +		return;
> +
> +	type =3D batadv_dat_get_dhcp_message_type(skb);
> +	if (type !=3D BATADV_DHCPACK)
> +		return;
> +
> +	yiaddr =3D batadv_dat_dhcp_get_yiaddr(skb, &_yiaddr);
> +	if (!yiaddr)
> +		return;
> +
> +	chaddr =3D batadv_dat_get_dhcp_chaddr(skb, _chaddr);
> +	if (!chaddr)
> +		return;
> +
> +	/* ARP sender MAC + IP -> DHCP Client (chaddr+yiaddr),
> +	 * ARP target MAC + IP -> DHCP Server (ethhdr/iphdr sources)
> +	 */
> +	if (!batadv_dat_put_pairs(bat_priv, chaddr, get_unaligned(yiaddr),
> +				  eth_hdr(skb)->h_source, ip_hdr(skb)->saddr,
> +				  vid))
> +		return;
> +
> +	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +		   "Snooped from DHCPACK (server-side): %pI4, %pM (vid: %i)\n",
> +		   &ip_hdr(skb)->saddr, eth_hdr(skb)->h_source,
> +		   batadv_print_vid(vid));
> +	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +		   "Snooped from DHCPACK (client-side): %pI4, %pM (vid: %i)\n",
> +		   yiaddr, chaddr, batadv_print_vid(vid));
> +}
> +
> +/**
>   * batadv_dat_drop_broadcast_packet() - check if an ARP request has to=
 be
>   *  dropped (because the node has already obtained the reply via DAT) =
or not
>   * @bat_priv: the bat priv with all the soft interface information
> diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/di=
stributed-arp-table.h
> index a0459602..cf58d230 100644
> --- a/net/batman-adv/distributed-arp-table.h
> +++ b/net/batman-adv/distributed-arp-table.h
> @@ -46,6 +46,10 @@ void batadv_dat_snoop_outgoing_arp_reply(struct bata=
dv_priv *bat_priv,
>  					 struct sk_buff *skb);
>  bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,=

>  					 struct sk_buff *skb, int hdr_size);
> +void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
> +					struct sk_buff *skb,
> +					__be16 proto,
> +					unsigned short vid);
>  bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
>  				      struct batadv_forw_packet *forw_packet);
> =20
> @@ -140,6 +144,13 @@ batadv_dat_snoop_incoming_arp_reply(struct batadv_=
priv *bat_priv,
>  	return false;
>  }
> =20
> +static inline void
> +batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
> +				   struct sk_buff *skb, __be16 proto,
> +				   unsigned short vid)
> +{
> +}
> +
>  static inline bool
>  batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
>  				 struct batadv_forw_packet *forw_packet)
> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
> index 1485263a..a8559629 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -212,6 +212,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
>  	enum batadv_forw_mode forw_mode;
>  	struct batadv_orig_node *mcast_single_orig =3D NULL;
>  	int network_offset =3D ETH_HLEN;
> +	__be16 proto;
> =20
>  	if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACTIVE)
>  		goto dropped;
> @@ -223,12 +224,15 @@ static netdev_tx_t batadv_interface_tx(struct sk_=
buff *skb,
>  	vid =3D batadv_get_vid(skb, 0);
>  	ethhdr =3D eth_hdr(skb);
> =20
> -	switch (ntohs(ethhdr->h_proto)) {
> +	proto =3D ethhdr->h_proto;
> +
> +	switch (ntohs(proto)) {
>  	case ETH_P_8021Q:
>  		vhdr =3D vlan_eth_hdr(skb);
> +		proto =3D vhdr->h_vlan_encapsulated_proto;
> =20
>  		/* drop batman-in-batman packets to prevent loops */
> -		if (vhdr->h_vlan_encapsulated_proto !=3D htons(ETH_P_BATMAN)) {
> +		if (proto !=3D htons(ETH_P_BATMAN)) {
>  			network_offset +=3D VLAN_HLEN;
>  			break;
>  		}
> @@ -256,6 +260,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
>  			goto dropped;
>  	}
> =20
> +	/* Snoop address candidates from DHCPACKs for early DAT filling */
> +	batadv_dat_snoop_outgoing_dhcp_ack(bat_priv, skb, proto, vid);
> +

I see we snoop and update the DHT only on the "DHCP server" side, when
the DHCP ACK is about to enter the mesh.

However, if you look at the ARP snooping code, you will see that we also
update the local cache upon reception of an ACK REPLY.

Why not doing the same for the DHCP packet? i.e. why not snooping an
incoming DHCP ACK and use it to update the local cache?


>  	/* don't accept stp packets. STP does not help in meshes.
>  	 * better use the bridge loop avoidance ...
>  	 *
>=20


Cheers,

--=20
Antonio Quartulli


--xd7Shl1vUU4IWY9GiSUtBt4HujjdUpw3t--

--JziTUFsPcT36YULziLElBNnkH53wvl4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAluROvoACgkQB6U8WA7y
zXQMNw/+I4wJuPKfT+kUd23BOPv40xhGLkYdZYgDXEPUL+RC61+NNDAF+KOI9anY
4h02imKQDrzH8hKm/hFzSAPp/jEwgUWrUWrUq3baUjAYCgX6lNq+1LBV0b3qPEw4
uUa/vCAZZ3sRytncVFi965YAERiAdpd54xOjrZ1nxiN3he+5vh9evUcqKexja73h
NX+RgdCMv7jIh09JprK0VhHz6vxz1pVSXCSMGdk39xO2QF7IiKpnS2lQs1g2yYLi
m5+B4Jvnng8RbrB/nbtVkQyjQqMeQOMKVguFsfYfaXhQr2DXTYD+3/DGpkq3r3bn
qX6Fsp9jL3/CDCzeUBmDF0aD91cnuqm+DtbKC/Asklf05NU8V3zFgBKzmfts59hN
QORjMJSQriuLeGPOYM1WsxuANaZSfVGydDqt4obLhSR8YziG4jYhst1rBY8D3jbF
Rbu7aL2Mm/NEJzNRhSs27yFdGz1Mv6G8/INXTKjZsl+gOd/EapiI+FTwSZs2dn9w
u7Pu2s6CxPQYT9z6E9QUZk7i5thdZHNgaL8T5g1GbckrPF1J33PsQiIMBrx/K23v
kuZrYp6MEmC5i0J+FcQ+h5I0jiL0RlS1PWSboOzIEGODsiPjNM9irb6/puINl7Rv
23VzM6yKraP2MJtci4g3BdwPmrJkTHGFek8AAAG3xxuICtlWG/4=
=LoCr
-----END PGP SIGNATURE-----

--JziTUFsPcT36YULziLElBNnkH53wvl4MW--
