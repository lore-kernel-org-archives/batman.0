Return-Path: <martin@darmstadt.freifunk.net>
References: <20190119061422.32335-1-linus.luessing@c0d3.blue>
From: Martin Weinelt <martin@darmstadt.freifunk.net>
Message-ID: <9c1313ed-d5d5-1f9c-5443-0a7a009ba550@darmstadt.freifunk.net>
Date: Sat, 19 Jan 2019 14:49:55 +0100
In-Reply-To: <20190119061422.32335-1-linus.luessing@c0d3.blue>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h9Qk6DnFHSsy5nvdPZ8Wq8AmMaJwBkpWp"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast-to-unicast
 support for multiple targets
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h9Qk6DnFHSsy5nvdPZ8Wq8AmMaJwBkpWp
Content-Type: multipart/mixed; boundary="50vKbW2i9tcZrHi2xpjJAQHVB8MR8EQ3l";
 protected-headers="v1"
From: Martin Weinelt <martin@darmstadt.freifunk.net>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <9c1313ed-d5d5-1f9c-5443-0a7a009ba550@darmstadt.freifunk.net>
Subject: Re: [PATCH] batman-adv: Add multicast-to-unicast support for multiple
 targets
References: <20190119061422.32335-1-linus.luessing@c0d3.blue>
In-Reply-To: <20190119061422.32335-1-linus.luessing@c0d3.blue>

--50vKbW2i9tcZrHi2xpjJAQHVB8MR8EQ3l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

Tested-by: Martin Weinelt <martin@darmstadt.freifunk.net>

We've been applying this patch to our testing firmware since april 2018
and have only initially come across issues which were promptly resolved
in a v2.

Best regards,

Martin

On 19.01.19 07:14, Linus L=C3=BCssing wrote:
> With this patch multicast packets with a limited number of destinations=

> (current default: 16) will be split and transmitted by the originator a=
s
> individual unicast transmissions.
>=20
> Wifi broadcasts with their low bitrate are still a costly undertaking.
> In a mesh network this cost multiplies with the overall size of the mes=
h
> network. Therefore using multiple unicast transmissions instead of
> broadcast flooding is almost always less burdensome for the mesh
> network.
>=20
> The maximum amount of unicast packets can be configured via the newly
> introduced multicast_fanout parameter. If this limit is exceeded
> distribution will fall back to classic broadcast flooding.
>=20
> The multicast-to-unicast conversion is performed on the initial
> multicast sender node and counts on a final destination node, mesh-wide=

> basis (and not next hop, neighbor node basis).
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> This patch introduces a new sysfs parameter even though upstream has
> signalized that we should switch to / add netlink support for
> configuration.
>=20
> If upstream were to complain about yet another sysfs-only parameter, I'=
d
> argue that netlink config support is advancing but needs a bit more
> discussion and maturing. And it has no advantage to halt progress in
> other directions for that.
>=20
> Furthermore, there is a bit of urgency for this patch with the
> increasing size of batman-adv mesh networks and the multicast burden
> this creates.
>=20
> Finally, this patch was tested (and as far as I know is still applied)
> in some Freifunk communities. Maybe someone can add a "Tested-by" for
> this patch from there.
>=20
> For my and other people's tests see descriptions here:
>=20
> https://github.com/freifunk-gluon/gluon/pull/1357
>=20
> ---
>  Documentation/ABI/testing/sysfs-class-net-mesh |   9 +
>  net/batman-adv/multicast.c                     | 268 +++++++++++++++++=
+++++++-
>  net/batman-adv/multicast.h                     |  17 ++
>  net/batman-adv/soft-interface.c                |   8 +-
>  net/batman-adv/sysfs.c                         |   3 +
>  net/batman-adv/translation-table.c             |   6 +-
>  net/batman-adv/translation-table.h             |   4 +
>  net/batman-adv/types.h                         |   6 +
>  8 files changed, 315 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-net-mesh b/Documenta=
tion/ABI/testing/sysfs-class-net-mesh
> index c2b956d4..18734a36 100644
> --- a/Documentation/ABI/testing/sysfs-class-net-mesh
> +++ b/Documentation/ABI/testing/sysfs-class-net-mesh
> @@ -76,6 +76,15 @@ Description:
>  		is used to classify clients as "isolated" by the
>  		Extended Isolation feature.
> =20
> +What:           /sys/class/net/<mesh_iface>/mesh/multicast_fanout
> +Date:           Feb 2018
> +Contact:        Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> +Description:
> +                Defines the maximum number of packet copies that may
> +		be generated for a multicast-to-unicast conversion.
> +		Once this limit is exceeded distribution will fall
> +		back to broadcast.
> +
>  What:           /sys/class/net/<mesh_iface>/mesh/multicast_mode
>  Date:           Feb 2014
>  Contact:        Linus L=C3=BCssing <linus.luessing@web.de>
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 5de6a375..d85c2226 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -66,6 +66,7 @@
>  #include "hash.h"
>  #include "log.h"
>  #include "netlink.h"
> +#include "send.h"
>  #include "soft-interface.h"
>  #include "translation-table.h"
>  #include "tvlv.h"
> @@ -992,6 +993,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv=
, struct sk_buff *skb,
>  	int ret, tt_count, ip_count, unsnoop_count, total_count;
>  	bool is_unsnoopable =3D false;
>  	struct ethhdr *ethhdr;
> +	unsigned int mcast_fanout;
> =20
>  	ret =3D batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);=

