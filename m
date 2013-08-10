Return-Path: <ordex@autistici.org>
Date: Sat, 10 Aug 2013 14:20:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130810122055.GC849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-4-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <1373242365-763-4-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 4/6] batman-adv: Adds necessary functions
 for NDP,
 like checking if a packet is valid or creating a Neighbor Advertisement
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 03:12:43AM +0300, mihail.costea2005@gmail.com wrote:
> From: Mihail Costea <mihail.costea90@gmail.com>
>=20
> Adds functions needed for NDP snooping, like getting the IPv6 addresses
> or getting the target HW address from an Neighbor Advertisement (NA).

typo: an -> a

> Also added functions to create NA for Neighbor Solicitations

use always the same form: added -> adds

> that have already the HW address in DAT.
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>  distributed-arp-table.c |  319 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 319 insertions(+)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index f941913..d0b9e95 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -20,7 +20,9 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_vlan.h>
> +#include <net/addrconf.h>
>  #include <net/arp.h>
> +#include <net/ipv6.h>
> =20
>  #include "main.h"
>  #include "hash.h"
> @@ -981,6 +983,323 @@ static unsigned short batadv_dat_get_vid(struct sk_=
buff *skb, int *hdr_size)
>  	return vid;
>  }
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +/**
> + * batadv_ndisc_hw_src - get source hw address from a packet
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns source hw address of the skb packet.
> + */
> +static uint8_t *batadv_ndisc_hw_src(struct sk_buff *skb, int hdr_size)
> +{
> +	struct ethhdr *ethhdr;

please put a blank line after variable declarations.

> +	ethhdr =3D (struct ethhdr *)(skb->data + hdr_size);
> +	return (uint8_t *)ethhdr->h_source;
> +}
> +
> +/**
> + * batadv_ndisc_hw_dst - get destination hw address from a packet
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns destination hw address of the skb packet.
> + */
> +static uint8_t *batadv_ndisc_hw_dst(struct sk_buff *skb, int hdr_size)
> +{
> +	struct ethhdr *ethhdr;

same here

> +	ethhdr =3D (struct ethhdr *)(skb->data + hdr_size);
> +	return (uint8_t *)ethhdr->h_dest;
> +}
> +
> +/**
> + * batadv_ndisc_ipv6_src - get source IPv6 address from a packet
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns source IPv6 address of the skb packet.
> + */
> +static struct in6_addr *batadv_ndisc_ipv6_src(struct sk_buff *skb,
> +					      int hdr_size)
> +{
> +	struct ipv6hdr *ipv6hdr;

same here

> +	ipv6hdr =3D (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
> +	return &ipv6hdr->saddr;
> +}
> +
> +/**
> + * batadv_ndisc_ipv6_dst - get destination IPv6 address from a packet
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns destination IPv6 address of the skb packet.
> + */
> +static struct in6_addr *batadv_ndisc_ipv6_dst(struct sk_buff *skb,
> +					      int hdr_size)
> +{
> +	struct ipv6hdr *ipv6hdr;

same here

> +	ipv6hdr =3D (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
> +	return &ipv6hdr->daddr;
> +}
> +
> +/**
> + * batadv_ndisc_ipv6_target - get target IPv6 address from a NS/NA packet
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns target IPv6 address of the skb packet.
> + */
> +static struct in6_addr *batadv_ndisc_ipv6_target(struct sk_buff *skb,
> +						 int hdr_size)
> +{
> +	return (struct in6_addr *)(skb->data + hdr_size + ETH_HLEN +
> +			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));

please, use the needed local variables to make this statement more readable=
 and
and to align it in a proper way.

> +}
> +
> +/**
> + * batadv_ndisc_hw_opt - get hw address from NS/NA packet options
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + * @type: type of the address (ND_OPT_SOURCE_LL_ADDR or ND_OPT_TARGET_LL=
_ADDR)
> + *
> + * The address can be either the source link-layer address
> + * or the target link-layer address.
> + * For more info see RFC2461.
> + *
> + * Returns hw address from packet options.
> + */
> +static uint8_t *batadv_ndisc_hw_opt(struct sk_buff *skb, int hdr_size,
> +				    uint8_t type)
> +{
> +	unsigned char *opt_addr;
> +
> +	opt_addr =3D skb->data + hdr_size + ETH_HLEN +
> +			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr) +
> +			sizeof(struct in6_addr);
> +

align this statement properly. it should be:

like_this =3D this + that +
	    and_whatever +
	    we_need;

> +	/* test if option header is ok */

Please, be a bit more verbose in this comment. What are we checking here?=
=20
why !=3D 1? What does that mean? Otherwise it will be difficult for other p=
eople
out of these patches business to understand

> +	if (*opt_addr !=3D type || *(opt_addr + 1) !=3D 1)
> +		return NULL;
> +	return (uint8_t *)(opt_addr + 2);

and why skipping the initial two bytes? Maybe you should describe what opt_=
addr
contains? this will probably help to better understand what this statement =
is
doing.

> +}
> +
> +/**
> + * batadv_ndisc_get_type - get icmp6 packet type

I think you can directly call this function "batadv_icmpv6_get_type".
It may be re-used in the future for the same purpose but somewhere else :)

> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + *
> + * Returns the icmp6 type, or 0 if packet is not a valid icmp6 packet.
> + */
> +static __u8 batadv_ndisc_get_type(struct batadv_priv *bat_priv,

in the batman-adv code we use stdint: __u8 -> uint8_t (there are other spots
where you use __8)

> +				  struct sk_buff *skb, int hdr_size)
> +{
> +	struct ethhdr *ethhdr;
> +	struct ipv6hdr *ipv6hdr;
> +	struct icmp6hdr *icmp6hdr;
> +	__u8 type =3D 0;
> +
> +	/* pull headers */
> +	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
> +			sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))))