>  	if (ret =3D=3D -ENOMEM)
> @@ -1025,8 +1027,272 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_=
priv, struct sk_buff *skb,
>  	case 0:
>  		return BATADV_FORW_NONE;
>  	default:
> -		return BATADV_FORW_ALL;
> +		mcast_fanout =3D atomic_read(&bat_priv->multicast_fanout);
> +
> +		if (!unsnoop_count && total_count <=3D mcast_fanout)
> +			return BATADV_FORW_SOME;
>  	}
> +
> +	return BATADV_FORW_ALL;
> +}
> +
> +/**
> + * batadv_mcast_forw_tt_send() - send a packet to multicast listeners
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any multicast=

> + * listener registered in the translation table. A transmission is per=
formed
> + * via a batman-adv unicast packet for each such destination node.
> + *
> + * Return: NET_XMIT_DROP if limit was reached or on memory allocation =
failure,
> + * NET_XMIT_SUCCESS otherwise.
> + */
> +static int
> +batadv_mcast_forw_tt_send(struct batadv_priv *bat_priv, struct sk_buff=
 *skb,
> +			  unsigned short vid, unsigned int *limit)
> +{
> +	unsigned int limit_tmp =3D *limit;
> +	int ret =3D NET_XMIT_SUCCESS;
> +	struct sk_buff *newskb;
> +
> +	struct batadv_tt_orig_list_entry *orig_entry;
> +
> +	struct batadv_tt_global_entry *tt_global;
> +	const u8 *addr =3D eth_hdr(skb)->h_dest;
> +
> +	tt_global =3D batadv_tt_global_hash_find(bat_priv, addr, vid);
> +	if (!tt_global)
> +		return NET_XMIT_DROP;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(orig_entry, &tt_global->orig_list, list) {
> +		if (!limit_tmp) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		newskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!newskb) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		ret =3D batadv_send_skb_unicast(bat_priv, newskb,
> +					      BATADV_UNICAST, 0,
> +					      orig_entry->orig_node, vid);
> +
> +		if (ret !=3D NET_XMIT_SUCCESS) {
> +			/* use kfree_skb() to signalize losses here, but keep
> +			 * trying other destinations
> +			 */
> +			kfree_skb(newskb);
> +			ret =3D NET_XMIT_SUCCESS;
> +		}
> +
> +		limit_tmp--;
> +	}
> +	rcu_read_unlock();
> +
> +	batadv_tt_global_entry_put(tt_global);
> +	*limit =3D limit_tmp;
> +
> +	return ret;
> +}
> +
> +/**
> + * batadv_mcast_forw_want_all_ipv4_send() - send to nodes with want-al=
l-ipv4
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node with=
 a
> + * BATADV_MCAST_WANT_ALL_IPV4 flag set. A transmission is performed vi=
a a
> + * batman-adv unicast packet for each such destination node.
> + *
> + * Return: NET_XMIT_DROP if limit was reached or on memory allocation =
failure,
> + * NET_XMIT_SUCCESS otherwise.
> + */
> +static int
> +batadv_mcast_forw_want_all_ipv4_send(struct batadv_priv *bat_priv,
> +				     struct sk_buff *skb, unsigned short vid,
> +				     unsigned int *limit)
> +{
> +	struct batadv_orig_node *orig_node;
> +	unsigned int limit_tmp =3D *limit;
> +	int ret =3D NET_XMIT_SUCCESS;
> +	struct sk_buff *newskb;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(orig_node,
> +				 &bat_priv->mcast.want_all_ipv4_list,
> +				 mcast_want_all_ipv4_node) {
> +		if (!limit_tmp) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		newskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!newskb) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		ret =3D batadv_send_skb_unicast(bat_priv, newskb,
> +					      BATADV_UNICAST, 0,
> +					      orig_node, vid);
> +
> +		if (ret !=3D NET_XMIT_SUCCESS) {
> +			/* use kfree_skb() to signalize losses here, but keep
> +			 * trying other destinations
> +			 */
> +			kfree_skb(newskb);
> +			ret =3D NET_XMIT_SUCCESS;
> +		}
> +
> +		limit_tmp--;
> +	}
> +	rcu_read_unlock();
> +
> +	*limit =3D limit_tmp;
> +	return ret;
> +}
> +
> +/**
> + * batadv_mcast_forw_want_all_ipv6_send() - send to nodes with want-al=
l-ipv6
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: The multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node with=
 a
> + * BATADV_MCAST_WANT_ALL_IPV6 flag set. A transmission is performed vi=
a a
> + * batman-adv unicast packet for each such destination node.
> + *
> + * Return: NET_XMIT_DROP if limit was reached or on memory allocation =
failure,
> + * NET_XMIT_SUCCESS otherwise.
> + */
> +static int
> +batadv_mcast_forw_want_all_ipv6_send(struct batadv_priv *bat_priv,
> +				     struct sk_buff *skb, unsigned short vid,
> +				     unsigned int *limit)
> +{
> +	struct batadv_orig_node *orig_node;
> +	unsigned int limit_tmp =3D *limit;
> +	int ret =3D NET_XMIT_SUCCESS;
> +	struct sk_buff *newskb;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(orig_node,
> +				 &bat_priv->mcast.want_all_ipv6_list,
> +				 mcast_want_all_ipv6_node) {
> +		if (!limit_tmp) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		newskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!newskb) {
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		ret =3D batadv_send_skb_unicast(bat_priv, newskb,
> +					      BATADV_UNICAST, 0,
> +					      orig_node, vid);
> +
> +		if (ret !=3D NET_XMIT_SUCCESS) {
> +			/* use kfree_skb() to signalize losses here, but keep
> +			 * trying other destinations
> +			 */
> +			kfree_skb(newskb);
> +			ret =3D NET_XMIT_SUCCESS;
> +		}
> +
> +		limit_tmp--;
> +	}
> +	rcu_read_unlock();
> +
> +	*limit =3D limit_tmp;
> +	return ret;
> +}
> +
> +/**
> + * batadv_mcast_forw_want_all_send() - send packet to nodes in a want-=
all list
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node with=
 a
> + * BATADV_MCAST_WANT_ALL_IPV4 or BATADV_MCAST_WANT_ALL_IPV6 flag set. =
A
> + * transmission is performed via a batman-adv unicast packet for each =
such
> + * destination node.
> + *
> + * Return: NET_XMIT_DROP if limit was reached, on memory allocation fa=
ilure
> + * or if the protocol family is neither IPv4 nor IPv6. NET_XMIT_SUCCES=
S
> + * otherwise.
> + */
> +static int
> +batadv_mcast_forw_want_all_send(struct batadv_priv *bat_priv,
> +				struct sk_buff *skb, unsigned short vid,
> +				unsigned int *limit)
> +{
> +	switch (ntohs(eth_hdr(skb)->h_proto)) {
> +	case ETH_P_IP:
> +		return batadv_mcast_forw_want_all_ipv4_send(bat_priv, skb, vid,
> +							    limit);
> +	case ETH_P_IPV6:
> +		return batadv_mcast_forw_want_all_ipv6_send(bat_priv, skb, vid,
> +							    limit);
> +	default:
> +		/* we shouldn't be here... */
> +		return NET_XMIT_DROP;
> +	}
> +}
> +
> +/**
> + * batadv_mcast_forw_send() - send packet to any detected multicast re=
cpient
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node that=
 signaled
> + * interest in it, that is either via the translation table or the acc=
ording
> + * want-all flags. A transmission is performed via a batman-adv unicas=
t packet
> + * for each such destination node.
> + *
> + * If NET_XMIT_DROP is returned then caller needs to free the provided=
 skb.
> + * Otherwise it is consumed.
> + *
> + * Return: NET_XMIT_DROP if limit was reached, on memory allocation fa=
ilure
> + * or if the protocol family is neither IPv4 nor IPv6. NET_XMIT_SUCCES=
S
> + * otherwise.
> + */
> +int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buf=
f *skb,
> +			   unsigned short vid)
> +{
> +	/* The previous forw mode check will try to limit to the configured
> +	 * fanout. Here, we allow a little bit of flexibility in case some
> +	 * new listeners might have joined between these function calls.
> +	 */
> +	unsigned int limit =3D 2 * atomic_read(&bat_priv->multicast_fanout);
> +	int ret;
> +
> +	ret =3D batadv_mcast_forw_tt_send(bat_priv, skb, vid, &limit);
> +	if (ret !=3D NET_XMIT_SUCCESS)
> +		return ret;
> +
> +	ret =3D batadv_mcast_forw_want_all_send(bat_priv, skb, vid, &limit);
> +	if (ret !=3D NET_XMIT_SUCCESS)
> +		return ret;
> +
> +	consume_skb(skb);
> +	return ret;
>  }
> =20
>  /**
> diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
> index 466013fe..24424e51 100644
> --- a/net/batman-adv/multicast.h
> +++ b/net/batman-adv/multicast.h
> @@ -36,6 +36,13 @@ enum batadv_forw_mode {
>  	BATADV_FORW_ALL,
> =20
>  	/**
> +	 * @BATADV_FORW_SOME: forward the packet to some nodes (currently via=

> +	 *  a multicast-to-unicast conversion and the BATMAN unicast routing
> +	 *  protocol)
> +	 */
> +	BATADV_FORW_SOME,
> +
> +	/**
>  	 * @BATADV_FORW_SINGLE: forward the packet to a single node (currentl=
y
>  	 *  via the BATMAN unicast routing protocol)
>  	 */
> @@ -51,6 +58,9 @@ enum batadv_forw_mode
>  batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *s=
kb,
>  		       struct batadv_orig_node **mcast_single_orig);
> =20
> +int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buf=
f *skb,
> +			   unsigned short vid);
> +
>  void batadv_mcast_init(struct batadv_priv *bat_priv);
> =20
>  int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offs=
et);
> @@ -73,6 +83,13 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv,=
 struct sk_buff *skb,
>  	return BATADV_FORW_ALL;
>  }
> =20
> +static inline int
> +batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *s=
kb,
> +		       unsigned short vid)
> +{
> +	return NET_XMIT_DROP;
> +}
> +
>  static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
>  {
>  	return 0;
> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
> index 5357dcae..9adb9ad1 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -209,7 +209,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
>  	unsigned short vid;
>  	u32 seqno;
>  	int gw_mode;
> -	enum batadv_forw_mode forw_mode;
> +	enum batadv_forw_mode forw_mode =3D BATADV_FORW_SINGLE;
>  	struct batadv_orig_node *mcast_single_orig =3D NULL;
>  	int network_offset =3D ETH_HLEN;
> =20
> @@ -308,7 +308,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
>  			if (forw_mode =3D=3D BATADV_FORW_NONE)
>  				goto dropped;
> =20
> -			if (forw_mode =3D=3D BATADV_FORW_SINGLE)
> +			if (forw_mode =3D=3D BATADV_FORW_SINGLE ||
> +			    forw_mode =3D=3D BATADV_FORW_SOME)
>  				do_bcast =3D false;
>  		}
>  	}
> @@ -368,6 +369,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
>  			ret =3D batadv_send_skb_unicast(bat_priv, skb,
>  						      BATADV_UNICAST, 0,
>  						      mcast_single_orig, vid);
> +		} else if (forw_mode =3D=3D BATADV_FORW_SOME) {
> +			ret =3D batadv_mcast_forw_send(bat_priv, skb, vid);
>  		} else {
>  			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
>  								  skb))
> @@ -809,6 +812,7 @@ static int batadv_softif_init_late(struct net_devic=
e *dev)
>  	bat_priv->mcast.querier_ipv6.shadowing =3D false;
>  	bat_priv->mcast.flags =3D BATADV_NO_FLAGS;
>  	atomic_set(&bat_priv->multicast_mode, 1);
> +	atomic_set(&bat_priv->multicast_fanout, 16);
>  	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
>  	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
>  	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
> diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
> index e1b81626..15c06b4c 100644
> --- a/net/batman-adv/sysfs.c
> +++ b/net/batman-adv/sysfs.c
> @@ -697,6 +697,8 @@ static BATADV_ATTR(gw_bandwidth, 0644, batadv_show_=
gw_bwidth,
>  		   batadv_store_gw_bwidth);
>  #ifdef CONFIG_BATMAN_ADV_MCAST
>  BATADV_ATTR_SIF_BOOL(multicast_mode, 0644, NULL);
> +BATADV_ATTR_SIF_UINT(multicast_fanout, multicast_fanout, 0644, 1, INT_=
MAX,
> +		     NULL);
>  #endif
>  #ifdef CONFIG_BATMAN_ADV_DEBUG
>  BATADV_ATTR_SIF_UINT(log_level, log_level, 0644, 0, BATADV_DBG_ALL, NU=
LL);
> @@ -718,6 +720,7 @@ static struct batadv_attribute *batadv_mesh_attrs[]=
 =3D {
>  #endif
>  #ifdef CONFIG_BATMAN_ADV_MCAST
>  	&batadv_attr_multicast_mode,
> +	&batadv_attr_multicast_fanout,
>  #endif
>  	&batadv_attr_fragmentation,
>  	&batadv_attr_routing_algo,
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> index f73d7913..8f83554b 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -61,6 +61,7 @@
>  #include "log.h"
>  #include "netlink.h"
>  #include "originator.h"
> +#include "send.h"
>  #include "soft-interface.h"
>  #include "tvlv.h"
> =20
> @@ -205,7 +206,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_p=
riv, const u8 *addr,
>   * Return: a pointer to the corresponding tt_global_entry struct if th=
e client
>   * is found, NULL otherwise.
>   */
> -static struct batadv_tt_global_entry *
> +struct batadv_tt_global_entry *
>  batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *add=
r,
>  			   unsigned short vid)
>  {
> @@ -300,8 +301,7 @@ static void batadv_tt_global_entry_release(struct k=
ref *ref)
>   *  possibly release it
>   * @tt_global_entry: tt_global_entry to be free'd
>   */
> -static void
> -batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_en=
try)
> +void batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_glob=
al_entry)
>  {
>  	kref_put(&tt_global_entry->common.refcount,
>  		 batadv_tt_global_entry_release);
> diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/transl=
ation-table.h
> index 61bca75e..5b41f217 100644
> --- a/net/batman-adv/translation-table.h
> +++ b/net/batman-adv/translation-table.h
> @@ -41,6 +41,10 @@ int batadv_tt_global_dump(struct sk_buff *msg, struc=
t netlink_callback *cb);
>  void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
>  			       struct batadv_orig_node *orig_node,
>  			       s32 match_vid, const char *message);
> +struct batadv_tt_global_entry *
> +batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *add=
r,
> +			   unsigned short vid);
> +void batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_glob=
al_entry);
>  int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
>  				const u8 *addr, unsigned short vid);
>  struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *=
bat_priv,
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index a21b34ed..d22cf01e 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1565,6 +1565,12 @@ struct batadv_priv {
>  	 *  node's sender/originating side
>  	 */
>  	atomic_t multicast_mode;
> +
> +	/**
> +	 * @multicast_fanout: Maximum number of packet copies to generate for=
 a
> +	 *  multicast-to-unicast conversion
> +	 */
> +	atomic_t multicast_fanout;
>  #endif
> =20
>  	/** @orig_interval: OGM broadcast interval in milliseconds */
>=20



--50vKbW2i9tcZrHi2xpjJAQHVB8MR8EQ3l--

--h9Qk6DnFHSsy5nvdPZ8Wq8AmMaJwBkpWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE7tAWAry9GWw4vJofvUqgUo9j8X4FAlxDKwYACgkQvUqgUo9j
8X4SFgf/WnqLS/noq4/vsoHcsfblEodpBY5Ck0/hgTM9KRS2mLiGs+pN9i4hIIWV
Aawqr9tB9nAfoV6s98XSTlm5cW9wJQEKt84fzQApRZIi+XAfbbV9Dv1n3zfyzwbR
ZoNXalEChoTB3h4mkPT4VLDbJq7mO+hXxvqvTdBdQUNML4RgAqpQkq/3YYbwRDMu
7nKX6AqryQrq4mRshjZrMtsHWMkvIsqSDUxfQ2DI6JUby1dgkjT+IIboWyyxMZNs
qT8ruC0PlKMDm3SzYIB2Q9IKZGHgaTG/dc7/LtvUlSxesbdJYRiOjR1hpF8ajWoJ
s5Rhr5XPflaBdm/xHJTe7/Sa0c4J6Q==
=emT+
-----END PGP SIGNATURE-----

--h9Qk6DnFHSsy5nvdPZ8Wq8AmMaJwBkpWp--