please properly align this statement too. I think checkpatch would have
complained about this. You can use tabs + spaces to correctly align.

> +		goto out;
> +
> +	/* get the ethernet header */

remove this comment :) Variables are named properly and this is obvious.

> +	ethhdr =3D (struct ethhdr *)(skb->data + hdr_size);
> +	if (ethhdr->h_proto !=3D htons(ETH_P_IPV6))
> +		goto out;
> +
> +	/* get the ipv6 header */

same

> +	ipv6hdr =3D (struct ipv6hdr *)(skb->data + hdr_size + ETH_HLEN);
> +	if (ipv6hdr->nexthdr !=3D IPPROTO_ICMPV6)
> +		goto out;
> +
> +	/* get the icmpv6 header */
> +	icmp6hdr =3D (struct icmp6hdr *)(skb->data + hdr_size + ETH_HLEN +
> +			sizeof(struct ipv6hdr));

alignment..should line up to the opening parenthesis.

(blablabla *)(like
	      this);

> +
> +	/* check whether the ndisc packet carries a valid icmp6 header */
> +	if (ipv6hdr->hop_limit !=3D 255)
> +		goto out;
> +
> +	if (icmp6hdr->icmp6_code !=3D 0)
> +		goto out;
> +
> +	type =3D icmp6hdr->icmp6_type;
> +out:
> +	return type;
> +}
> +
> +/**
> + * batadv_ndisc_is_valid - check if a ndisc packet is valid
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: packet to check
> + * @hdr_size: size of the encapsulation header
> + * @ndisc_type: type of ndisc packet to check
> + *
> + * Check if all IPs are valid (source, destination, target) and if
> + * options hw address is valid too.
> + * Some options might be ignored, like NS packets sent automatically
> + * for verification of the reachability of a neighbor.
> + *
> + * Returns true if packet is valid, otherwise false if invalid or ignore=
d.
> + */
> +static bool batadv_ndisc_is_valid(struct batadv_priv *bat_priv,
> +				  struct sk_buff *skb, int hdr_size,
> +				  int ndisc_type)
> +{
> +	uint8_t *hw_target =3D NULL;
> +	struct in6_addr *ipv6_src, *ipv6_dst, *ipv6_target;
> +	__u8 type =3D batadv_ndisc_get_type(bat_priv, skb, hdr_size);
> +	int ndisc_hdr_len =3D hdr_size + ETH_HLEN + sizeof(struct ipv6hdr) +
> +			    sizeof(struct icmp6hdr) + sizeof(struct in6_addr) +
> +			    8; /* ndisc options length */

when the assignment is too long, please do it after the declarations. Impro=
ves
readability.


> +
> +	if (type !=3D ndisc_type)
> +		return false;
> +	if (unlikely(!pskb_may_pull(skb, ndisc_hdr_len)))
> +		return false;
> +
> +	/* Check for bad NA/NS. If the ndisc message is not sane, DAT
> +	 * will simply ignore it
> +	 */
> +	if (type =3D=3D NDISC_NEIGHBOUR_SOLICITATION)
> +		hw_target =3D batadv_ndisc_hw_opt(skb, hdr_size,
> +						ND_OPT_SOURCE_LL_ADDR);
> +	else if (type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT)
> +		hw_target =3D batadv_ndisc_hw_opt(skb, hdr_size,
> +						ND_OPT_TARGET_LL_ADDR);
> +
> +	if (!hw_target || is_zero_ether_addr(hw_target) ||
> +	    is_multicast_ether_addr(hw_target))
> +		return false;
> +
> +	ipv6_src =3D batadv_ndisc_ipv6_src(skb, hdr_size);
> +	ipv6_dst =3D batadv_ndisc_ipv6_dst(skb, hdr_size);
> +	ipv6_target =3D batadv_ndisc_ipv6_target(skb, hdr_size);
> +	if (ipv6_addr_loopback(ipv6_src) || ipv6_addr_loopback(ipv6_dst) ||
> +	    ipv6_addr_is_multicast(ipv6_src) ||
> +	    ipv6_addr_is_multicast(ipv6_target))
> +		return false;
> +
> +	/* ignore messages with unspecified address */
> +	if (ipv6_addr_any(ipv6_src) || ipv6_addr_any(ipv6_dst) ||
> +	    ipv6_addr_any(ipv6_target))
> +		return false;
> +
> +	/* ignore the verification of the reachability of a neighbor */
> +	if (type =3D=3D NDISC_NEIGHBOUR_SOLICITATION &&
> +	    !ipv6_addr_is_multicast(ipv6_dst))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void batadv_ndisc_ip6_hdr(struct sock *sk, struct sk_buff *skb,
> +				 struct net_device *dev,
> +				 const struct in6_addr *ipv6_src,
> +				 const struct in6_addr *ipv6_dst,
> +				 int proto, int len)

alignment?

> +{
> +	struct ipv6_pinfo *np =3D inet6_sk(sk);
> +	struct ipv6hdr *hdr;
> +
> +	skb->protocol =3D htons(ETH_P_IPV6);
> +	skb->dev =3D dev;
> +
> +	skb_reset_network_header(skb);
> +	skb_put(skb, sizeof(struct ipv6hdr));
> +	hdr =3D ipv6_hdr(skb);
> +
> +	*(__be32 *)hdr =3D htonl(0x60000000);

What does this constant mean? you are writing on the IPv6 header?
why not writing in one of its fields (I guess you wanted to write in the fi=
rst
one)?

> +
> +	hdr->payload_len =3D htons(len);

I think len can be declared int16_t to avoid using wrong values?
(here and where you call this function)

> +	hdr->nexthdr =3D proto;
> +	hdr->hop_limit =3D np->hop_limit;
> +
> +	hdr->saddr =3D *ipv6_src;
> +	hdr->daddr =3D *ipv6_dst;
> +}
> +
> +/**
> + * batadv_ndisc_create_na - create an NA for a solicited NS
> + * @net_device: the devices for which the packet is created
> + * @ipv6_dst: destination IPv6
> + * @ipv6_target: target IPv6 (same with source IPv6)
> + * @hw_dst: destination HW Address
> + * @hw_target: target HW Address (same with source HW Address)
> + * @router: 1 if target is a router, else 0
> + * @solicited: 1 if this is a solicited NA, else 0
> + * @override: 1 if the target entry should be override, else 0
> + *
> + * For more info see RFC2461.

If you want to cite the RFC think you should provide also a section?
The "Neighbor Discovery for IP Version 6" RFC is a bit too much is I only w=
ant
to understand what a NA or NS is and how the NA is created.

By the way, ok for reading the RFC, but I think you can write a bit more ab=
out
what the function is doing: e.g. create a new skb containing an NA which fi=
elds
are initialised with the value passed as argument. Seems obvious, but better
safe than sorry :) Kernel Doc is shown without the code if you compile it.

> + *
> + * Returns the newly created skb, otherwise NULL.
> + */
> +static struct
> +sk_buff *batadv_ndisc_create_na(struct net_device *dev,
> +				const struct in6_addr *ipv6_dst,
> +				const struct in6_addr *ipv6_target,
> +				const uint8_t *hw_dst,
> +				const uint8_t *hw_target,
> +				int router, int solicited, int override)

if these variables can only be 0 or 1, why not using bool?

> +{
> +	struct net *net =3D dev_net(dev);
> +	struct sock *sk =3D net->ipv6.ndisc_sk;
> +	struct sk_buff *skb;
> +	struct icmp6hdr *icmp6hdr;
> +	int hlen =3D LL_RESERVED_SPACE(dev);
> +	int tlen =3D dev->needed_tailroom;
> +	int len, err;
> +	u8 *opt;

uint8_t

> +
> +	/* alloc space for skb */
> +	len =3D sizeof(struct icmp6hdr) + sizeof(*ipv6_target) + 8;

write in the comment what is this 8. Otherwise, since you use it more than =
once,
create a define with a descriptive name and it instead of the 8.

> +	skb =3D sock_alloc_send_skb(sk,
> +				  (MAX_HEADER + sizeof(struct ipv6hdr) +

					why these parenthesis here?

> +				   len + hlen + tlen),

I guess hlen is ETH_HLEN? what does LL_RESERVED_SPACE exactly return?
and why using needed_tailroom? what does it comport in this case?
We never used that during SKB allocation...this is why I am asking.

> +				  1, &err);

and why are you using this function to allocate the skb? In the rest of the=
 code
we always use netdev_alloc_skb_ip_align() (that also takes care of properly
aligning the skb).

> +	if (!skb)
> +		return NULL;
> +
> +	skb_reserve(skb, hlen);
> +	batadv_ndisc_ip6_hdr(sk, skb, dev, ipv6_target, ipv6_dst,
> +			     IPPROTO_ICMPV6, len);
> +
> +	skb->transport_header =3D skb->tail;

why you care about setting the transport header?
You could also use skb_set_transport_header() passing a proper offset rather
than directly using skb->tail. Following the skb logic is "sometimes" not
straightforward, therefore it is better to use the provided functions when
possible.

> +	skb_put(skb, len);
> +
> +	/* fill the device header for the NA frame */
> +	if (dev_hard_header(skb, dev, ETH_P_IPV6, hw_dst,
> +			    hw_target, skb->len) < 0) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}

mh..we never used this function as we assume that the interface below batma=
n-adv
is carrying 802.3 frame only. But looks interesting :)

> +
> +	/* set icmpv6 header */
> +	icmp6hdr =3D (struct icmp6hdr *)skb_transport_header(skb);

ah now I understood why you have set the transport_header :)

> +	icmp6hdr->icmp6_type =3D NDISC_NEIGHBOUR_ADVERTISEMENT;
> +	icmp6hdr->icmp6_router =3D router;
> +	icmp6hdr->icmp6_solicited =3D solicited;
> +	icmp6hdr->icmp6_override =3D override;
> +
> +	/* set NA target and options */
> +	opt =3D skb_transport_header(skb) + sizeof(*icmp6hdr);
> +	*(struct in6_addr *)opt =3D *ipv6_target;
> +	opt +=3D sizeof(*ipv6_target);
> +
> +	opt[0] =3D ND_OPT_TARGET_LL_ADDR;
> +	opt[1] =3D 1;
> +	memcpy(opt + 2, hw_target, dev->addr_len);

ah, these are the famous 8 bytes :) So hard to discover! :D

> +
> +	icmp6hdr->icmp6_cksum =3D csum_ipv6_magic(ipv6_target, ipv6_dst, len,
> +						IPPROTO_ICMPV6,
> +						csum_partial(icmp6hdr, len, 0));
> +
> +	return skb;
> +}
> +#endif
> +
>  /**
>   * batadv_dat_snoop_outgoing_pkt_request - snoop the ARP request and try=
 to
>   * answer using DAT
> --=20
> 1.7.10.4

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSBjAnAAoJEADl0hg6qKeOhY0P/0kR74EIYHtloMt2J5w/JB7n
M959hsM5b1HiqgJVNTj/JNfJ2ZQmzKVGdjkDdTvo9oRr39k1NEkvaQG+BSfEr5aM
3lfksa0qfBeFUaBF7U7kaH69EiSkg5hNyKqSklyJuyf1iggpdfQYd/mCwceJUxXE
6PFpOGingizXgov6NggPnEnhzqZqcdDBRKJZ9vLcCzqPYbxmVH1xlNTuXbxCF8m5
qPMffOMMSb7Rp5rH+hFmdzganoW8IMXKuHwlNHVat/38osKIHBKnUuC2rU2+PdsM
8lL2yx6io4bZS+ITiYnkx6LADp8vvsl7KAo8uVYCfzbsroxRbKfaRDBqp5vRZLUC
/OM4PcxafUb94501K2SQ+rEDTo3o8mvZAoQby6DgEgYcL2r03lRNDZ5fnnbxsqKe
Qjw/TAGJbwVHldmpVg3KwezUuOCq2kVlJetDdstZHbGTBq3BOqweVQne+NErYIS7
l6eMAsBtLTCNhH/jH7AGQGG/vBh7frueGQ9dJd0nJ6UEEmlwIdeFvKg/qjbIB4Mr
0srChEZ0WWgI+oYobaYMWczIuGOwy37Xac3LH5lCv6wjFWBMLDfLQbz5lUZ7ldyK
MnyptnOuZGynS8pGhzPGz1icMSUeRylH7IHNMFA1C4FzLLxZqnPs/QyghoWW+py/
i9TsLswliVWQ5vpTNEYc
=/j16
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
